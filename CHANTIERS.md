# CHANTIERS — état courant de MD-LIB

État au **16/11/2026 à 22:20** (Paris), base `main` `387ce47`.
Périmètre : MD-LIB uniquement ; aucun projet consommateur modifié par cette
session. La réorganisation et le circuit Claude/Codex symétrique sont approuvés
par l'utilisateur le 16/11/2026. Les anciennes passations restent dans Git.

## Contrôles et reprise

- Réorganisation documentaire : règles numérotées conservées, entrées Claude
  et Codex distinctes, index dans README, suivi courant ici. Arbitrages Git
  et données d'usagers harmonisés selon les décisions existantes.
- Contrôles effectués : 19 Markdown, liens locaux, 71 identifiants de règles,
  sections numérotées et cinq familles de tests conservés ; `git diff --check`
  et syntaxe des exemples Bash vérifiés. Aucun script ni format applicatif
  modifié ; aucune suite de tests ou CI bloquante configurée dans ce dépôt.
  Destination de publication : `main`. Le commit de refonte se retrouve dans
  `git log --oneline -- CHANTIERS.md` ; vérifier sa présence sur `origin/main`.
- AG-003 clos le 16/11/2026 (amendé) : relecture Claude `5b7c258`, corrections
  `c8cd55e`, décision « Codex autorisé » `b1e8aa2`. Récit dans Git.

## Invariants à ne pas défaire

- La demande actuelle prime sur les anciennes passations. Lire les consignes
  du projet cible et ses faits actuels ; ce fichier n'atteste aucun déploiement
  ni état courant des autres projets.
- `collaboration.md` est la source commune ; conserver ses identifiants de
  règles, ainsi que les sections citées des procédures. Claude utilise l'import
  disponible ; Codex lit explicitement et garde un `AGENTS.md` essentiel autonome.
- Chaque projet conserve `AGORA.md` et `CHANTIERS.md`. L'utilisateur tranche,
  le contradicteur ne se répond pas. L'IA d'un autre éditeur relit selon §12 ;
  une seule vérification de livraison (règle 58), sans boucle systématique.
- Pas de propagation groupée. Les copies Codex et les adaptations pertinentes
  se vérifient au prochain passage dans chaque projet ; une session ouverte
  doit être invitée à relire les sources mises à jour.
  Les règles 28, 31 et 47 restent dans MD-LIB : ne pas proposer de propagation
  spécifique dans les projets consommateurs.
- Pas de lecture de sauvegardes ou de fichiers réels d'usagers. Contrôles réels
  dans l'application de l'utilisateur, chiffres seuls ; politique propre aux
  projets personnels selon les consignes applicables.
- Ne pas réactiver SMS-mail, gelé le 20/10/2026. Ne plus proposer les anciennes
  propagations des règles 2/17 à pptx-creator refusées le 17/10/2026.
- Ne pas reprendre PAPPERBOARD `codex/regles-collaboration` : sa fusion
  retirerait la coupure d'urgence (constat du 21/10/2026, `5aaca8b`).
  `codex/interface-simulation-fidele` (`f19df16`) est déjà intégrée au constat
  du 26/10/2026 ; archive seulement.
- `maswaddpt47-cmyk/fiches-generator` est une référence en lecture seule de
  FICHES_MEMO_ACTION_KOLB : ne jamais la modifier.
- **Codex est un outil autorisé au CD47** (charte IA, consigne 8) : décision de
  l'utilisateur du 16/11/2026, consignée dans AG-003. Ne pas rouvrir la question.

## Projets consommateurs — repères

Particularités consignées avant cette refonte, à revérifier dans chaque projet.
Les preuves détaillées et anciens commits de propagation sont dans Git.

| Projet `maswaddpt47-cmyk/…` | Particularité utile à la reprise |
|---|---|
| ATELIERS_NEWGEN | Projet pilote AGORA ; branche imposée selon plateforme, intégration dans `main` ; passation locale fait foi. |
| ateliers-cd47_NextStep | Jumeau de NEWGEN ; publication sur `main`, relais local de passation. |
| GDINV2 | Pages depuis `main` ; passation locale et documents privés séparés du dépôt public. |
| sms-mail-multi | Seul SMS-mail actif ; branche imposée selon plateforme, livraison sur `main` ; contrôle CHANTIERS présent depuis `7a8aad7`. |
| SMS-mail | Gelé : aucun développement ni portage. |
| pptx-creator | Workflow de branche imposée selon plateforme ; relire ses règles avant publication. |
| FICHES_MEMO_ACTION_KOLB | Pages depuis `main` ; référence fiches-generator strictement en lecture seule. |
| PAPPERBOARD | WoocLight, projet personnel depuis le 14/10/2026, politique/charte propres ; `main` protégée par `tests`, CI de branche verte puis SHA précis publié. |
| SpeedDial | Projet personnel, Pages, publication directe sur `main`. |
| CRConum-V10 | Pages et « Main toujours » décidés le 13/11/2026. |
| MentiAnalyser | Relire sa passation ; modèle AGENTS actualisé au constat du 13/11/2026 (`43ef075`). |

