# CHANTIERS — relais vers le projet

État au **28/10/2026**.

**Ménage du 26/10/2026** : récits des propagations des 21 et 25/10 (règles 22
et 23 de `collaboration.md`, choix des annonces « Nouveautés ») retirés —
commits listés dans `git log -p CHANTIERS.md`. Ce qui reste à propager est
tenu dans `CLAUDE.md`, section « Reste à propager » (règle 34 comprise).

## Branches à ne pas reprendre

- **PAPPERBOARD `codex/regles-collaboration`** : périmée. `AGENTS.md` est sur
  `main` depuis le 21/10/2026 (`5aaca8b`) ; fusionner cette branche retirerait
  la coupure d'urgence de WoocLight.
- **PAPPERBOARD `codex/interface-simulation-fidele`** (`f19df16`) : intégrée à
  `main` (vérifié le 26/10/2026), archive seulement.

## Reprise WoocLight / PAPPERBOARD

La passation est dans **`PAPPERBOARD/CHANTIERS.md` sur `main`** : ce fichier
n'en duplique pas l'état. SMS-mail reste gelé : aucune propagation.

## Outil à corriger — `outils/attendre-deploiement.sh`

- Peut sortir **0 sans avoir rien vérifié** : lancé avec un sha au lieu de
  `[dossier] [branche]` il fait `cd <sha>`, échoue et sort 0 (GDINV2,
  22/10/2026) ; sur PAPPERBOARD le 26/10/2026, vert immédiat et sans sortie
  alors que la CI tournait (workflows non vus depuis l'environnement). Le
  faire sortir en erreur quand il ne voit aucun workflow ou ne peut pas `cd`,
  et nommer le sha dans le ✅. En attendant : vérifier la CI dans GitHub.
- Règle 39 de `collaboration.md` (28/10/2026) : propagation à demander.

