# AGORA — faire contredire une proposition par une autre session

Mémoire générale, valable pour tous les projets (actuels et futurs). Établie le
21/09/2026.

## Le problème que ça résout

Deux sessions Claude ne partagent aucun contexte : ni conversation, ni mémoire,
ni conteneur. Elles ne partagent que le dépôt. Mais elles n'ont pas lu les mêmes
fichiers, dans le même ordre, avec le même historique — et c'est précisément ce
qui rend leurs raisonnements différents. Cette divergence est exploitable.

Le relais manuel (copier un prompt d'une session à l'autre, rapporter la
réponse) fonctionne déjà, mais il a un défaut structurel : **la seconde session
juge une reformulation, pas le code.** Cette reformulation contient le cadrage
de l'auteur, ses hypothèses, et surtout ses angles morts — qu'il ne peut pas y
écrire, par définition. Le contradicteur part donc handicapé.

L'AGORA corrige ça : la proposition est déposée **dans le dépôt**, le
contradicteur lit **le vrai code** avec son propre contexte. C'est le seul gain
réel ; le reste (trace écrite, moins de copier-coller) est du confort.

## 1. Le déclenchement ne repose pas sur un ressenti

**Claude ne peut pas se fier à « je sens que j'ai besoin d'un autre avis ».**
Sa confiance est mal calibrée : il est souvent le plus fluide et le plus assuré
précisément là où il raisonne sur ce qu'il n'a pas vérifié — le mécanisme décrit
dans `hygiene-instructions.md` §3.

Deux échecs symétriques si on fonde le déclenchement sur l'impression :
- la main se lève sur les cas d'hésitation visible — mais ceux-là, l'utilisateur
  les voit aussi, il n'a besoin de personne ;
- elle ne se lève jamais sur les décisions assurées et fausses, qui sont
  exactement la population que l'AGORA existe pour attraper.

Donc : des **critères observables**, constatables sans avoir à s'auto-évaluer.
Même logique que `hygiene-instructions.md` §1 — ce qui peut se formuler en
critère vérifiable devient un critère, pas un paragraphe qui espère être lu.

## 2. Les six déclencheurs

Soumettre à l'AGORA dès qu'un de ces faits est constaté :

**Rappel accroché à une habitude existante :** toute entrée **« décision à
trancher »** écrite dans le `CHANTIERS.md` d'un projet est par définition un
candidat. Au moment de l'écrire, dire pourquoi on ouvre un bloc ou non. Ça
n'ajoute aucune vigilance nouvelle — `CHANTIERS.md` se met déjà à jour à chaque
avancée — et l'omission se voit dans le diff.

1. **La décision ferme une porte** — schéma de données, format de stockage,
   nouvelle dépendance, contrat entre modules. Défaire coûte une migration.
2. **Deux options ont été envisagées, une seule a été écrite, sans arbitrage
   extérieur.** Fait observable, pas une impression (prolonge la règle 4 de
   `collaboration.md`).
3. **Trois itérations sans résolution** sur le même problème. C'est un compteur
   (prolonge la règle 10).
4. **Proposition de défaire un existant dont la raison d'être n'est pas
   retrouvée** — le cas `keepAlive` supprimé puis remis.
5. **La proposition contredit une note datée du dépôt** (`CLAUDE.md`,
   `CHANTIERS.md`, commentaire de décision). Vérifiable.
6. **Coût irréversible côté usager** — suppression de données, migration,
   rupture d'une PWA déjà installée sur des postes.

Ces six critères sont **vérifiables après coup dans le diff** : l'utilisateur
peut reprocher un critère rempli resté silencieux. Un ressenti, non.

## 3. Ce qui ne va PAS à l'AGORA

Sans cette liste, l'AGORA devient un péage qui double le coût de chaque
décision :

- changement de rendu pur (cf. `collaboration.md` règle 17) ;
- correctif localisé appuyé sur une preuve (log, test rouge puis vert) ;
- tout ce qui se défait en un commit.

## 4. Qui déclenche, qui tranche, à quel moment

