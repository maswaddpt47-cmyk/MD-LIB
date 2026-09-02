# Workflow Git

Mémoire générale, valable pour tous les projets (actuels et futurs).

## 1. Git pull systématique avant toute intervention

Avant de lire, modifier ou créer le moindre fichier du projet, toujours exécuter :

```bash
git pull origin main
```

Ne jamais sauter cette étape, même si le repo semble à jour. L'objectif est de ne jamais écraser les modifications apportées entre deux sessions.

## 2. Un commit par modification, message conventionnel

Chaque modification doit faire l'objet d'un commit séparé. Pas de commit fourre-tout.

Format du message :
```
type: description courte de ce qui a changé
```

Types autorisés : `feat`, `fix`, `refactor`, `style`, `docs`, `chore`

Exemples :
- `feat: ajouter export PDF dans la vue historique`
- `fix: corriger le calcul des présents dans bingo`
- `refactor: extraire logique calendrier dans admin_config.js`

## 3. Ordre d'intervention à respecter

Pour chaque session de travail :

1. `git pull origin main`
2. Appliquer les modifications
3. Committer chaque modification séparément avec message conventionnel
4. Pousser sur `main` : `git push origin main`

**Important — branche imposée par la plateforme :**
Claude Code sur le web impose parfois une branche de travail dédiée (ex. `claude/code-review-*`).
Dans ce cas, merger systématiquement dans `main` et pousser à la fin de chaque session :
```bash
git checkout main
git merge <branche> --no-ff
git push origin main
```
Le déploiement (GitHub Pages ou autre) ne se déclenche généralement que sur `main`. Travailler uniquement sur une branche de feature rend les changements invisibles en production.
