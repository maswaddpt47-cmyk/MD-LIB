# Règles de travail — MD-LIB

**Reprise de session : lire [`CHANTIERS.md`](CHANTIERS.md).**
Index des fiches à consulter selon la tâche : [`README.md`](README.md).

## Règles communes chargées automatiquement (depuis le 04/11/2026)

@collaboration.md

Cet import concerne Claude lorsque MD-LIB est attaché et que l'environnement
charge ce `CLAUDE.md`. L'essai du 04/11/2026 a confirmé ce fonctionnement dans
une session ; il ne prouve pas le chargement dans tous les environnements.
Si nécessaire, lire `collaboration.md` explicitement. Codex ne suit pas cet
import : il lit `AGENTS.md` et ouvre lui-même les règles communes.

Au démarrage, vérifier dépôt, branche, état Git et demande actuelle ; actualiser
par `git fetch` puis `git merge --ff-only` selon `git-workflow.md`. Préserver les
éditions locales. Lire la passation et les consignes propres au projet avant
d'intervenir. Ne pas demander à nouveau une autorisation déjà donnée ; exposer
les conflits non résolus avant l'action concernée.

## Objectif du repo

Bibliothèque documentaire partagée par Claude et Codex pour les projets actuels
et futurs. `collaboration.md` porte les règles communes ; les fiches du README
portent les procédures détaillées. Les projets gardent leurs exceptions
validées, commandes, branches, tests et modes de publication.

## Convention de nommage

Nommer les fichiers d'après leur contenu, sans nom de projet d'origine ni
statut dans le nom. Garder les noms actuels et les numéros des règles/sections
cités par les autres dépôts. Lire `hygiene-instructions.md` avant tout ajout.

## Nouveau projet — AGORA installée dès la création

Installer `AGORA.md` et sa section de consignes avant le premier commit de code
(`agora.md` §13). Un projet découvert sans AGORA la reçoit au premier passage ;
seule exception : un jumeau qui partage celle de l'autre et le précise.
Prévoir les chiffres avant de figer le modèle de données : section « Chiffres »
avec définitions ou « aucun chiffre prévu au JJ/MM/AAAA, parce que… »
(`collaboration.md` règle 57, `chiffres-diffuses.md` §0).

## Règle de propagation — la plus importante

Une modification de MD-LIB ne modifie aucun autre dépôt et ne garantit pas sa
lecture par une session ouverte. Actualiser puis relire les sources dans les
sessions concernées. Il n'y a aucune communication automatique entre comptes.

- Depuis le 04/11/2026, ne plus recopier `collaboration.md` dans les `CLAUDE.md`
  consommateurs : utiliser le chargement commun, avec lecture explicite si
  l'import n'est pas disponible.
- Les `AGENTS.md` gardent une copie autonome des consignes essentielles Codex.
  Les procédures non importées et les exceptions locales se reportent seulement
  dans les projets où leur contexte existe (règle 47).
- Pour une modification de source : commit et publication dans MD-LIB d'abord.
  Hors mises à jour déjà autorisées ci-dessous, proposer la liste des projets
  concernés et obtenir l'accord avant toute propagation. Respecter ensuite les
  consignes de chaque dépôt ; ne pas appliquer le workflow de MD-LIB partout.
- Les références CD47 restent des références : ne pas en dupliquer les résumés.

**Ménage au prochain « pull » de chaque projet** (accord du 04/11/2026) :
si sa ligne commune manque, préparer le retrait des seules copies sans apport
local de `collaboration.md`. Garder exceptions, workflow, commandes, sécurité,
AGORA et décisions propres au projet. Ajouter la ligne :

> Règles communes de collaboration : MD-LIB/collaboration.md, chargé
> automatiquement par MD-LIB/CLAUDE.md (04/11/2026). Ici, seulement ce qui est
> propre au projet.

Présenter les éléments retirés/gardés et les lignes avant/après ; attendre
l'accord pour ce ménage, puis publier selon le projet. Ne pas modifier son
`AGORA.md` ou `CHANTIERS.md` pour ce seul ménage.

**`AGENTS.md` au même « pull »**, sans redemander (accord du 04/11/2026) :
vérifier autorisations, tous les tests du déploiement avant push, fin de tâche,
champ de secret/gestionnaire de mots de passe et, si le projet prescrit `main`,
« Main toujours » (`git-workflow.md` §3). Les précisions récentes se vérifient
aussi dans les copies déjà complétées. Publier selon le projet et noter l'état
dans sa passation ; actualiser le suivi ici. SMS-mail, gelé, est exclu.

## Projets consommateurs actuels

Leurs particularités utiles et les seules actions restantes sont regroupées
dans [`CHANTIERS.md`](CHANTIERS.md#projets-consommateurs--repères).
Toujours relire les consignes du projet avant de le modifier.

## Reste à propager

Voir [`CHANTIERS.md`](CHANTIERS.md#reste-à-propager). Les opérations se font au
prochain passage dans chaque projet, sans propagation groupée. Les preuves des
opérations achevées restent dans Git ; ne pas rétablir leur récit ici.

## Workflow git de ce repo

Dépôt documentaire public : aucun fichier d'usagers ni secret. Publier sur
`main`, un commit conventionnel en français par modification logique. Aucune
suite de tests ni CI bloquante n'est configurée ici. Vérifier contenu, renvois,
numéros conservés et `git diff --check` ; si des scripts changent, les vérifier.
Actualisation et intégration explicite : `git-workflow.md`. Après publication,
vérifier le commit distant ; ne pas annoncer un site « en ligne » pour une
simple mise à jour documentaire. Preuve de déploiement : `deploiement.md`.

## AGORA et passation

Chaque projet garde son `AGORA.md` et son `CHANTIERS.md`. Le contradicteur lit
les vrais fichiers depuis le dépôt ; l'utilisateur garde la décision. Auteur
Claude → relecteur Codex ; auteur Codex → relecteur Claude pour les critères
prévus par `agora.md` §12. Identité et indépendance doivent être traçables.
Sur « pull » de contradiction : répondre seulement aux blocs destinés à
l'assistant courant, dans `AGORA.md` uniquement ; jamais à son propre bloc.
Une seule relecture de livraison, sans boucle systématique (règle 58).

## Audit de sécurité trimestriel

La procédure et le dernier état consigné sont dans `rgpd-securite.md` ; l'état
réel d'une routine se vérifie dans son environnement. Ne pas supposer que les
outils de routine, hooks Claude ou connecteurs existent dans Codex. Une note de
configuration ne prouve aucune exécution.
