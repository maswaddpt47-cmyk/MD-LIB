#!/bin/bash
# script-demarrage.sh — texte à coller dans le « Setup script » de
# l'environnement Claude Code (menu de l'environnement dans la barre de titre
# d'une session → Edit → Setup script). Il tourne au lancement de chaque
# nouvelle session cloud, avant Claude.
#
# Il n'installe qu'une chose : le hook qui, après chaque `git push`, lance
# MD-LIB/outils/attendre-deploiement.sh (règle : MD-LIB/deploiement.md). Le
# hook cherche MD-LIB au moment du push, pas au démarrage : peu importe que
# les dépôts soient clonés avant ou après ce script, et c'est toujours la
# version de MD-LIB clonée dans la session qui sert (pas de copie à tenir à
# jour). Sans MD-LIB dans la session, le hook ne fait rien.
#
# Ce fichier est la référence : si on le modifie, recoller son contenu dans
# le Setup script. Relancer ce script ne crée pas de doublon.

python3 - <<'EOF'
import json, os
p = os.path.expanduser("~/.claude/settings.json")
os.makedirs(os.path.dirname(p), exist_ok=True)
try:
    s = json.load(open(p))
except Exception:
    s = {}
cmd = ('f=$(ls -d /home/user/*/outils/attendre-deploiement.sh 2>/dev/null | grep -i "/md-lib/" | head -1); '
       '[ -n "$f" ] && bash "$f" --hook; true')
post = s.setdefault("hooks", {}).setdefault("PostToolUse", [])
if not any("attendre-deploiement" in json.dumps(h) for h in post):
    post.append({"matcher": "Bash", "hooks": [{"type": "command", "command": cmd,
                 "timeout": 900, "statusMessage": "Vérification du déploiement GitHub…"}]})
json.dump(s, open(p, "w"), indent=2, ensure_ascii=False)
print("Hook attendre-deploiement installé dans", p)
EOF
