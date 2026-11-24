#!/bin/bash
# attendre-deploiement.sh — vérifie le workflow et l'étape de publication
# attendus pour un commit. Règle : `deploiement.md` de MD-LIB.
# Né le 13/10/2026 : deux déploiements rouges de NextStep annoncés « en ligne »
# sans vérification.
#
# Usages :
#   attendre-deploiement.sh [dossier-du-depot] [branche|sha] [workflow tâche étape]
#       Défauts : dossier courant, main, puis le workflow du dépôt qui publie
#       par `actions/deploy-pages` s'il est unique, sinon le workflow
#       automatique de GitHub Pages. Pour un autre cas, préciser son chemin,
#       la tâche et l'étape.
#       Codes : 0 publication vérifiée, 1 échec, 2 délai dépassé,
#       3 publication non vérifiée.
#   attendre-deploiement.sh --hook
#       hook PostToolUse (Bash) installé par le script de démarrage de
#       l'environnement (voir deploiement.md). Après une commande contenant
#       `git push`, cherche dans les dépôts voisins de MD-LIB ceux dont une
#       branche publiée (main, master, sandbox, gh-pages) vient d'être
#       poussée, vérifie GitHub Pages et renvoie le résultat à Claude.
#
# Dépend de : git, curl, python3. Utilise $GITHUB_TOKEN s'il existe (sinon
# l'API publique, limitée à 60 appels par heure).

RACINE="$(dirname "$(cd "$(dirname "$0")/.." && pwd)")"  # dossier qui contient MD-LIB
DELAI=${ATTENTE_DEPLOIEMENT_MAX:-480}     # secondes avant d'abandonner
SANS_WORKFLOW=${ATTENTE_SANS_WORKFLOW:-90} # aucun workflow après ça : rien à attendre
FENETRE=${ATTENTE_FENETRE:-300}           # un push plus ancien n'est pas « celui-ci »
BRANCHES="main master sandbox gh-pages"
PAS=20

# Workflow propre au dépôt qui publie GitHub Pages (`uses: actions/deploy-pages`) :
# affiche son chemin, sa tâche et son étape (une ligne chacun) s'il est unique,
# rien sinon. Lecture ligne à ligne, sans module YAML (24/11/2026 : SpeedDial
# publie par .github/workflows/deploy.yml, le défaut répondait « non vérifié »).
detecter_workflow() {
  python3 - "$1" <<'PY'
import glob, os, re, sys

found = []
for path in sorted(glob.glob(os.path.join(sys.argv[1], ".github/workflows/*.y*ml"))):
    try:
        lines = open(path, encoding="utf-8").read().splitlines()
    except OSError:
        continue
    in_jobs, job, job_name, step_indent, step = False, None, None, None, None

    def close_step():
        if step and step.get("deploy") and step.get("name") and job:
            found.append((os.path.relpath(path, sys.argv[1]), job_name or job, step["name"]))

    for raw in lines:
        line = raw.split(" #")[0].rstrip()
        if not line.strip() or line.lstrip().startswith("#"):
            continue
        indent = len(line) - len(line.lstrip())
        if indent == 0:
            close_step(); step = None
            in_jobs = line.startswith("jobs:")
            continue
        if not in_jobs:
            continue
        m = re.match(r"^  ([A-Za-z0-9_-]+):\s*$", line)
        if m:
            close_step(); step = None
            job, job_name, step_indent = m.group(1), None, None
            continue
        m = re.match(r"^    name:\s*(.+)$", line)
        if m and step is None:
            job_name = m.group(1).strip().strip("'\"")
            continue
        m = re.match(r"^(\s*)- (.*)$", line)
        if m and (step_indent is None or len(m.group(1)) == step_indent):
            close_step()
            step_indent, step = len(m.group(1)), {}
            line = m.group(1) + "  " + m.group(2)
        if step is None:
            continue
        m = re.match(r"^\s*name:\s*(.+)$", line)
        if m and len(line) - len(line.lstrip()) == step_indent + 2:
            step["name"] = m.group(1).strip().strip("'\"")
        if re.match(r"^\s*uses:\s*['\"]?actions/deploy-pages@", line):
            step["deploy"] = True
    close_step()

if len(found) == 1:
    print("\n".join(found[0]))
PY
}

