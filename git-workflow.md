# Workflow Git

Règles communes pour Claude et Codex. Lire les instructions du projet pour
connaître la branche publiée, les contrôles et les contraintes de la plateforme.

## 1. Actualisation systématique avant toute intervention

Vérifier le dépôt, son remote, sa branche par défaut, la branche de session et
`git status`. Préserver les modifications locales. Avant de lire ou modifier
les fichiers, actualiser la branche concernée par `fetch` puis
`merge --ff-only` ; ne pas utiliser `git pull`.

Exemple pour `main`, après vérification que l'on peut changer de branche sans
emporter de travail local :

```bash
git switch main
git fetch origin main
git merge --ff-only origin/main
```

Adapter le nom si le projet publie une autre branche. Si l'avance rapide est
impossible, examiner le graphe et les changements concurrents avant toute
intégration (§3) ; ne pas écraser l'état local ni provoquer une fusion implicite.
Relire les fichiers partagés juste avant de les modifier, après actualisation.

## 2. Un commit par modification, message conventionnel

Un commit par modification logique, avec un message conventionnel en français :

```text
type: description courte de ce qui a changé
```

Types autorisés : `feat`, `fix`, `refactor`, `style`, `docs`, `chore`.
L'historique détaillé appartient aux commits, pas aux fichiers d'instructions.

## 3. Ordre d'intervention à respecter

1. Actualiser selon le §1 et lire les consignes du projet.
2. Modifier les fichiers, puis exécuter les contrôles requis par le projet et
   `collaboration.md` ; committer chaque modification logique séparément.
3. Publier la livraison selon le circuit du projet, puis vérifier le résultat.

**Main toujours** : quand le projet prescrit `main`, publier chaque livraison
vérifiée sur `main`, sans attendre la fin de session ni redemander. Sans règle
de publication écrite, cette convention commune s'applique ; la consigner dans
les instructions du projet. Une branche imposée doit rejoindre la branche
publiée par le circuit permis : avance rapide, fusion explicite ou PR selon le
projet et les protections réelles. Ne pas laisser une livraison en PR brouillon
par défaut ni contourner une restriction de la plateforme.

**Avance rapide vers `main`** : figer le commit testé **avant toute attente**
(CI, déploiement), pour qu'un commit créé ensuite ne parte pas avec lui :

```bash
sha_livraison=$(git rev-parse HEAD)
```

Après les contrôles, vérifier les changements à publier et l'ascendance :

```bash
git fetch origin main
git diff --stat origin/main "$sha_livraison"
git merge-base --is-ancestor origin/main "$sha_livraison" &&
  git push origin "$sha_livraison:main"
```

Le diff ne doit contenir que la livraison voulue. Si `origin/main` a divergé,
préserver les changements des deux côtés et les intégrer explicitement sur la
branche de travail ou par PR, selon le projet. Refaire les contrôles sur le
commit final avant de publier. Aucun `rebase` de commits déjà publiés, aucun
force-push ; garder aussi la branche de session alignée quand le projet l'exige.

Après le push, relire `git log --oneline -2` et vérifier le commit distant.
Distinguer code poussé et code déployé : suivre `deploiement.md` pour annoncer
« en ligne ». La branche qui déclenche le déploiement se vérifie dans le projet.
