# Vérifier le déploiement avant d'annoncer « en ligne »

Règle établie le 13/10/2026 : ce jour-là, deux déploiements de NextStep ont
échoué (un test e2e bloquait la mise en ligne) et ont été annoncés « en
ligne » à l'utilisateur, qui a testé une version qui n'était pas déployée.
La règle « ne jamais déclarer en ligne sans vérification » existait déjà
(`collaboration.md`) : écrite, elle n'a pas suffi. D'où un contrôle
automatique plutôt qu'une phrase de plus (`hygiene-instructions.md`).

## La règle

Ne jamais écrire « c'est en ligne », « c'est déployé » ou « à recharger »
avant que `outils/attendre-deploiement.sh` ait répondu ✅ pour le commit
poussé. ❌ : dire l'échec à l'utilisateur et corriger. ⏳ : dire que ce
n'est pas fini, revérifier plus tard.

## Comment il se déclenche

- **Automatiquement, dans toutes les sessions cloud** : le « Setup script »
  de l'environnement Claude Code installe un hook (`PostToolUse`, outil Bash)
  qui, après chaque commande contenant `git push`, lance le script sur les
  dépôts de la session dont `main`, `master`, `sandbox` ou `gh-pages` vient
  d'être poussé. Le résultat revient à Claude dans la réponse de la commande.
  Texte du Setup script : `outils/script-demarrage.sh` (à coller par
  l'utilisateur, une fois, dans les réglages de l'environnement).
- **À la main**, si le hook n'a rien dit (session locale, environnement sans
  le Setup script) : `bash /home/user/MD-LIB/outils/attendre-deploiement.sh
  <dossier-du-dépôt> [branche|sha]`.

Le script lit l'API GitHub Actions (jeton `$GITHUB_TOKEN` de la session s'il
existe) et attend 8 minutes au plus. Il ignore les tâches planifiées et les
lancements à la main, qui tournent sur le même sha. **Seul le code 0 (✅, sha
nommé) autorise « en ligne »** : 1 échec, 2 pas fini, 3 rien vérifié (aucun
workflow vu au bout de 90 s, branche ou sha introuvable, dépôt hors GitHub).
Avant le 28/10/2026, ces derniers cas sortaient 0 en silence.

## Dans les projets

Rien à copier : le hook vient de l'environnement, le script de MD-LIB, cloné
dans chaque session. Une ligne dans le `CLAUDE.md` d'un projet suffit à le
rappeler là où l'on décrit le workflow git (« avant d'écrire « en ligne »,
`MD-LIB/outils/attendre-deploiement.sh` doit avoir dit ✅ »).
