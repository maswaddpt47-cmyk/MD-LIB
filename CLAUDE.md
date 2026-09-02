# Règles de travail — MD-LIB

## Objectif du repo

Bibliothèque de mémoire générale et réutilisable pour Claude, valable sur
tous les projets de l'utilisateur (actuels et futurs) — pas un dépôt de
code. Chaque fichier ici est une règle ou une routine destinée à être
**copiée** (pas juste référencée) dans le `CLAUDE.md` de chaque projet
consommateur, pour qu'elle soit lue automatiquement à chaque session sur
ce projet, sans avoir à attacher MD-LIB à chaque fois.

## Fichiers actuels

| Fichier | Contenu |
|---|---|
| `collaboration.md` | Règles de collaboration avec Claude (comportement attendu des deux côtés) |
| `git-workflow.md` | Pull avant intervention, commits conventionnels, push sur `main`, gestion de branche imposée par la plateforme |
| `rgpd-securite.md` | Checklist RGPD/sécurité + note sur la routine d'audit trimestriel planifiée |

## Convention de nommage

Nommer chaque fichier **d'après son contenu**, pas d'après le projet
d'origine d'où il a été extrait la première fois (ex. `collaboration.md`,
pas `ATELIERS_NEWGEN.md`) — l'objectif est la réutilisation multi-projets,
un nom lié à un repo précis n'a pas de sens ici et crée un risque de
collision quand on ajoute d'autres projets.

## Règle de propagation — la plus importante

**Il n'y a pas de lien automatique entre ce repo et les `CLAUDE.md` des
projets consommateurs.** Modifier un fichier ici ne met à jour aucun
projet. Quand l'utilisateur demande une modification :

1. Modifier d'abord le fichier ici (source canonique).
2. Committer et pousser sur MD-LIB.
3. **Demander explicitement à l'utilisateur** s'il veut que le changement
   soit répercuté dans les projets consommateurs — ne pas le faire par
   défaut, mais ne pas non plus présumer que « source canonique à jour »
   suffit : sans propagation, les projets restent sur l'ancienne version.
4. Si oui, éditer manuellement la section correspondante dans le
   `CLAUDE.md` de chaque projet concerné, en respectant la convention de
   branche/commit propre à **ce projet-là** (voir son propre `CLAUDE.md`,
   pas celui de MD-LIB).

## Projets consommateurs actuels

- `maswaddpt47-cmyk/ATELIERS_NEWGEN` — développe sur une branche dédiée
  imposée par la plateforme, merge dans `main` en fin de session.
- `maswaddpt47-cmyk/ateliers-cd47_NextStep` — push direct sur `main`, pas
  de branche intermédiaire.

Vérifier leur `CLAUDE.md` respectif avant de propager, les conventions
peuvent diverger d'un projet à l'autre.

## Workflow git de ce repo

Pas de suite de tests, pas de CI bloquante ici — repo purement
documentaire. Un commit par modification logique, message conventionnel
(`feat:`, `fix:`, `refactor:`, `docs:`, `chore:`). Push direct sur `main`
sauf si la plateforme impose une branche de session, auquel cas merger
dans `main` en fin de session (`git checkout main && git merge <branche>
--no-ff && git push origin main`).

## Audit de sécurité trimestriel

Une routine planifiée (voir `rgpd-securite.md`) tourne indépendamment de
toute session pour auditer ATELIERS_NEWGEN et NextStep. Elle n'a pas besoin
que ce repo soit attaché — vérifier avec `list_triggers` si son état est en
doute.