## Reste à propager

Ce sont des actions à vérifier **dans les sessions des projets concernés**,
pas une autorisation de les ouvrir tous. États ci-dessous issus des notes
antérieures ; aucun contrôle distant de ces projets effectué par cette refonte.

1. **Entrées et copies de consignes** au prochain « pull » : vérifier le ménage
   des `CLAUDE.md` et les puces `AGENTS.md` définies dans `CLAUDE.md` de MD-LIB.
   Ménage déjà consigné pour sms-mail-multi, PAPPERBOARD et SpeedDial ; autres
   projets actifs à vérifier. Autorisations/tests/Main/fin de tâche déjà
   consignés dans NEWGEN, NextStep, sms-mail-multi, PAPPERBOARD, SpeedDial,
   CRConum-V10 et MentiAnalyser selon leurs spécificités ; vérifier aussi les
   précisions récentes dans ces copies. Ne pas recréer des copies communes
   intégrales dans les `CLAUDE.md`.
2. **Gestionnaire de mots de passe, règle 69** : copie consignée dans les
   projets ci-dessus. PAPPERBOARD : connexion animateur conforme (vérifié le
   17/11/2026, `admin.php:90-96`, corrigée le 15/11 par `a883ce8`). Autres copies
   actives à vérifier au passage, ainsi que « bouton qui lance l'application ».
3. **Contrôle CHANTIERS, seuil de 30 Ko** : reporté le 16/11 dans NEWGEN et
   NextStep, présent dans sms-mail-multi, PAPPERBOARD le 17/11/2026 (`fabcea0`) ;
   reste GDINV2 et FICHES_MEMO_ACTION_KOLB au prochain passage. Hook PAPPERBOARD auparavant refusé par
   la plateforme : ne pas contourner ; son installation reste à l'utilisateur.
4. **Déploiement** : rappel consigné dans SMS-mail, sms-mail-multi, GDINV2 et
   PAPPERBOARD ; autres projets actifs à vérifier. Installation du hook
   vérifiée le 30/10/2026 dans un environnement « Micky » seulement ; second
   compte et autres environnements non vérifiés. Détecter les outils présents,
   ne pas supposer un hook universel.
5. **AGORA, autonomie et relais** : test du §9 encore non consigné pour
   sms-mail-multi, pptx-creator, FICHES_MEMO_ACTION_KOLB, PAPPERBOARD, SpeedDial
   et CRConum-V10. Relais nommant le dépôt consigné dans GDINV2 et sms-mail-multi ;
   vérifier les autres actifs quand un bloc doit circuler. MentiAnalyser :
   ancienne propagation des règles 61/62, du relais « pull » et de l'annonce
   AGORA 🔴 non consignée, à vérifier dans sa session. Adapter aussi les copies
   aux rôles symétriques aux prochains passages, en gardant les garanties (§9/§13).
   GDINV2 : retrouver et consigner l'écart assumé du 22/09/2026 — sections
   locales « Entretien » et « compléter, pas réécrire », hors liste du §9 ;
   présence actuelle à vérifier au prochain passage. pptx-creator : la première
   installation était restée sur la branche imposée ; vérifier la circulation
   sur `main` dès qu'un vrai bloc AGORA doit passer entre sessions (§7), selon
   les protections du projet. État actuel de ces copies non vérifié ici.
   **Libellé de l'annonce et rôle du contradicteur** (constat AG-003,
   16/11/2026) : les `CLAUDE.md` de NEWGEN (`origin/main` `0aee1b5`) et NextStep
   (`a73f5c0`) annoncent encore « Bloc AG-00N commité. → Dis « pull » à Codex »
   et fixent « Contradicteur : Codex ». Au prochain passage dans chaque projet :
   écrire « publié dans <owner/dépôt> » (`agora.md` §4) et ouvrir le rôle aux
   deux sens (auteur Codex → Claude, §12). Pas de rupture en attendant.
   PAPPERBOARD fait le 17/11/2026 (`fabcea0` : `CLAUDE.md` §6 et `AGORA.md`).
6. **FICHES_MEMO_ACTION_KOLB** : règle de confidentialité des captures indiquée
   non reportée au constat du 06/10/2026, à vérifier dans son contexte.
7. **Chiffres diffusés** : NEWGEN, écart de définition du taux de présence
   consigné entre Historique/mail mensuel (50 %) et bilan trimestriel (75 %) :
   décision métier à retrouver ou demander, pas de correction par déduction.
   NextStep porte une copie à vérifier. Voir les passations locales actuelles.

Les règles sur données enregistrées, chiffres affichés, mails ou archives se
reportent seulement si leur contexte existe. FICHES_MEMO_ACTION_KOLB et
pptx-creator ne nécessitaient pas les règles de calcul sans données/chiffres
concernés ; réexaminer si leur usage change. Les projets personnels gardent
leur politique propre ; les références institutionnelles restent conditionnelles.

## Pistes

Aucune piste supplémentaire proposée par cette refonte. Les actions ci-dessus
restent à traiter dans le périmètre de chaque projet, avec son état actualisé.

