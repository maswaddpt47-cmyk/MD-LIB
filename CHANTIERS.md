# CHANTIERS — relais vers le projet

Relu par « pull » le **16/11/2026 à 19:51**, base `main` `225e844` (rien d'arrivé depuis `9981de5` hors la règle 69 reportée dans l'`AGENTS.md` de sms-mail-multi ; `CLAUDE.md` corrigé : `check-chantiers.sh` est en place dans sms-mail-multi depuis le 06/11). Avant : base `51d1da8` : arrivées depuis, les règles 70 (contrôle régulier automatisé d'office) et 71 (un défaut signalé dit sa voie d'entrée), chargées d'office par l'import, rien à reporter dans les `AGENTS.md`. Avant : état au **15/11/2026, fin de session** : principe « chaque règle s'adapte au projet » (`b31410e`) et précisions des règles 1, 16 et 52 (fin de session, règle 32). Avant : base `main` `170302a` (relu par « pull » ; arrivés après `5215f6f` : règle 19 « pas de soupçon envers l'utilisateur », règle de mot de passe imposée et pas d'indice dans une page publique (`rgpd-securite.md`), précision de la règle 55 (score de mutation), `deploiement.md` (Pages « in progress », ➖ sans preuve d'absence), règle 18 « la tâche est le travail demandé », règle 69 « bouton qui lance l'application », CRConum-V10 et MentiAnalyser inscrits ; puis règle 69 reportée dans l'`AGENTS.md` de PAPPERBOARD le 15/11/2026). Avant, état au 13/11/2026, base `5215f6f` (arrivé par « pull » : précision de la règle 5 et « échec sans étape exécutée » dans `deploiement.md`, autre session) + règle 69 reportée au prochain « pull » de chaque projet (SpeedDial fait). Avant : règle 69 de `collaboration.md` (champ de secret reconnu par un gestionnaire de mots de passe) ; `agora.md` §13 prend `MD-LIB/AGORA.md` comme copie de référence (complété : Sincérité, ligne Contradicteur, total) ; SpeedDial inscrit dans `CLAUDE.md` (AGORA installée, ménage et `AGENTS.md` faits). Accord de l'utilisateur pour les deux règles.

