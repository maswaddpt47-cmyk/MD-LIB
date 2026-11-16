# AGORA — faire contredire une proposition par une autre session

Méthode commune aux projets, établie le 21/09/2026 ; clarifiée pour Claude et
Codex sur accord de l'utilisateur le 16/11/2026. Les numéros §1 à §13 restent
stables pour les renvois des projets.

Le contradicteur lit la proposition et les vrais fichiers du dépôt, avec un
contexte distinct. L'AGORA porte le débat ; `CHANTIERS.md` porte les travaux,
décisions en attente et invariants. Le relais entre comptes reste utilisateur.

## 1. Le déclenchement ne repose pas sur un ressenti

Ouvrir un bloc sur un **fait observable** du §2, plutôt que sur la confiance
de l'auteur. L'utilisateur doit pouvoir retrouver le déclencheur dans le diff.
Une affirmation technique conserve son statut mesuré ou supposé
(`hygiene-instructions.md` §3).

## 2. Les sept déclencheurs

Chaque entrée « décision à trancher » dans `CHANTIERS.md` est candidate : dire
au moment de l'écrire pourquoi un bloc est ouvert ou non.

1. **La décision ferme une porte** : schéma de données, format de stockage,
   nouvelle dépendance ou contrat entre modules dont l'abandon coûte une migration.
2. **Deux options ont été envisagées, une seule écrite sans arbitrage extérieur**
   (`collaboration.md` règle 4).
3. **Trois itérations sans résolution** du même problème (règle 10).
4. **Défaire un existant dont la raison d'être n'est pas retrouvée.**
5. **Contredire une note datée du dépôt** : `CLAUDE.md`, `CHANTIERS.md` ou
   commentaire de décision.
6. **Coût irréversible pour l'usager** : suppression de données, migration,
   rupture d'une PWA installée.
7. **Toucher un calcul ou un chiffre affiché** : indicateur, total, taux,
   moyenne, filtre ou définition, à l'écran, dans un export ou un imprimé.
   Systématique, quelle que soit la taille du changement. Ouvrir le bloc
   **avant la correction** ; séparer les défauts démontrés des définitions
   métier, que tranche l'utilisateur. Auteur Claude : contradicteur Codex ;
   auteur Codex : contradicteur Claude (§12, `chiffres-diffuses.md` §1).

## 3. Ce qui ne va PAS à l'AGORA

- Rendu pur (`collaboration.md` règle 17).
- Correctif localisé appuyé sur une preuve : log, test rouge puis vert.
- Changement qui se défait en un commit.

Ces exclusions valent **en l'absence d'un déclencheur du §2** ; elles ne
dispensent jamais du critère 7. L'installation du dispositif est exemptée (§13).

## 4. Qui déclenche, qui tranche, à quel moment

L'utilisateur peut demander un bloc sur tout sujet. Sur critère rempli,
**l'auteur le soumet d'office**, sans demander l'autorisation, au moment du
choix et avant le code. Le publier selon le §7, puis l'annoncer en tête du
message, sur une ligne distincte :

> 🔴 **⚖️ AGORA : critère N — <sujet>. Bloc AG-00N publié dans <owner/dépôt>.
> → Dis « pull » à <Codex ou Claude>.**

Le relais nomme le dépôt au format GitHub `owner/nom` et le contradicteur.
Phrase complète si nécessaire : « pull <owner/dépôt>, lis son `AGORA.md`,
réponds à AG-00N, tu es <Codex ou Claude, session B> ». Le libellé ne prouve
pas l'identité de session (§10).

**L'utilisateur tranche.** Le contradicteur apporte un constat, pas une
autorisation. Cycle : dépôt du bloc → relais utilisateur → réponse dans le
dépôt → décision de l'utilisateur.

**L'AGORA ne bloque jamais le travail indépendant.** Pour un enrichissement
réversible, ouvrir le bloc au choix, livrer la version testée autorisée, puis
faire vérifier la livraison **une seule fois**. Corriger et livrer les écarts
démontrés sans nouvelle relecture d'office (`collaboration.md` règle 58).
Un contrat irréversible reste soumis **avant le code** ; l'attente ne vaut
jamais accord de l'utilisateur. Le champ « Si personne ne répond » précise
la suite autorisée et ce qui reste à trancher.