**L'utilisateur, en priorité.** « Soumets-le à l'AGORA » sur n'importe quel
sujet : c'est le seul déclencheur fiable à 100 %.

**Claude, sur critère rempli.** Il l'annonce en une ligne, sur le modèle du
signalement RGPD de `rgpd-securite.md` :

> ⚖️ AGORA : critère 1 (ferme une porte) — le format de stockage retenu.
> Bloc AG-004 commité. À coller dans l'autre session :
> « pull, lis AGORA.md, réponds à AG-004, tu es la session B ».

**La phrase de relais porte toujours le libellé de la session qui répond.**
C'est ce qui permet au contradicteur de remplir le champ `Auteur` et de
vérifier qu'il ne répond pas à son propre bloc — il ne peut le déduire de
rien d'autre, surtout si les deux comptes poussent sous la même identité
GitHub (§10).

**L'AGORA ne bloque jamais.** Claude continue le travail en parallèle : rien ne
garantit qu'une réponse arrive un jour.

**Claude soumet d'office, sans demander l'autorisation** — sinon c'est un
aller-retour de plus à chaque fois. Il écrit le bloc, le commite, et fournit la
phrase de relais. **C'est l'utilisateur qui décide de la coller ou non** ;
ignorer un bloc ne coûte rien.

**Le moment : quand le choix est fait, pas après l'implémentation.** Une
proposition soumise une fois le code écrit arrive devant un contradicteur qui
lit du code existant : il hérite d'un biais de statu quo et valide ce qui est
là. Soumettre avant, ou sur un brouillon.

**Qui tranche in fine : l'utilisateur.** La réponse du contradicteur n'est pas
un vote bloquant.

## 5. Le rôle du contradicteur — compléter, pas refaire

La session qui répond **ne réécrit pas la proposition**. Elle cherche ce qui
manque. Deux propositions concurrentes n'augmentent pas la qualité, elles
augmentent la charge d'arbitrage de l'utilisateur.

Trois issues possibles, jamais « d'accord / pas d'accord » :

- **confirmé** — et dire explicitement ce qui n'a pas pu être vérifié ;
- **amendé** — la proposition tient, mais il manque X. *C'est l'issue la plus
  fréquente et la plus utile ;*
- **contredit** — avec le constat qui le prouve.

**Une session ne répond jamais à un bloc qu'elle a ouvert.** Le dispositif
n'existe que pour faire lire le code par un autre contexte ; s'auto-répondre
produit un tampon de validation, pas une contradiction. Si la session ne peut
pas déterminer si le bloc est le sien — reprise, résumé de contexte,
changement de compte — elle demande à l'utilisateur avant de répondre.

**Règle de preuve : une réponse sans `fichier:ligne`, mesure ou log ne compte
pas.** Sans elle, deux textes s'accordent poliment et on obtient un tampon de
validation qui donne une fausse garantie — exactement ce que
`hygiene-instructions.md` §3 dénonce.

## 6. Le gabarit d'un bloc

```markdown
## AG-003 — Titre court — ouvert le 21/09/2026
**Auteur** : session <libellé donné par l'utilisateur> — lu sur `<sha court>`
**Proposition** : ce qui est proposé, en 3 lignes maximum.
**Critère déclencheur** : n° et lequel.
**Ce que ça engage** : ce qui serait coûteux à défaire.
**Non vérifié par l'auteur** : ...
**Si personne ne répond, je fais quoi ?** ← si la réponse est « je continue
pareil », le bloc n'avait pas lieu d'être.
**Où regarder** : fichier.js:120-180

### Réponse — 21/09/2026
**Auteur** : session <autre libellé> — lu sur `<sha court>`
**Verdict** : confirmé | amendé | contredit
**Constat** : avec fichier:ligne, mesure ou log.
**Amendement** : ...

### Tranché le JJ/MM/AAAA — décision : ...
```

**`Auteur`** n'est pas de la politesse : sans lui, rien n'empêche une session
de répondre à son propre bloc, et tout le bénéfice disparaît. Y inscrire les
**8 premiers caractères de l'identifiant de session** — celui que Claude pose
déjà dans le trailer `Claude-Session:` de chacun de ses commits. Il est unique
par session, y compris entre deux sessions d'un même compte poussant sous la
même identité GitHub (vérifié le 21/09/2026 : `0168bGSA` pour l'auteur d'AG-001,
`017sTFys` pour son contradicteur).

