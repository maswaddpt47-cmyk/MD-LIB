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
| `collaboration.md` | Règles de collaboration avec Claude (comportement attendu des deux côtés), dont la tenue d'un `CHANTIERS.md` par projet pour qu'une session sans historique puisse reprendre |
| `git-workflow.md` | Pull avant intervention, commits conventionnels, push sur `main`, gestion de branche imposée par la plateforme |
| `rgpd-securite.md` | Checklist RGPD/sécurité + note sur la routine d'audit trimestriel planifiée |
| `pwa-service-worker.md` | Garde-fous PWA/service worker : pas de cache quand un `?v=N` existe, pas de `respondWith`, et le rechargement forcé impossible en mode installé |
| `hygiene-instructions.md` | Empêcher le millefeuille d'instructions : une contrainte testable devient un test, tester le coût et pas seulement la justesse, dater/qualifier chaque affirmation, budget fermé, pas de changelog dans le code |
| `agora.md` | Faire contredire une proposition par une autre session via un `AGORA.md` commité dans le projet : six critères de déclenchement observables, rôle du contradicteur, gabarit de bloc, entretien |
| `AGORA.md` | L'AGORA de **ce dépôt** : les blocs ouverts et tranchés sur les règles elles-mêmes (`agora.md` est la règle, `AGORA.md` est l'instance) |

**À lire en premier** quand on s'apprête à ajouter une règle quelque part :
`hygiene-instructions.md`. Les autres fichiers disent quoi faire, celui-là dit
où l'écrire — et quand ne pas l'écrire du tout.

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
  imposée par la plateforme, merge dans `main` en fin de session. **Projet
  pilote pour `agora.md`** : `AGORA.md` créé à la racine et résumé propagé en
  section 8 de son `CLAUDE.md` le 21/09/2026. Format à éprouver ici avant
  propagation ailleurs (plate-forme non déployée, et jumeau de NextStep —
  le cas `hygiene-instructions.md` §6).
- `maswaddpt47-cmyk/ateliers-cd47_NextStep` — push direct sur `main`, pas
  de branche intermédiaire.
- `maswaddpt47-cmyk/GDINV2` — **`agora.md` propagé le 21/09/2026**, après
  validation du format par le pilote NEWGEN : `AGORA.md` à la racine, section
  « AGORA » dans son `CLAUDE.md`, chantier ouvert dans son `CHANTIERS.md`
  jusqu'au premier bloc tranché. Son `AGORA.md` porte aussi les règles de
  réponse : ce n'est plus un écart, **le §9 a été corrigé le 22/09/2026**
  (AG-001 de MD-LIB) — la copie doit porter le gabarit *et* les trois règles
  qui ne s'en déduisent pas. Copie **relue le 21/09/2026 depuis une
  session tierce : test du §9 passé**, les deux fichiers suffisent à ouvrir un
  bloc et à y répondre sans MD-LIB. Le libellé de la phrase de relais
  (« …réponds à AG-00N, **tu es la session B** ») reste utile pour remplir le
  champ `Auteur`, mais ce n'est **pas** la distinction qui fait foi : le
  trailer `Claude-Session:` des commits distingue deux sessions même sous une
  identité GitHub unique (§10, corrigé le 21/09/2026 après AG-001). **Aligné le
  22/09/2026** sur les deux améliorations retenues : rappel accroché aux
  « décisions à trancher » de `CHANTIERS.md`, et ligne « si personne ne
  répond, je fais quoi ? » dans le gabarit. **Liste canonique du §9 propagée
  le 22/09/2026** : les deux puces dupliquées par le gabarit (les trois
  verdicts, la règle de preuve) retirées, le cycle de relais et l'absence de
  notification inter-comptes ajoutés. **Écart assumé** : la copie garde ses
  sections « Entretien » et la posture « compléter, pas réécrire », que le §9
  ne liste pas — la première n'est pas une règle de réponse, la seconde ne se
  déduit pas du gabarit. La borne de 35-50 lignes n'a rien demandé : la
  section AGORA de son `CLAUDE.md` fait 37 lignes (mesuré le 22/09/2026,
  `GDINV2/CLAUDE.md:122-158`).
  Branche de travail `main`, branche de session
  imposée à merger dans `main` en fin de session (le déploiement GitHub
  Pages ne part que depuis `main`). Règles propagées le 20/09/2026 dans la
  section « Règles générales adaptées à ce projet » de son `CLAUDE.md` ;
  les règles 14 à 17 le 21/09/2026, dans sa section « Ce que coûte un test ».

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
toute session pour auditer ATELIERS_NEWGEN, NextStep et GDINV2 (ajouté le
20/09/2026). Elle n'a pas besoin que ce repo soit attaché — vérifier avec
`list_triggers` si son état est en doute.