attendre() {
  local dir="$1" br="$2" url slug sha nom
  shift 2
  nom=$(basename "$dir")
  url=$(git -C "$dir" remote get-url origin 2>/dev/null) || { echo "➖ $nom : publication non vérifiée (pas de remote origin)"; return 3; }
  slug=$(printf '%s' "$url" | sed -nE 's#^(https://([^/@]+@)?github\.com(:443)?/|ssh://git@github\.com(:22)?/|git@github\.com:)(.*)$#\5#p' | sed -E 's#\.git$##')
  if [[ ! "$slug" =~ ^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$ ]]; then
    echo "➖ $nom : publication non vérifiée (remote hors GitHub)"
    return 3
  fi
  if printf '%s' "$br" | grep -Eq '^[0-9a-f]{7,40}$'; then
    sha=$(git -C "$dir" rev-parse --verify -q "$br^{commit}") || { echo "➖ $nom : publication non vérifiée (SHA $br inconnu localement)"; return 3; }
    br=commit
  else
    sha=$(git -C "$dir" rev-parse --verify -q "origin/$br") || { echo "➖ $nom : publication non vérifiée (branche origin/$br introuvable)"; return 3; }
  fi
  python3 - "$slug" "$sha" "$br" "$nom" "$DELAI" "$SANS_WORKFLOW" "$PAS" "$@" <<'PY'
import json
import os
import subprocess
import sys
from time import monotonic, sleep
from urllib.parse import urlencode

repo, sha, branch, repo_name = sys.argv[1:5]
timeout, discovery_wait, interval = map(int, sys.argv[5:8])
publication_pages = len(sys.argv) == 8
workflow, job_name, step_name = sys.argv[8:] or (
    "dynamic/pages/pages-build-deployment", "deploy", "Deploy to GitHub Pages"
)
excluded_events = {"schedule", "workflow_dispatch", "repository_dispatch", "pull_request", "pull_request_target"}
curl = ["curl", "-fsS", "--max-time", "15", "-H", "Accept: application/vnd.github+json"]
token = os.environ.get("GITHUB_TOKEN")
if token:
    curl += ["-H", "Authorization: Bearer " + token]


def github_items(path, key, **parameters):
    items = []
    for page in range(1, 11):
        query = urlencode({**parameters, "per_page": 100, "page": page})
        response = subprocess.run(
            [*curl, f"https://api.github.com/repos/{repo}/{path}?{query}"],
            capture_output=True, text=True,
        )
        if response.returncode:
            raise ValueError(response.stderr.strip() or f"curl {response.returncode}")
        payload = json.loads(response.stdout)
        batch, total = payload[key], payload["total_count"]
        if not isinstance(batch, list) or not isinstance(total, int) or any(not isinstance(item, dict) for item in batch):
            raise ValueError("réponse inattendue de GitHub")
        items.extend(batch)
        if len(items) >= total:
            return items
        if not batch:
            break
    raise ValueError("résultats GitHub incomplets")


def conclude(code, detail, run=None):
    icon, label = {
        0: ("✅", "déploiement réussi"),
        1: ("❌", "échec du déploiement"),
        2: ("⏳", "déploiement en cours"),
        3: ("➖", "publication non vérifiée"),
    }[code]
    print(f"{icon} {repo_name} {branch} {sha[:7]} : {label} — {detail}")
    if run and run.get("html_url"):
        print(f"  {run['html_url']}")
    sys.exit(code)


def result(item, name):
    status, conclusion = item.get("status"), item.get("conclusion")
    if status in {"queued", "in_progress", "requested", "waiting", "pending"}:
        return 2, f"{name} ({status})"
    if status != "completed" or conclusion in (None, "skipped", "neutral"):
        return 3, f"{name} ({conclusion or status or 'état inconnu'})"
    if conclusion == "success":
        return 0, name
    return 1, f"{name} ({conclusion})"


def publication_result(run):
    code, detail = result(run, workflow)
    if code:
        return code, detail
    jobs = github_items(f"actions/runs/{run['id']}/attempts/{run['run_attempt']}/jobs", "jobs")
    publishing_jobs = [job for job in jobs if job.get("name") == job_name and job.get("head_sha") == sha]
    if len(publishing_jobs) != 1:
        return 3, f"tâche attendue {job_name} manquante ou ambiguë"
    job = publishing_jobs[0]
    code, detail = result(job, job_name)
    if code:
        return code, detail
    steps = [step for step in job.get("steps", []) if step.get("name") == step_name]
    if len(steps) != 1:
        return 3, f"étape attendue {step_name} manquante ou ambiguë"
    return result(steps[0], f"{workflow} / {job_name} / {step_name}")


try:
    start = monotonic()
    while True:
        runs = github_items("actions/runs", "workflow_runs", head_sha=sha)
        matching = [run for run in runs if (
            run.get("head_sha") == sha
            and run.get("path", "").partition("@")[0] == workflow
            and (branch == "commit" or run.get("head_branch") == branch)
            and run.get("event") not in excluded_events
            and (not publication_pages or run.get("event") == "dynamic")
        )]
        run = max(matching, key=lambda item: (item["created_at"], item["id"], item["run_attempt"]), default=None)
        elapsed = monotonic() - start
        if run:
            code, detail = publication_result(run)
            if code != 2:
                conclude(code, detail, run)
            elapsed = monotonic() - start
            if elapsed >= timeout:
                conclude(2, f"{detail} après {timeout} s", run)
            wait_limit = timeout
        else:
            wait_limit = min(discovery_wait, timeout)
            if elapsed >= wait_limit:
                conclude(3, f"aucune exécution du workflow attendu {workflow} pour ce commit")
        sleep(min(interval, wait_limit - elapsed))
except (ValueError, TypeError, AttributeError, KeyError, OSError) as error:
    conclude(3, f"preuve GitHub indisponible ({error})")
PY
}