## 5. Le rôle du contradicteur — compléter, pas refaire

Lire les fichiers et chercher ce qui serait faux, manquant ou coûteux sans
réécrire la proposition. Trois verdicts possibles :

- **confirmé**, en nommant aussi ce qui n'a pas pu être vérifié ;
- **amendé**, en nommant l'écart qui change le code, une décision ou un chiffre ;
- **contredit**, avec le constat qui le prouve.

**Jamais de réponse à son propre bloc.** Vérifier l'identité selon le §10.
Une réponse sans `fichier:ligne`, mesure ou log ne compte pas ; aucune donnée
d'usager ne sert de preuve publiée.

### Sincérité — trois contraintes contre la politesse

1. **« Amendé » exige un écart réel.** Si l'amendement ne change ni code, ni
   décision, ni chiffre, le verdict est « confirmé ».
2. **« Confirmé » est une réponse pleine.** Ne pas chercher un amendement
   pour justifier sa présence.
3. **Aucune appréciation de la proposition ou de son auteur.** Commencer par
   un constat, sans compliment.

Le bilan des blocs tranchés porte leurs verdicts et le total des trois issues.
**Le total est une alerte, pas un objectif** : juger chaque bloc sur ses preuves,
jamais sur la série des verdicts précédents.

## 6. Le gabarit d'un bloc

```markdown
## AG-00N — Titre court — ouvert le JJ/MM/AAAA
**Auteur** : <Claude ou Codex, trace de session/travail> — lu sur `<sha court>`
**Proposition** : trois lignes maximum.
**Critère déclencheur** : n° et lequel.
**Contradicteur** : Codex | Claude (session B)
**Ce que ça engage** : ce qui serait coûteux à défaire.
**Non vérifié par l'auteur** : limites de la vérification.
**Si personne ne répond, je fais quoi ?** : suite autorisée et décision restante.
**Où regarder** : fichier.js:120-180

### Réponse — <Codex ou Claude> — JJ/MM/AAAA
**Auteur** : <autre session/travail, trace disponible> — lu sur `<sha court>`
**Verdict** : confirmé | amendé | contredit
**Constat** : avec fichier:ligne, mesure ou log.
**Amendement** : ...

### Tranché le JJ/MM/AAAA — décision : ...
```

`lu sur <sha court>` désigne le commit réellement lu (`git log --oneline -1`).
« Non vérifié par l'auteur » oriente la contradiction vers les limites connues.
Le champ `Auteur` renvoie à la trace du §10 ; un nom différent ne suffit pas.

## 7. Le fichier doit circuler, donc il vit sur `main`

Publier le bloc ou la réponse **sur `main` immédiatement**, avec les contrôles
et protections du projet ; une branche de session seule ne le rend pas
accessible aux autres sessions. Ne jamais contourner une protection.

Écriture **append-only** pendant le débat : ajouter son bloc ou sa réponse,
ne pas réécrire le texte d'une autre session. L'entretien du §8 vient ensuite.
Juste avant de rédiger, synchroniser puis relire le fichier :

```bash
git fetch origin main
git merge --ff-only origin/main
```

Préserver les modifications locales. Avant le push, vérifier le diff complet
par rapport à `origin/main` : il ne doit publier que le travail voulu. Pousser
le commit vérifié, pas un `HEAD` qui aurait changé pendant une attente.
Si la branche diverge ou si un push concurrent est rejeté, préserver le
travail et reporter l'ajout relu depuis une copie à jour ; aucun force-push,
aucun rebase de commits publiés. Détails : `git-workflow.md`.

## 8. Entretien — sinon plus personne ne le lit

- Sortir un bloc dès que la décision est prise et ses amendements appliqués.
  Conserver sa décision utile dans `CHANTIERS.md` (invariant) ou les consignes
  du projet ; le récit reste dans Git. Garder un bilan compact des verdicts.
- Une mesure restant à faire va dans `CHANTIERS.md`, pas dans un débat laissé
  ouvert alors qu'il n'y a plus de décision.
- Quand un sujet sans réponse revient, l'utilisateur peut relancer ; sinon
  noter « tranché sans contradiction le JJ/MM/AAAA » avec la décision retenue.
  Cette mention ne donne aucune autorisation d'action irréversible.