Une session compare donc l'identifiant du bloc au sien : **identiques, elle ne
répond pas.** Plus besoin que l'utilisateur fournisse un libellé au relais, et
`git log` permet de vérifier après coup qu'un bloc et sa réponse viennent bien
de deux sessions, quoi qu'en dise le texte. Si l'identifiant est introuvable,
demander à l'utilisateur plutôt que d'inventer.

**`lu sur <sha court>`** = le commit que la session avait sous les yeux. Une
réponse écrite sur un état du code différent de la proposition ne vaut pas
grand-chose, et c'est invisible autrement. `git log --oneline -1`.

Le champ **« non vérifié par l'auteur »** est le plus important du gabarit :
c'est lui qui transforme le duel en coopération. L'auteur y écrit honnêtement où
il est faible, ce qui oriente le contradicteur là où il est utile au lieu de le
laisser chercher au hasard ou valider par défaut.

## 7. Le fichier doit circuler, donc il vit sur `main`

Deux sessions sur deux branches de session différentes **ne se voient pas**.

Le commit AGORA se pousse donc **directement sur `main`, immédiatement**, pas en
fin de session. C'est une exception assumée au workflow de branche de
`git-workflow.md` : c'est du texte, ça ne peut casser aucun déploiement.

Écriture **append-only** : une session n'édite jamais le bloc d'une autre, elle
ajoute le sien. Ça évite les conflits de fusion. **`git pull --rebase origin
main` juste avant de pousser** : deux sessions qui poussent en même temps —
a fortiori depuis deux comptes — produisent sinon un rejet non-fast-forward. Si les collisions deviennent
fréquentes, passer à un dossier `agora/` avec un fichier par débat.

## 8. Entretien — sinon plus personne ne le lit

- **Un bloc tranché sort du fichier.** Sa conclusion remonte dans le
  `CHANTIERS.md` du projet (points à ne pas défaire), ou dans son `CLAUDE.md` si
  elle devient une règle. Le récit appartient à `git log`. Un AGORA qui
  accumule des débats clos devient le millefeuille que `hygiene-instructions.md`
  §4 cherche à éviter.
- **Péremption.** Un bloc resté sans réponse quand le sujet revient : soit
  l'utilisateur relance, soit Claude le ferme en « tranché sans contradiction le
  JJ/MM/AAAA », avec la décision retenue. Sans ça, le fichier se remplit de
  débats fantômes.
- **Désaccord non tranchable.** Si les deux sessions campent, la sortie n'est
  **pas** un troisième avis — ça tourne en rond et ça coûte. La question devient
  **quelle observation départagerait** (une mesure, un log, un essai court). Si
  aucune observation ne le peut, c'est un choix de goût : l'utilisateur tranche,
  la raison est notée, on n'y revient plus.
- **Fichier commité** : pas de log contenant des données d'usagers collé dans un
  bloc (cf. `rgpd-securite.md`).

## 9. Ce qu'on copie dans un projet consommateur

Deux choses seulement, sinon le `CLAUDE.md` du projet enfle et l'ensemble est
moins bien appliqué, pas mieux :

1. Un `AGORA.md` à la racine du projet, contenant le gabarit du §6 et rien
   d'autre au départ.
2. Dans le `CLAUDE.md` du projet : les **six critères du §2**, la liste du §3,
   la phrase « soumettre d'office, ne jamais bloquer, pousser sur `main` », et
   un renvoi vers `AGORA.md`. Une quinzaine de lignes, pas plus.

**Test d'auto-suffisance avant de clore la propagation :** une session qui
n'aurait que le projet sous les yeux — autre compte, MD-LIB non attaché —
doit pouvoir ouvrir un bloc et y répondre correctement avec ces deux fichiers
seuls. Si elle a besoin d'ouvrir `MD-LIB/agora.md` pour agir, la copie est
incomplète (cf. §10).

