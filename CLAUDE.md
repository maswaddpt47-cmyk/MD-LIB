# Règles de travail — MD-LIB

**Reprise de session : lire `CHANTIERS.md`**, qui contient la passation courante demandée par l’utilisateur.

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
| `agora.md` | Faire contredire une proposition par une autre session via un `AGORA.md` commité dans le projet : sept critères de déclenchement (le 7ᵉ : tout calcul ou chiffre affiché, 26/10/2026) observables, rôle du contradicteur, gabarit de bloc, entretien ; §12 : Codex (OpenAI) comme contradicteur des blocs de sécurité et auditeur trimestriel, et règle « l'IA qui écrit ne relit pas » |
| `consigne-audit-externe.md` | Modèle de consigne d'audit par Codex (OpenAI) : lecture seule, sans nos conclusions, chaque point avec fichier:ligne et scénario. Usage : `agora.md` §12 |
| `AGORA.md` | L'AGORA de **ce dépôt** : les blocs ouverts et tranchés sur les règles elles-mêmes (`agora.md` est la règle, `AGORA.md` est l'instance) |
| `charte-ia-cd47.md` | Résumé des 11 consignes d'utilisation de l'IA du CD47 (données personnelles, identifiants, relecture humaine, sobriété…) et ce qu'elles changent dans nos projets. Le PDF interne fait foi, non publié ici (dépôt public). Référence, pas une règle à copier |
| `archivage-cd47.md` | Résumé du guide « Archivage et protection des données personnelles » du CD47 : DUC/DUA, tableau de gestion, visa des Archives départementales pour toute élimination (purges automatiques comprises), nommage V0.x/V1. Le PDF interne fait foi, non publié ici. Référence, pas une règle à copier |
| `charte-graphique-cd47.md` | Charte graphique du CD47 en texte : couleurs officielles (bleu `#4389BD`…), polices (Capriola, Verdana), règles du logo, fichiers à utiliser. **À lire avant toute production aux couleurs du CD47.** Le PDF source `charte-graphique-cd47.pdf` fait foi. Référence, pas une règle à copier : un projet la cite et s'y conforme |
| `chiffres-diffuses.md` | Tout projet dont les calculs ou statistiques sont montrés aux élus ou à la hiérarchie : audit Codex sur l'export réel avant diffusion, cinq familles de tests (parcours idempotent, même population, recomptage indépendant, provenance, unité), tableau « affiché / recompté / écart ». Posé le 20/10/2026 après l'audit de GDINV2 (251 tests verts, 14 défauts de calcul). Règle 33 de `collaboration.md` |
| `deploiement.md` + `outils/` | Ne jamais annoncer « en ligne » avant le ✅ de `outils/attendre-deploiement.sh` (workflows GitHub Actions du commit poussé). Déclenché après chaque `git push` par un hook que le Setup script de l'environnement installe (`outils/script-demarrage.sh`, à coller par l'utilisateur). Rien à copier dans les projets : une ligne de rappel dans leur `CLAUDE.md` suffit |

**À lire en premier** quand on s'apprête à ajouter une règle quelque part :
`hygiene-instructions.md`. Les autres fichiers disent quoi faire, celui-là dit
où l'écrire — et quand ne pas l'écrire du tout.

## Convention de nommage

Nommer chaque fichier **d'après son contenu**, pas d'après le projet
d'origine d'où il a été extrait la première fois (ex. `collaboration.md`,
pas `ATELIERS_NEWGEN.md`) — l'objectif est la réutilisation multi-projets,
un nom lié à un repo précis n'a pas de sens ici et crée un risque de
collision quand on ajoute d'autres projets.

## Nouveau projet — AGORA installée dès la création

Tout projet a son `AGORA.md` et sa section « AGORA » dans son `CLAUDE.md`
(`agora.md` §13, décidé le 17/10/2026). Une session qui crée un projet l'installe
avant le premier commit de code ; une session qui découvre un projet sans AGORA
l'installe et le dit au premier message. Seule exception : un jumeau qui partage
l'`AGORA.md` de l'autre et le dit dans son `CLAUDE.md`.

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

- `maswaddpt47-cmyk/SMS-mail` et `maswaddpt47-cmyk/sms-mail-multi` —
  **ne sont plus des jumeaux depuis le 20/10/2026** : SMS-mail (solo) est
  **gelé** sur décision de l'utilisateur, plus aucun développement ni
  portage ; `sms-mail-multi` est désormais le seul actif. **`agora.md` et la
  tenue de `CHANTIERS.md` propagés le 26/09/2026** : `AGORA.md` et
  `CHANTIERS.md` à la racine de chacun, sections « Reprise de session » et
  « AGORA » dans leur `CLAUDE.md`. Chaque repo garde son propre `AGORA.md`.
  **Non fait** : `scripts/check-chantiers.sh` (hook `SessionStart`), reporté
  par l'utilisateur — reste valable pour sms-mail-multi seul. Test
  d'auto-suffisance du §9 **pas encore passé** sur sms-mail-multi (sans
  objet pour SMS-mail, gelé). Branche de session imposée, mergée dans `main`
  en fin de session.