- Pour un désaccord persistant, chercher l'observation qui départagerait les
  avis : mesure, log ou essai court. Si aucune ne le peut, l'utilisateur
  tranche ; ne pas ajouter un troisième avis par défaut.
- Aucun export, log brut ou fichier réel d'usagers dans un bloc
  (`rgpd-securite.md`, `collaboration.md` règle 59).

## 9. Ce qu'on copie dans un projet consommateur

Les fichiers du projet doivent suffire, même sans MD-LIB :

1. **`AGORA.md`** : gabarit (§6) ; interdiction de l'auto-réponse et preuve
   d'identité (§10) ; append-only et circulation (§7) ; absence de données
   d'usagers ; trois contraintes de Sincérité et total des verdicts (§5) ;
   cycle de relais utilisateur et absence de notification automatique (§4).
2. **Consignes de démarrage du projet** : sept déclencheurs (§2), exclusions
   (§3), soumission d'office, poursuite du travail indépendant et réserve sur
   l'irréversible (§4), publication sur `main`, rôle du contradicteur (§12)
   et renvoi vers `AGORA.md`. `CLAUDE.md` les porte pour Claude ; `AGENTS.md`
   contient ce dont Codex a besoin sans supposer un import automatique.

La section AGORA du `CLAUDE.md` tient en **35 à 50 lignes**. Ne pas répéter en
prose les champs explicites du gabarit. Toute adaptation propre au projet
conserve sa raison dans ses consignes ; l'état de propagation va dans le suivi
des projets de MD-LIB.

**Test d'auto-suffisance** : une autre session, sur un autre compte et sans
MD-LIB, doit pouvoir ouvrir un bloc et y répondre avec les fichiers du projet
seuls. Tant qu'elle a besoin de MD-LIB pour agir, la copie est incomplète.
Les renvois vers `MD-LIB/agora.md` indiquent « non requis pour répondre ».
Les explications restent ici, sans recopier toute cette méthode.

## 10. Fonctionner entre deux comptes et identifier les sessions

Le canal commun est le dépôt Git, comme pour `CHANTIERS.md`. Chaque compte
doit avoir accès au dépôt et les copies doivent suffire sans MD-LIB (§9).
Sans droit d'écriture, l'utilisateur rapporte la réponse, conservée telle
quelle ; ne pas prétendre qu'elle a été publiée automatiquement.

**Avant une réponse, identifier l'auteur du bloc et le contradicteur.** Lire
le commit de dépôt avec `git log -1 --format=%B <sha du bloc>` :

- **Claude** : conserver son vrai trailer `Claude-Session:` lorsqu'il existe
  et l'identifiant de session correspondant.
- **Codex** : consigner l'éditeur (OpenAI), le commit de dépôt et la trace de
  tâche/conversation réellement disponible. À défaut d'identifiant natif,
  un identifiant de travail peut être enregistré sous `Codex-Session: local:<id>` ;
  le qualifier explicitement de **local**, jamais d'identifiant de plateforme.

Le trailer et le champ `Auteur` relient le travail au commit ; un identifiant
local ou deux libellés différents ne prouvent pas à eux seuls l'éditeur ni
l'indépendance. Recouper avec la provenance du relais utilisateur et l'outil
de la session qui répond. Même auteur : ne pas répondre à son propre bloc.
**Identité ou indépendance non démontrable**, trailer absent sans autre trace,
reprise incertaine : signaler la limite et demander l'arbitrage de l'utilisateur
avant la réponse. Consigner sa confirmation comme telle, sans l'appeler preuve
technique. Ne pas inventer d'identifiant natif ni de capacité indisponible.

Aucune notification intercomptes ou entre Claude et Codex n'est assurée par
ce protocole. **L'utilisateur fait le relais** (§4) ; Git ne lance pas l'autre
outil et ne transmet pas le contexte de conversation.

## 11. Le point faible connu du dispositif

Les instructions seules ne garantissent pas qu'un déclencheur sera remarqué.
L'annonce doit se voir, les critères doivent être vérifiables dans le diff,
et le fichier de démarrage doit rester court. Ne pas annoncer de surveillance
ou de communication entre sessions sans mécanisme réellement vérifié.

## 12. Un contradicteur d'un autre éditeur : Claude et Codex

