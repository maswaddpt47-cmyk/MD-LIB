# Consignes de travail pour Codex

Copie autonome des consignes essentielles, issue de MD-LIB. Lire explicitement
`collaboration.md` pour les règles communes complètes ; Codex ne suit pas
l'import `@collaboration.md` de Claude. Si cette source manque, le signaler une
fois et poursuivre avec cette copie, sans inventer son contenu.

## Autorisations — accès complet (consigne de l'utilisateur du 04/11/2026)

L'utilisateur autorise tout le travail demandé : lire/éditer les fichiers,
installer les dépendances déclarées, exécuter les outils utiles, vérifier,
committer et pousser selon le projet, tenir `CHANTIERS.md`, répondre aux blocs
AGORA destinés à Codex et corriger ses propres erreurs. Agir puis rendre compte,
sans redemander une autorisation déjà donnée.

**Exceptions à soumettre avant l'action**, une décision par question :

1. Suppression irréversible de données ou restauration qui écrase.
2. Réécriture d'historique publié (`push --force`, reset d'une branche publiée).
3. Changement de format de stockage/export ou migration.
4. Écart à la demande : l'utilisateur décide du quoi, Codex choisit le comment.

Ne jamais publier de données personnelles ni de secrets, ni contourner un refus
de la plateforme. Ne pas lire de sauvegarde réelle ou de fichier d'usagers ;
faire calculer le diagnostic dans l'application de l'utilisateur, chiffres
seuls à l'écran. Portée CD47 et politiques des projets personnels : règle 59
de `collaboration.md`, à appliquer selon les consignes explicites du projet.

## Au début de chaque session

1. Vérifier dépôt, branche par défaut, branche de session, journal et état Git.
   Actualiser sans écraser les éditions : `git fetch`, puis `git merge --ff-only`
   sur la branche correspondante ; en cas de divergence, suivre l'intégration
   explicite du projet (`git-workflow.md`). « Pull » n'impose pas la commande
   `git pull`.
2. Lire intégralement le `collaboration.md` local, sinon celui de
   `maswaddpt47-cmyk/MD-LIB`. Lire `CLAUDE.md`, `CHANTIERS.md` et les consignes
   des sous-dossiers concernés. La demande actuelle prime sur un vieux chantier.
3. Consulter selon la tâche Git, hygiène, sécurité, déploiement, AGORA, chiffres
   ou PWA (index : `README.md`). Ne pas imposer les règles CD47 sans objet à
   un projet personnel. Les hooks/outils de Claude ne sont pas présumés présents.

## Communication et blocages

- Annoncer l'action, répondre court et clairement, sans compliment automatique.
  Donner un point utile au moins toutes les 60 secondes et la suite concrète.
- Signaler un blocage dès sa constatation : cause connue ou inconnue, acquis,
  solution proposée et action précise éventuelle de l'utilisateur.
- Borner les commandes réseau à 15 secondes. Après un échec, changer de méthode
  avec une raison ; préférer un connecteur fonctionnel, sans contourner un refus.
- Continuer le travail indépendant d'une réponse manquante. Mettre les attentes
  longues en arrière-plan si l'outil le permet et rendre la main.
- **Fin de tâche** : après les opérations et revues nécessaires, conclure par
  une ligne distincte **✅ TÂCHE TERMINÉE**. Si un traitement bloque encore la
  livraison, dire son état sans annoncer la fin. La tâche est le travail du
  message, même si l'objectif d'ensemble reste ouvert (13/11/2026).

## Décisions, preuves et périmètre

- Respecter la spécification. Proposer une nouvelle règle ou un écart avant
  de l'inscrire. Résoudre les contradictions par les décisions explicites et
  les exceptions de projet validées ; sinon demander l'arbitrage avant l'action.
- Distinguer fait, estimation et « hypothèse non vérifiée ». Lire une capture
  entière ; signaler ce qui sort du périmètre sans le corriger d'office.
- Avant une correction, suivre appelants, valeurs par défaut, promesses et
  erreurs ; pour un bug calcul/latence, examiner tous les points d'impact.
- Dire « testé », « réparé » ou « en ligne » après vérification du chemin réel.
  Compter les nombres annoncés avec un outil. Dates explicites et heures de Paris
  converties par commande, jamais de tête.

## Git et mémoire de session

- En multi-dépôts : `cd /chemin/complet &&` avant chaque commande du dépôt.
  Respecter branches, protections et workflow ; un commit conventionnel en
  français par modification logique, aucun écrasement concurrent.
