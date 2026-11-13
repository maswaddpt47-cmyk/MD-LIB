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

**Échec sans aucune étape exécutée** (09/11/2026, sms-mail-multi) : une
tâche « sautée » ou absente de l'exécution, sans journal d'étape, alors que les
tests passent en local, n'est pas un défaut du dépôt. Ne rien corriger ni
pousser pour « débloquer » (pas de commit vide) : relancer **une fois** la même
exécution (`rerun_workflow_run`), puis faire vérifier https://www.githubstatus.com
(Actions, Pages) par l'utilisateur, la page étant bloquée depuis l'environnement
cloud. Incident confirmé : programmer **une** relance après le délai annoncé
(`send_later`) au lieu de boucler, et noter l'état réel dans `CHANTIERS.md`.
Constat : trois exécutions en échec pendant l'incident Actions du 09/11
(19:12–19:45, heure de Paris), puis succès à la relance programmée.

**➖ « aucun workflow vu » ne prouve pas l'absence de déploiement** (13/11/2026,
CRConum-V10) : lister les exécutions passées du dépôt (`list_workflow_runs`).
S'il existe des « pages build and deployment », Pages est actif et la
construction manquante est un blocage : la page en ligne reste l'ancienne. Ne
rien pousser pour « débloquer » ; l'utilisateur relance par Settings → Pages,
Branch « None » puis « main » / root, et le ✅ sur le sha poussé précède tout
essai de sa part. Constat : quatre pushes sans construction (dernière le
23/05/2026), « aucun déploiement » écrit dans le `CLAUDE.md` du projet, et un
essai Proton Pass fait sur l'ancienne page.

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
