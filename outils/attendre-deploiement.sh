#!/bin/bash
# attendre-deploiement.sh — attend la fin des workflows GitHub Actions d'un
# commit poussé et dit s'ils ont réussi. Règle : `deploiement.md` de MD-LIB.
# Né le 13/10/2026 : deux déploiements rouges de NextStep annoncés « en ligne »
# sans vérification.
#
# Usages :
#   attendre-deploiement.sh [dossier-du-depot] [branche|sha]
#       défauts : dossier courant, main. Code de sortie : 0 vert, 1 un
#       workflow en échec, 2 délai dépassé, 3 rien vérifié (aucun workflow,
#       branche ou sha introuvable, dépôt hors GitHub). Seul 0 autorise à
#       écrire « en ligne ». Un ✅ nomme toujours le sha vérifié.
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
  # Chaque sortie anticipée le dit et rend 3 : un silence se lisait comme un ✅
  # (GDINV2 22/10/2026, PAPPERBOARD 26/10/2026 : sha passé comme branche).
  url=$(git -C "$dir" remote get-url origin 2>/dev/null) || { echo "❓ $nom : pas de remote origin — rien vérifié"; return 3; }
  case "$url" in *github.com*) ;; *) echo "❓ $nom : remote hors GitHub ($url) — rien vérifié"; return 3;; esac
  slug=$(printf '%s' "$url" | sed -E 's#.*github\.com[/:]##; s#\.git$##')
  if printf '%s' "$br" | grep -Eq '^[0-9a-f]{7,40}$'; then
    sha=$(git -C "$dir" rev-parse --verify -q "$br^{commit}") || { echo "❓ $nom : sha $br inconnu localement (git fetch ?) — rien vérifié"; return 3; }
    br=commit
  else
    sha=$(git -C "$dir" rev-parse --verify -q "origin/$br") || { echo "❓ $nom : branche origin/$br introuvable (git fetch origin $br ?) — rien vérifié"; return 3; }
  fi
  debut=$(date +%s)
  sleep 5
  while :; do
    etat=$(api "repos/$slug/actions/runs?head_sha=$sha&per_page=50" 2>/dev/null | python3 -c '
import sys, json
try: runs = json.load(sys.stdin)["workflow_runs"]
except Exception: print("ATTENTE"); sys.exit()
# Ni tâches planifiées ni lancements à la main : ils tournent sur le même sha,
# et un veilleur en cours bloquait le verdict (NEWGEN, 28/10/2026). Restent
# push et « dynamic » (publication GitHub Pages).
runs = [r for r in runs if r.get("event") not in ("schedule", "workflow_dispatch", "repository_dispatch")]
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
               echo "➖ $nom $br ${sha:0:7} : aucun workflow GitHub Actions vu pour ce commit — rien vérifié, ne pas annoncer « en ligne » sur cette base"; return 3
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
  printf '%s' "${2:-main}" | grep -Eq '^[0-9a-f]{7,40}$' || git -C "$dir" fetch -q origin "${2:-main}" 2>/dev/null
  attendre "$dir" "${2:-main}"; exit $?
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
    sortie=$(attendre "$dir" "$br"); code=$?
    rapport="$rapport$sortie"$'\n'
    if [ $code -ne 0 ] && { [ $pire -eq 0 ] || [ $code -lt $pire ]; }; then pire=$code; fi
  done
done
[ -n "$rapport" ] || exit 0
RAPPORT="$rapport" PIRE="$pire" python3 -c '
import os, json
r = os.environ["RAPPORT"].strip(); pire = os.environ["PIRE"]; ko = pire != "0"
titre = {"1": "❌ Déploiement : échec — voir le détail", "2": "⏳ Déploiement : pas fini — voir le détail",
         "3": "❓ Déploiement : rien vérifié — voir le détail"}
print(json.dumps({
  "systemMessage": titre.get(pire) or " ; ".join(l for l in r.splitlines() if not l.startswith("  ")),
  "hookSpecificOutput": {"hookEventName": "PostToolUse", "additionalContext":
    "Résultat des workflows GitHub Actions après ce push (MD-LIB/outils/attendre-deploiement.sh) :\n" + r +
    ("\nNe pas annoncer « en ligne » : corriger ou signaler l’échec à l’utilisateur." if ko else "")}}))'