Le reste de ce fichier (le pourquoi, la calibration, le rôle du contradicteur)
reste ici : c'est ce qui justifie la règle, pas ce qui l'exécute.

## 10. Fonctionner entre deux comptes Claude différents

C'est le mode d'emploi normal, pas un cas limite : deux comptes n'ont ni
mémoire, ni préférences, ni sessions en commun. Le dispositif tient quand même
parce que **le canal est le dépôt Git, pas le compte Claude** — exactement
comme `CHANTIERS.md`.

**Ce qui le rend possible, et les conditions à remplir :**

- Le second compte doit avoir **accès en écriture au dépôt GitHub** (compte
  GitHub collaborateur du dépôt, application Claude autorisée dessus). C'est
  une condition GitHub, rien à configurer côté Claude.
- **`AGORA.md` et la section du `CLAUDE.md` doivent suffire à répondre sans
  MD-LIB.** Un second compte n'aura pas ce dépôt attaché. C'est la raison
  d'être du §9 : on copie les critères et le gabarit dans le projet, on ne
  renvoie pas vers une règle que l'autre ne peut pas ouvrir. Tout renvoi vers
  `MD-LIB/agora.md` porte la mention « non requis pour répondre ».
- **`git pull --rebase origin main` avant de pousser un bloc.** Deux comptes
  qui poussent sur `main` en même temps produisent un rejet non-fast-forward.
  L'écriture étant append-only en fin de fichier, le rebase passe sans
  conflit.

**Ce qui n'est pas possible, et ne le sera pas :** aucune notification d'un
compte vers l'autre. Les sessions, les routines planifiées et les messages
inter-sessions sont cloisonnés par compte. **Le relais reste humain** — c'est
une limite dure du support, pas un raffinement à ajouter plus tard. Elle est
sans gravité ici : le dispositif a été conçu asynchrone et non bloquant dès
le §4.

**Deux sessions se distinguent par le trailer `Claude-Session:` de leurs
commits, même sous une identité GitHub unique.** Corrigé le 21/09/2026 : la
version précédente affirmait que `git log` ne distingue rien dans ce cas et
que le champ `Auteur` était la seule distinction disponible. Faux, mesuré sur
GDINV2 (bloc `a1f0ac3` et sa réponse `2351a0f`, trailers différents sous le
même compte GitHub) — c'est la session contradictrice d'AG-001 qui l'a relevé.

**Avant de répondre à un bloc, comparer `git log -1 --format=%B <sha du bloc>`
au trailer de la session courante.** C'est la vérification qui fait foi. Le
champ `Auteur` n'est qu'un libellé de lecture : attribué à l'oral au moment du
relais, il ne survit pas à un compactage de contexte et n'est contraint par
rien. Il reste utile à la lecture humaine du fichier, et le libellé doit
toujours figurer dans la phrase de relais (§4).

**Réserve** : ce trailer vient d'une consigne de session, pas de git. Un commit
fait à la main, ou une session sans cette consigne, n'en portera pas — dans ce
cas, demander à l'utilisateur avant de répondre.

## 11. La règle sert-elle à quelque chose ? — compteur

Tenir à jour cette seule ligne, à chaque bloc tranché. Si les « confirmé sans
rien changer » dominent, le dispositif produit du tampon et se supprime.

> **Au 21/09/2026 : 1 bloc — 0 confirmé, 1 amendé, 0 contredit.** A corrigé un
> protocole de mesure avant qu'il ne consomme du quota ; le contradicteur a
> infirmé deux points de l'auteur sur pièces.

Un compteur, pas un journal : le récit est dans `git log`.

## 12. Le point faible connu du dispositif

**C'est Claude qui oublie.** Aucun mécanisme ne le réveille, aucun test n'
échoue si un critère rempli reste silencieux. La seule vérification réelle est
que l'utilisateur le reprenne quand le diff montre un critère rempli sans
signalement — d'où l'exigence du §2 que les critères soient constatables dans le
diff, et celle du §9 qu'ils tiennent en quinze lignes dans le fichier lu au
démarrage.