- `maswaddpt47-cmyk/pptx-creator` — **`CHANTIERS.md` et `agora.md`/`AGORA.md`
  propagés le 28/09/2026** : `CHANTIERS.md` et `AGORA.md` créés à la racine,
  section « AGORA » ajoutée à son `CLAUDE.md` (six critères, exclusions,
  phrase « soumet d'office, ne bloque jamais »), renvoi vers `CHANTIERS.md`
  en tête de son `CLAUDE.md`. Premier chantier consigné : la décision à
  trancher sur l'import `.doc`/`.docx` dans le mode « Adapter un PPTX
  existant ». **Écart assumé** : la règle §7 d'`agora.md` (push direct sur
  `main` pour un bloc AGORA, exception au workflow de branche) n'a pas été
  appliquée à ce premier commit — la session qui a propagé était contrainte
  par sa plateforme à ne pousser que sur sa branche de session imposée, avec
  merge dans `main` en fin de session, conformément au `CLAUDE.md` du projet.
  À corriger dès qu'un vrai bloc AGORA (pas la mise en place initiale) doit
  circuler entre deux sessions. Test d'auto-suffisance du §9 **pas encore
  passé** (aucune session tierce n'a relu la copie). Branche de session
  imposée par la plateforme, mergée dans `main` en fin de session.

- `maswaddpt47-cmyk/FICHES_MEMO_ACTION_KOLB` — générateur Word de fiches
  Action / Mémo / Kolb (GitHub Pages). **Tenue de `CHANTIERS.md` (règle 8ter
  de `collaboration.md`) propagée le 29/09/2026** : `CHANTIERS.md` à la racine,
  `CLAUDE.md` minimal qui y renvoie, et `scripts/check-chantiers.sh` copié
  depuis NEWGEN avec son hook `SessionStart` (rappel de ménage seul, sans les
  tests propres à NEWGEN ; testé muet sur un fichier à jour, alertant sur un
  en-tête vieilli et une tâche barrée). **Non propagés** : les autres règles
  de `collaboration.md` et `agora.md`. Branche de session imposée par la
  plateforme, `main` mis à jour en avance rapide (GitHub Pages ne déploie que
  `main`). `maswaddpt47-cmyk/fiches-generator` y sert de référence en lecture
  seule : ne jamais le modifier.
  **AGORA installée le 17/10/2026** (`AGORA.md` + section « AGORA » dans son
  `CLAUDE.md`, qui disait « Pas d'AGORA ici » ; l'encart Codex est conservé).
  Test d'auto-suffisance du §9 pas encore passé.

- `maswaddpt47-cmyk/PAPPERBOARD` — application **WoocLight** (participation
  en direct type Wooclap, PHP + JSON). Créé le 09/10/2026 : `CLAUDE.md` avec
  les règles copiées (git, collaboration, tests dosés, RGPD/sécurité),
  `CHANTIERS.md` et `scripts/check-chantiers.sh` copié depuis NEWGEN.
  **Projet personnel depuis le 14/10/2026** : hors obligations du CD47,
  compte Alwaysdata personnel `wooclight`, charte propre « Papier & Terre »
  (conçue dans Claude Design, validée le 15/10/2026 ; plus de charte CD47),
  l'utilisateur est responsable de traitement. En ligne le 14/10/2026.
  **Non fait** : le hook `SessionStart`, refusé à Claude par la plateforme,
  à créer par l'utilisateur. Références au CD47 retirées de tout le dépôt le 14/10/2026 (`fae9607`).
  **`AGORA.md` créé le 17/10/2026** (section 6 de son `CLAUDE.md`, blocs AG-001
  et AG-002 ouverts après coup, test d'auto-suffisance du §9 pas encore passé) ;
  la sécurité reste à Codex (`agora.md` §12, règle 4), deux audits passés le 10/10/2026. `main` protégée par
  un ruleset (contrôle `tests`) : pousser la branche de session, attendre la
  CI verte, puis `git push origin <sha>:main` en avance rapide ; le
  déploiement part tout seul.

Vérifier leur `CLAUDE.md` respectif avant de propager, les conventions
peuvent diverger d'un projet à l'autre.

## Reste à propager

Les comptes rendus de propagation ont été retirés le 17/10/2026 (AG-002,
amendé) : qui a propagé quoi, quand et dans quel commit est dans `git log`,
ici et dans chaque projet — `hygiene-instructions.md` §5. Ne subsiste que ce
qui demande encore une action :

- **Captures envoyées à Claude** (`rgpd-securite.md`) : pas propagée à
  FICHES_MEMO_ACTION_KOLB (dépôt non attaché le 06/10/2026).
- **`deploiement.md`** : ligne de rappel posée dans SMS-mail, sms-mail-multi,
  GDINV2 et PAPPERBOARD seulement ; manque dans les autres. **Hook non
  installé** (Setup script pas encore collé par l'utilisateur).
- **Règles 2 et 17 de `collaboration.md`** : pas propagées à PPTX-CREATOR
  (attache refusée par la plateforme ; l'utilisateur y renonce le 17/10/2026, ne plus le
  proposer).
- **Règles 27 à 31 de `collaboration.md`** : 27, 29 et 30 propagées le
  17/10/2026 dans les **huit** projets (NEWGEN, NextStep, GDINV2, SMS-mail,
  sms-mail-multi, PAPPERBOARD, FICHES_MEMO_ACTION_KOLB, PPTX-CREATOR), au
  format propre à chacun. **28 et 31 restent ici** : leur contexte (l'AGORA
  lui-même, le rythme des blocs) ne se reproduit pas dans un projet.
- **`scripts/check-chantiers.sh`** : manque dans SMS-mail et sms-mail-multi
  (reporté par l'utilisateur) ; hook refusé à Claude dans PAPPERBOARD.
- **`chiffres-diffuses.md` / règle 33** (20/10/2026) : propagée à GDINV2
  (section « Chiffres diffusés », 5 familles de tests posées). NEWGEN : tests
  de concordance ajoutés (PR #35), écart de « taux de présence » entre
  Historique/mail mensuel (50 %) et bilan trimestriel (75 %) **à trancher par
  l'utilisateur** ; NextStep porte les mêmes fichiers, pas encore vérifié.
  Pas propagée : PAPPERBOARD (projet personnel, chiffres vus des participants,
  audits Codex déjà passés), autres projets sans chiffre diffusé aux élus.
- **Critère 7 d'`agora.md`** (26/10/2026 : tout calcul ou chiffre affiché ouvre un bloc AGORA, contradicteur Codex) : propagé à NEWGEN, NextStep, GDINV2 (`98ce116`) et PAPPERBOARD (`dd4fe81`) le 26/10/2026 ; non propagé aux projets sans chiffre affiché (SMS-mail gelé, sms-mail-multi, pptx-creator, FICHES_MEMO_ACTION_KOLB) — à reposer si l'un d'eux se met à calculer.
- **Règles 34 à 37 de `collaboration.md`** (compte rendu recoupé et
  attribué, passages réels d'une tâche programmée, moyen d'arrêt essayé en
  réel) et **38** (élément exact nommé) : propagées les 26 et 27/10/2026 dans
  les sept projets actifs (SMS-mail gelé, non touché).
- **Phrase de relais nommant le dépôt** (`agora.md` §4, corrigé le 22/10/2026,
  commit `d51effe`) : inscrite dans l'`AGORA.md` de GDINV2 seulement. Manque
  dans NEWGEN, NextStep, SMS-mail, sms-mail-multi, PAPPERBOARD,
  FICHES_MEMO_ACTION_KOLB et PPTX-CREATOR. **À faire au fil des sessions**,
  quand on travaille déjà dans le projet (choix de l'utilisateur, 22/10/2026 —
  ne pas attacher sept dépôts pour une ligne). Une session qui ouvre un bloc
  sans cette phrase sous les yeux omet le dépôt : le contradicteur ouvre alors
  l'AGORA de l'endroit où il se trouve, et chaque projet a sa propre
  numérotation.
- **Test d'auto-suffisance du §9** non passé pour SMS-mail, sms-mail-multi,
  pptx-creator, FICHES_MEMO_ACTION_KOLB et PAPPERBOARD.

Tranché et à ne pas reproposer : les résumés `charte-ia-cd47.md` et
`archivage-cd47.md` ne sont renvoyés que depuis NEWGEN et NextStep — ailleurs
la ligne de `rgpd-securite.md` suffit (choix de l'utilisateur, 06/10/2026).

## Workflow git de ce repo

Pas de suite de tests, pas de CI bloquante ici — repo purement
documentaire. Un commit par modification logique, message conventionnel
(`feat:`, `fix:`, `refactor:`, `docs:`, `chore:`). Push direct sur `main`
sauf si la plateforme impose une branche de session, auquel cas merger
dans `main` en fin de session (`git checkout main && git merge <branche>
--no-ff && git push origin main`).

## Audit de sécurité trimestriel

Une routine planifiée (voir `rgpd-securite.md`) tourne indépendamment de
toute session pour auditer ATELIERS_NEWGEN, NextStep, GDINV2 (ajouté le
20/09/2026), SMS-mail/sms-mail-multi (ajoutés le 23/09/2026) et les
workflows d'`ateliers-backups` (ajoutés le 30/09/2026, consigne mise à jour
pour l'API PHP ce jour-là). Elle n'a pas
besoin que ce repo soit attaché — vérifier avec `list_triggers` si son état
est en doute.