if [ "${1:-}" != "--hook" ]; then
  if (( $# > 2 )) && { (( $# != 5 )) || [[ -z "$3" || -z "$4" || -z "$5" ]]; }; then
    echo "➖ Publication non vérifiée. Préciser ensemble le workflow, la tâche et l'étape."
    exit 3
  fi
  dir="$(cd "${1:-.}" && git rev-parse --show-toplevel)" || exit 2
  ref="${2:-main}"
  if ! printf '%s' "$ref" | grep -Eq '^[0-9a-f]{7,40}$'; then
    if ! python3 - "$dir" "$ref" <<'PY'
import subprocess
import sys

try:
    sys.exit(subprocess.run(["git", "-C", sys.argv[1], "fetch", "-q", "--", "origin", sys.argv[2]], timeout=15).returncode)
except subprocess.TimeoutExpired:
    print("Délai de 15 s dépassé en lisant origin.")
    sys.exit(1)
PY
    then
      echo "➖ Publication non vérifiée (branche $ref inaccessible sur origin)"
      exit 3
    fi
  fi
  if (( $# <= 2 )); then
    mapfile -t propre < <(detecter_workflow "$dir")
    if (( ${#propre[@]} == 3 )); then attendre "$dir" "$ref" "${propre[@]}"; exit $?; fi
  fi
  attendre "$dir" "$ref" "${@:3}"; exit $?
fi

# ── Mode hook ────────────────────────────────────────────────────────────
cmd=$(python3 -c 'import sys,json; print(json.load(sys.stdin).get("tool_input",{}).get("command",""))' 2>/dev/null)
printf '%s' "$cmd" | grep -q 'git push' || exit 0
maintenant=$(date +%s); rapport=""; pire=0  # 1 échec > 2 pas fini > 3 non vérifié > 0
for dir in "$RACINE"/*/; do
  dir="${dir%/}"
  [ -d "$dir/.git" ] || continue
  for br in $BRANCHES; do
    # Un push met à jour origin/<br> : son reflog date l'envoi.
    t=$(git -C "$dir" reflog show --date=unix "origin/$br" -1 2>/dev/null | sed -nE 's/.*@\{([0-9]+)\}: update by push.*/\1/p')
    [ -n "$t" ] && [ $((maintenant - t)) -le "$FENETRE" ] || continue
    mapfile -t propre < <(detecter_workflow "$dir")
    if (( ${#propre[@]} == 3 )); then
      sortie=$(attendre "$dir" "$br" "${propre[@]}"); code=$?
    else
      sortie=$(attendre "$dir" "$br"); code=$?
    fi
    rapport="$rapport$sortie"$'\n'
    if [ $code -ne 0 ] && { [ $pire -eq 0 ] || [ $code -lt $pire ]; }; then pire=$code; fi
  done
done
[ -n "$rapport" ] || exit 0
RAPPORT="$rapport" PIRE="$pire" python3 -c '
import os, json
r = os.environ["RAPPORT"].strip(); pire = os.environ["PIRE"]; ko = pire != "0"
titre = {"1": "❌ Déploiement : échec — voir le détail", "2": "⏳ Déploiement : pas fini — voir le détail",
         "3": "➖ Publication non vérifiée — voir le détail"}
print(json.dumps({
  "systemMessage": titre.get(pire) or " ; ".join(l for l in r.splitlines() if not l.startswith("  ")),
  "hookSpecificOutput": {"hookEventName": "PostToolUse", "additionalContext":
    "Vérification GitHub Pages après ce push (MD-LIB/outils/attendre-deploiement.sh) :\n" + r +
    ("\nNe pas annoncer « en ligne » : corriger ou signaler l’échec à l’utilisateur." if ko else "")}}))'