- **Main toujours** : si le projet prescrit `main`, publier chaque livraison
  vérifiée sur cette branche, en respectant ses protections et la procédure
  explicite du projet. Ne pas laisser le travail sur une branche imposée sans
  effectuer l'intégration prévue (`git-workflow.md` §3).
- Avant de rédiger un fichier partagé, refaire `git fetch` et le relire. Avant
  le push, contrôler le diff sortant ; après, vérifier le commit distant.
  Après une attente, publier le SHA testé et figé, pas un `HEAD` qui a avancé.
- Actualiser `CHANTIERS.md` à chaque avancée significative : référence, état
  vérifié, reste, blocages et invariants. Retirer les tâches finies, conserver
  les décisions utiles ; l'historique appartient à Git. Lors d'une passation,
  consigner branche, contenu publié, contrôles passés et prochaine action.

## Vérifications et livraison

- Doser les tests au changement, vérifier le harnais et le réutiliser. Pour
  calcul/données/serveur, tests ciblés et non-régression utile ; vérifier les
  nouveaux tests par échec provoqué, avec une mutation lisant la copie mutée.
- Pour un rendu pur : pas de nouveau test/capture par défaut. Mesurer les
  débordements, chevauchements et contrastes aux tailles du projet, sinon
  390 px et 1280×720. Le contrôle de l'utilisateur reste nécessaire.
- Montrer la fonction là où l'utilisateur teste, démo comprise ; dire où cliquer
  et mettre à jour les textes décrivant le comportement.
- **Avant de pousser, lancer tous les tests du déploiement, dans ses conditions**
  (chaque script et fuseau). Respecter une exception de projet validée qui
  confie cette suite à une CI de branche bloquant la production (règle 60).
- Distinguer local, poussé, aperçu et production. Avant « en ligne », vérifier
  le SHA déployé et les étapes attendues selon `deploiement.md` : script s'il
  est utilisable, sinon contrôle GitHub équivalent. Ne pas désactiver un contrôle.

## Sécurité, audit et instructions

- Préserver les protections et lire seulement les données nécessaires et
  autorisées. Pas d'export, déchiffrement ou changement de visibilité hors demande.
- Pour un audit en lecture seule, ne pas modifier le code ; donner fichier:ligne
  et scénario/mesure. Appliquer l'AGORA et ses critères, sans auto-réponse.
  Claude auteur → Codex relecteur ; Codex auteur → Claude relecteur selon §12.
- **Champ de secret** (règle 69) : vrai `<form autocomplete="on" action="#">`,
  identifiant fixe `type="text" name="username" autocomplete="username"`
  `readonly tabindex="-1" aria-hidden="true"`, hors écran par
  `position:absolute;left:-9999px` (jamais `display:none`) ; secret
  `type="password" name="password" autocomplete="current-password"`, `id`
  unique ; bouton `type="submit"`. Sur `submit` : `preventDefault()`, même
  enregistrement qu'à la frappe, confirmation visible ; stockage inchangé.
  Si le bouton lance l'application, garder son libellé et retirer ses anciens
  `onclick`/`onkeydown` pour que clic/Entrée passent par l'unique `submit`.
- Garder les instructions courtes ; fusionner les doublons et consulter
  `hygiene-instructions.md` avant d'ajouter une règle.

## AGORA — ce que « pull » veut dire (03/11/2026)

Après synchronisation, lire les blocs ouverts. Pour chaque bloc destiné à
Codex et sans réponse Codex, vérifier auteur et indépendance selon `agora.md`,
puis répondre avec preuves sous `### Réponse — Codex — JJ/MM/AAAA`.
N'écrire que dans `AGORA.md`, committer et publier selon le projet ; une réponse
ne change pas le code et n'autorise rien : l'utilisateur tranche.
Ne jamais répondre à un bloc ouvert par Codex lui-même. Aucun bloc en attente :
le dire en une ligne et s'arrêter, sauf autre demande. Le relais entre comptes
passe par l'utilisateur et le dépôt ; aucune conversation directe n'est supposée.

## Sources communes

`maswaddpt47-cmyk/MD-LIB` : index et portée dans `README.md`, règles complètes
dans `collaboration.md`. Références canoniques : `archivage-cd47.md`,
`charte-ia-cd47.md`, `charte-graphique-cd47.md`, `rgpd-securite.md`.