Précédent : état au **06/11/2026 à 09:57**, base `main` `e1fbd7a` + règle 68 et précision de la 55 (fin de session du 06/11, accord de l'utilisateur) (relue par « pull » ; sms-mail-multi : puce « Fin de tâche » ajoutée à son AGENTS.md) : `collaboration.md` **chargé d'office** par `@collaboration.md` (essai concluant, plus de propagation de ses règles dans les `CLAUDE.md`, `26093d6`/`bdd7505`) ; ménage des `CLAUDE.md` des projets (`62a0890`, `09e792b`) ; règle 25 accordée à la 59 (`149fe70`) ; prompts de bilan dans `prompts-bilan-collaboration.md` (`1ec0a90`) ; annonce AGORA 🔴 en gras (`agora.md` §4, `6d07cfd`, propagée `9e73ed0`) ; règles 63 à 65 (`dbccfa0`) et précisions des règles 5, 55 et 58 (`96bf7a8`). Le 04/11, décision de l'utilisateur : section « Autorisations », règle 60 et « Main toujours » reportées dans l'`AGENTS.md` de chaque projet **à son prochain « pull »** (`CLAUDE.md`, « `AGENTS.md` au même « pull » ») ; fait dans sms-mail-multi, NEWGEN (`0fbb4c4`) et NextStep (`cb9985e`).

**Depuis le 31/10/2026** : règles 58 à 60 de `collaboration.md`, « Main
toujours » (`git-workflow.md` §3) et `Auteur.md` inscrits. Leur propagation
(faite pour 58-59 ; pour 60 et « Main toujours », au prochain « pull » de chaque projet) est tenue dans
`CLAUDE.md`, « Reste à propager ».

**Ménage du 26/10/2026** : récits des propagations des 21 et 25/10 (règles 22
et 23 de `collaboration.md`, choix des annonces « Nouveautés ») retirés —
commits listés dans `git log -p CHANTIERS.md`. Ce qui reste à propager est
tenu dans `CLAUDE.md`, section « Reste à propager » (règle 34 comprise).

## Communication — précision du 02/11/2026

La règle 18 de collaboration.md précise la suite concrète à la fin de chaque
message, y compris la réponse finale. Application à MentiAnalyser pendant la
session ; autres projets inchangés, suivi dans CLAUDE.md « Reste à propager ».
Le 05/11/2026, la consigne **✅ TÂCHE TERMINÉE**, déjà dans les deux projets
ATELIERS, est ajoutée à la règle 18 et au modèle `AGENTS.md` commun. Les autres
`AGENTS.md` se mettent à jour au prochain pull, même si leur projet était déjà
coché pour les autres consignes. Une session déjà ouverte doit être invitée à
relire les sources ; leur seule modification ne garantit pas cette relecture.

## Conception des statistiques — règle commune du 31/10/2026

Principe demandé par l’utilisateur : tout nouveau projet peut produire des
statistiques ; y réfléchir dès la conception. Source canonique :
`collaboration.md` règle 57 et `chiffres-diffuses.md` §0 ; rappel dans la
création des projets de `CLAUDE.md`. Conserver une approche proportionnée,
la minimisation des données et le traitement explicite des inconnus.
L’audit avant diffusion (règle 33) reste distinct. Les projets existants
n’ont pas été modifiés ; suivi de propagation dans `CLAUDE.md`.

## Reprise ATELIERS — 05/11/2026

Passation publiée sur `main` : **`ATELIERS_NEWGEN/CHANTIERS.md`** (`eedbb61`),
avec le relais propre à NextStep dans **`ateliers-cd47_NextStep/CHANTIERS.md`**
(`5c09453`). Aucun bloc AGORA ouvert au contrôle du 05/11/2026 ; AG-047 à AG-051
clos. Les derniers ajouts (statut groupé, volet Détail) ne sont pas présentés comme
audités par Codex ; validations, CI et limites sont consignées dans NEWGEN.

Les consignes récentes sont déjà enregistrées : règle 18 et `AGENTS.md` commun
pour **✅ TÂCHE TERMINÉE** (`9c4f349`), règle 66 pour la mise en forme ciblée,
règle 67 pour pousser le SHA testé après une attente en arrière-plan (`8eec418`).
Aucune nouvelle règle à inscrire lors de ce changement de session. Une session
déjà ouverte doit relire explicitement MD-LIB et les consignes du projet ; les
projets consommateurs se mettent à jour au prochain pull, sans propagation groupée.
Repartir de `main` actualisé et d'une copie propre, sans reprendre d'anciens brouillons.

## Reprise GDINV2 (29/10/2026)

La passation est dans **`GDINV2/CHANTIERS.md` sur `main`** (en tête : « À faire en
premier ») et dans `GDINV2-BACKUP/INVENTAIRE.md`. Ici : règles **53 et 54** de
`collaboration.md` inscrites et **propagées** le 29/10 à GDINV2, NEWGEN, NextStep
(`CLAUDE.md`, « Reste à propager » : reste PAPPERBOARD). L'exception Codex du §12 est propagée dans GDINV2.

## Branches à ne pas reprendre

- **PAPPERBOARD `codex/regles-collaboration`** : périmée. `AGENTS.md` est sur
  `main` depuis le 21/10/2026 (`5aaca8b`) ; fusionner cette branche retirerait
  la coupure d'urgence de WoocLight.
- **PAPPERBOARD `codex/interface-simulation-fidele`** (`f19df16`) : intégrée à
  `main` (vérifié le 26/10/2026), archive seulement.

## Reprise WoocLight / PAPPERBOARD

La passation est dans **`PAPPERBOARD/CHANTIERS.md` sur `main`** : ce fichier
n'en duplique pas l'état. SMS-mail reste gelé : aucune propagation.

