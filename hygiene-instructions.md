# Hygiène des instructions — empêcher le millefeuille

Mémoire générale, valable pour tous les projets. Établie le 19/09/2026 après
constat sur ATELIERS_NEWGEN et ateliers-cd47_NextStep.

## Le constat qui motive ce fichier

Au 19/09/2026, avant nettoyage : 298 lignes d'instructions dans le `CLAUDE.md`
de NEWGEN, 234 dans celui de NextStep, 35 entrées de version dans le seul
en-tête de `gas/GAS_NEWGEN.js`.

Pendant des semaines, un site mettait jusqu'à 84 s à se connecter **alors que
les 240 tests unitaires et la suite e2e passaient tous**. Quatre mécanismes,
tous vérifiables dans les fichiers :

1. **On testait la justesse, jamais le coût.** Un site à 84 s passe une suite
   qui vérifie que les fonctions calculent juste et que les pages s'ouvrent.
2. **Un diagnostic faux avait été écrit comme un fait** et jamais réexaminé :
   « GAS met 12-16 s à s'exécuter » a orienté deux mois de décisions vers
   « laisser plus de temps », alors que les journaux affichaient 1,1 s.
3. **Chaque incident ajoutait une couche, aucune n'était retirée** : la même
   boucle de reprise recopiée trois fois avec des plafonds divergents, une
   fonction définie deux fois, `keepAlive` supprimé puis remis.
4. **Deux projets jumeaux sans arbitre** : chacun a adopté des correctifs de
   l'autre jusqu'à tourner sur des stratégies opposées en production.

## 1. Une contrainte formulable en test devient un test, pas un paragraphe

La règle la plus efficace, et elle est démontrée : le paragraphe « ne
rallongez pas les plafonds » n'a empêché personne de les porter à 35 s.
**Le test qui vérifie les plafonds, lui, fait échouer la CI.**

Un test est une instruction qui s'exécute ; un `.md` est une instruction qui
espère être lue. Quand les deux sont possibles, écrire le test.

Ce qui reste dans le `.md` : le **pourquoi** (une hypothèse ne s'exécute pas)
et le nom du test qui tient le **quoi**. Pas les deux en entier.

## 2. Tester le coût, pas seulement la justesse

Sur tout projet qui parle à un backend, prévoir au moins un test qui compte
ce que l'application dépense, et pas seulement ce qu'elle calcule :

- nombre d'appels réseau émis sur un parcours courant (ouverture, écriture) ;
- comportement en cas de réponse perdue (plafonds, reprises).

C'est le seul type de test qui aurait vu le problème. Il échoue quand
quelqu'un réintroduit un appel supprimé — ce qu'aucune relecture ne garantit.

## 3. Dater et qualifier toute affirmation technique

Chaque affirmation technique dans un `.md` ou un commentaire porte :

- **une date** (JJ/MM/AAAA) ;
- **son statut** : mesuré (avec la mesure) ou supposé.

Une hypothèse écrite sans ces deux éléments devient un fait par simple
répétition, et oriente les décisions de tous ceux qui la lisent ensuite.

**Corollaire, le plus important :** une mesure qui contredit une note
existante oblige à corriger la note, pas seulement à contourner. Marquer
« hypothèse non vérifiée » au moment où on écrit ne suffit pas — il faut
rouvrir les anciennes quand les faits changent.

## 4. Budget fermé : ajouter une règle oblige à en relire une

Un fichier d'instructions qui grossit est moins bien appliqué, pas mieux.
Avant d'ajouter une section à un `CLAUDE.md` :

- vérifier qu'elle ne répète pas une section existante (le pull avant
  intervention était écrit trois fois dans le même fichier) ;
- supprimer ou fusionner ce qu'elle remplace ;
- préférer une ligne qui pointe vers un test à un paragraphe qui explique.

## 5. Le code porte les décisions, pas leur histoire

Interdire le commentaire-changelog dans les fichiers source : listes de
versions, « essayé puis retiré », « v11.9 : suppression / v11.10 : retour ».
Ça appartient à `git log` et aux messages de commit, qui sont faits pour ça.

Ce qui reste légitime en commentaire : **la décision en vigueur et la raison
qui la rend non négociable** — surtout quand elle est contre-intuitive
(« ne pas rallonger ce plafond : la réponse est perdue, pas en retard »).

Un fichier source truffé d'historique prend l'apparence d'une doctrine alors
que c'est un journal, et on n'ose plus y toucher.

## 6. Deux projets jumeaux : trancher, pas converger au hasard

Quand deux projets partagent une base de code et s'échangent des correctifs,
inscrire noir sur blanc quelle est la référence sur chaque sujet contesté.
Sinon chacun adopte des morceaux de l'autre jusqu'à des architectures
contradictoires déployées en production — et plus personne ne sait laquelle
est censée gagner.
