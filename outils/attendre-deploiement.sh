#!/bin/bash
# attendre-deploiement.sh — attend la fin des workflows GitHub Actions d'un
# commit poussé et dit s'ils ont réussi. Règle : `deploiement.md` de MD-LIB.
# Né le 13/10/2026 : deux déploiements rouges de NextStep annoncés « en ligne »
# sans vérification.
#
# Usages :
#   attendre-deploiement.sh [dossier-du-depot] [branche]
#       défauts : dossier courant, main. Code de sortie : 0 vert (ou aucun
#       workflow), 1 un workflow en échec, 2 délai dépassé.
#   attendre-deploiement.sh --hook
#       hook PostToolUse (Bash) installé par le script de démarrage de
#       l'environnement (voir deploiement.md). Après une commande contenant
#       `git push`, cherche dans les dépôts voisins de MD-LIB ceux dont une
#       branche publiée (main, master, sandbox, gh-pages) vient d'être
#       poussée, attend leurs workflows et renvoie le résultat à Claude.
#
# Dépend de : git, curl, python3. Utilise $GITHUB_TOKEN s'il existe (sinon
# l'API publique, limitée à 60 appels par heure).

RACINE="$(dirname "$(cd "$(dirname "$0")/.." && pwd)")"  # dossier qui contient MD-LIB
DELAI=${ATTENTE_DEPLOIEMENT_MAX:-480}     # secondes avant d'abandonner
SANS_WORKFLOW=${ATTENTE_SANS_WORKFLOW:-90} # aucun workflow après ça : rien à attendre
FENETRE=${ATTENTE_FENETRE:-300}           # un push plus ancien n'est pas « celui-ci »
BRANCHES="main master sandbox gh-pages"
PAS=20

api() {
  if [ -n "${GITHUB_TOKEN:-}" ]; then
    curl -fsS -H "Authorization: Bearer $GITHUB_TOKEN" -H "Accept: application/vnd.github+json" "https://api.github.com/$1"
  else
    curl -fsS -H "Accept: application/vnd.github+json" "https://api.github.com/$1"
  fi
}

# attendre <dossier> <branche> : résumé, une ligne par workflow.
attendre() {
  local dir="$1" br="$2" url slug sha debut etat nom
  nom=$(basename "$dir")
  url=$(git -C "$dir" remote get-url origin 2>/dev/null) || return 0
  case "$url" in *github.com*) ;; *) return 0;; esac
  slug=$(printf '%s' "$url" | sed -E 's#.*github\.com[/:]##; s#\.git$##')
  sha=$(git -C "$dir" rev-parse "origin/$br" 2>/dev/null) || return 0
  debut=$(date +%s)
  sleep 5
  while :; do
    etat=$(api "repos/$slug/actions/runs?head_sha=$sha&per_page=50" 2>/dev/null | python3 -c '
import sys, json
try: runs = json.load(sys.stdin)["workflow_runs"]
except Exception: print("ATTENTE"); sys.exit()
if not runs: print("AUCUN"); sys.exit()
der = {}  # dernière tentative de chaque workflow
for r in runs:
    if r["name"] not in der or r["run_attempt"] > der[r["name"]]["run_attempt"]: der[r["name"]] = r
if any(r["status"] != "completed" for r in der.values()): print("ATTENTE"); sys.exit()
ko = [r for r in der.values() if r["conclusion"] not in ("success", "skipped", "neutral")]
print("KO" if ko else "OK")
for r in sorted(der.values(), key=lambda r: r["name"]):
    print("  " + ("❌" if r in ko else "✅") + " " + r["name"] + " : " + str(r["conclusion"]) + (" — " + r["html_url"] if r in ko else ""))
')
    local ecoule=$(( $(date +%s) - debut ))
    case "$etat" in
      OK*) echo "✅ $nom $br ${sha:0:7} : déploiement réussi"; echo "${etat#OK}" | sed '/^$/d'; return 0;;
      KO*) echo "❌ $nom $br ${sha:0:7} : ÉCHEC — ne pas annoncer « en ligne »"; echo "${etat#KO}" | sed '/^$/d'; return 1;;
      AUCUN) if [ "$ecoule" -ge "$SANS_WORKFLOW" ]; then
               echo "➖ $nom $br ${sha:0:7} : aucun workflow GitHub Actions pour ce commit (rien à déployer, ou pas de CI)"; return 0
             fi;;
    esac
    if [ "$ecoule" -ge "$DELAI" ]; then
      echo "⏳ $nom $br ${sha:0:7} : pas fini après ${DELAI}s — revérifier avant d'annoncer"; return 2
    fi
    sleep "$PAS"
  done
}

if [ "${1:-}" != "--hook" ]; then
  dir="$(cd "${1:-.}" && git rev-parse --show-toplevel)" || exit 2
  git -C "$dir" fetch -q origin "${2:-main}" 2>/dev/null
  attendre "$dir" "${2:-main}"; exit $?
fi

# ── Mode hook ────────────────────────────────────────────────────────────
cmd=$(python3 -c 'import sys,json; print(json.load(sys.stdin).get("tool_input",{}).get("command",""))' 2>/dev/null)
printf '%s' "$cmd" | grep -q 'git push' || exit 0
maintenant=$(date +%s); rapport=""; pire=0
for dir in "$RACINE"/*/; do
  dir="${dir%/}"
  [ -d "$dir/.git" ] || continue
  for br in $BRANCHES; do
    # Un push met à jour origin/<br> : son reflog date l'envoi.
    t=$(git -C "$dir" reflog show --date=unix "origin/$br" -1 2>/dev/null | sed -nE 's/.*@\{([0-9]+)\}: update by push.*/\1/p')
    [ -n "$t" ] && [ $((maintenant - t)) -le "$FENETRE" ] || continue
    sortie=$(attendre "$dir" "$br"); code=$?
    rapport="$rapport$sortie"$'\n'; [ $code -gt $pire ] && pire=$code
  done
done
[ -n "$rapport" ] || exit 0
RAPPORT="$rapport" PIRE="$pire" python3 -c '
import os, json
r = os.environ["RAPPORT"].strip(); ko = os.environ["PIRE"] != "0"
print(json.dumps({
  "systemMessage": ("❌ Déploiement : échec ou pas fini — voir le détail" if ko else " ; ".join(l for l in r.splitlines() if not l.startswith("  "))),
  "hookSpecificOutput": {"hookEventName": "PostToolUse", "additionalContext":
    "Résultat des workflows GitHub Actions après ce push (MD-LIB/outils/attendre-deploiement.sh) :\n" + r +
    ("\nNe pas annoncer « en ligne » : corriger ou signaler l’échec à l’utilisateur." if ko else "")}}))'