**L'IA qui écrit ne se certifie pas elle-même.** La relecture d'un contenu
produit par IA (code, texte, questions de quiz) revient à une IA **d'un autre
éditeur** ; une nouvelle conversation du même modèle n'est pas cette relecture.

| Auteur du travail | Contradicteur indépendant |
|---|---|
| Claude | Codex |
| Codex | Claude, dans une autre session |

Le champ `Contradicteur` nomme cet outil. L'ancien libellé « session B »
désigne la session externe de relecture, sans dispenser d'identifier son
éditeur. Le contradicteur lit et répond ; **l'auteur corrige**, sauf demande
explicite de correction par l'utilisateur. En lecture seule, aucun changement
de code.

- **Sécurité, authentification, données personnelles et chiffres** : circuit
  indépendant ci-dessus (§2 critère 7, `chiffres-diffuses.md`).
- **Audit trimestriel** : audit externe, le jour prévu par la routine d'audit,
  avec `consigne-audit-externe.md`. Audit ponctuel après une évolution
  structurante de connexion, mots de passe, page publique ou hébergement.
- **Regard indépendant** : lire les consignes obligatoires de fonctionnement
  et de sûreté ; faire son relevé sur le code avant de consulter les conclusions
  d'anciens audits. Dire si elles étaient déjà connues. Rapport vérifié hors
  dépôt public.
- **Données** : aucune lecture de sauvegarde ni de fichier réel d'usagers.
  Rejouer sur jeux fictifs autorisés ; les contrôles réels restent dans
  l'application de l'utilisateur, chiffres seuls (`chiffres-diffuses.md` §1).
- **Relecture de contenu** : public → fond → sources → forme. Sources précises
  ou « pas de source sûre » ; l'utilisateur ouvre les liens et tranche.
  Une seule relecture, puis correction des écarts démontrés, sans second tour
  d'office (`collaboration.md` règle 58).

**Réponse directement dans `AGORA.md`** : l'utilisateur peut autoriser le
contradicteur à ajouter sa réponse et la publier sur `main`, sans modifier
d'autre fichier. Contrôler `git show --stat` et le diff de ce commit : seul
`AGORA.md`, aucune ligne retirée. Sinon préserver les changements, signaler
l'écart et corriger selon le workflow, sans annulation destructive improvisée.

**Dire « pull » suffit** : après synchronisation (§7), Codex traite les blocs
ouverts qui le désignent et n'ont pas de réponse Codex, sous
`### Réponse — Codex — JJ/MM/AAAA`, dans `AGORA.md` seulement, puis commit et
push sur `main`. Son `AGENTS.md` porte ce geste. Symétriquement, Claude répond
aux blocs qui le désignent, selon les consignes du projet. Aucun ne répond à
son propre bloc (§10). Sans bloc en attente, le dire en une ligne.
L'auteur annonce toujours le bloc publié : l'utilisateur déclenche le relais.

## 13. Installation systématique dans chaque projet (17/10/2026)

Tout projet a son AGORA dès sa création. Une session découvrant un projet
sans AGORA l'installe et le signale. Installation en un commit, avant le premier
code d'un nouveau projet :

1. **`AGORA.md` à la racine** : partir de `MD-LIB/AGORA.md`, sections d'en-tête,
   règles de réponse, Sincérité et gabarit, **sans ses blocs ni ses totaux**.
   Adapter le titre, le dépôt du relais, le workflow Git et les renvois locaux.
2. **Section AGORA du `CLAUDE.md`** (35 à 50 lignes) : §2, §3, soumission
   d'office, poursuite du travail indépendant et réserve sur l'irréversible,
   renvoi local, rôles symétriques du §12. Son renvoi éventuel vers MD-LIB dit
   « non requis pour répondre ». L'`AGENTS.md` porte les consignes utiles à Codex.
3. **`CHANTIERS.md`** : date d'installation et rappel « chaque décision à
   trancher est candidate à un bloc ».
4. **Suivi des projets de MD-LIB** : date et état du test d'auto-suffisance du
   §9, « pas encore passé » tant qu'aucune session indépendante n'a répondu.

**Jumeaux** : des dépôts partageant le code peuvent partager une AGORA si
les consignes du second nomment explicitement le dépôt de référence.
**Pas de bloc pour l'installation elle-même.** Les décisions déjà prises qui
ferment une porte peuvent être soumises ensuite, marquées « soumis après coup ».
