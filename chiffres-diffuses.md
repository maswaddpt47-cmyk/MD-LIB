# Chiffres diffusés — ne jamais laisser passer une fausse information

Posé par l'utilisateur le 20/10/2026, après l'audit Codex de GDINV2 : 251 tests
verts, et pourtant 14 défauts de calcul sur le fichier réel (une fusion qui
supprimait 76 demandes, un réimport qui ajoutait 41 % de lignes, un « taux de
complétion » à 100 % qui mesurait la présence d'une date). Des élus et la
hiérarchie lisent ces chiffres : une suite verte ne suffit pas.

**S'applique à tout projet dont un écran, un export ou une diapositive projette
des calculs ou des statistiques** vers d'autres personnes que l'utilisateur
(GDINV2, ATELIERS_NEWGEN, NextStep, WoocLight…). Un projet sans chiffre diffusé
n'en a pas besoin — ne pas copier par principe (`hygiene-instructions.md`).

## 1. Codex audite avant toute diffusion

Avant qu'un chiffre parte vers les élus ou la hiérarchie :

- **Audit Codex sur l'export réel**, en lecture seule, avec le modèle
  `consigne-audit-externe.md` adapté aux calculs : il rejoue le parcours réel
  (import, fusion, enrichissement, sauvegarde, rechargement, réimport) et
  recompte chaque indicateur par un chemin indépendant. L'IA qui écrit ne relit
  pas (`agora.md` §12) : Claude ne s'auto-certifie pas.
- **Quand** : première diffusion d'un projet ; tout changement qui touche
  l'import, la fusion, un calcul, un filtre ou une définition d'indicateur ;
  chaque trimestre.
- Le fichier réel et le rapport restent **hors du dépôt public**. Chaque point
  est vérifié dans le code avant d'être retenu ; un point « haute » non traité
  se dit à l'utilisateur avant la diffusion, jamais après.

## 2. Cinq familles de tests, toutes écrites avant de se dire « testé »

| Famille | Ce qu'elle interdit | Forme minimale |
|---|---|---|
| **A. Parcours complet idempotent** | un réimport qui change le nombre de lignes | import → fusion → enrichissement → sérialisation → rechargement → réimport : 0 ligne ajoutée, à deux ou trois reprises |
| **B. Même population, même chiffre** | deux écrans qui comptent autrement | pour une sélection donnée, chaque KPI affiché par plusieurs vues (écran, rapport, diapositive, PDF) a la même valeur |
| **C. Recomptage indépendant** | un chiffre jamais recompté | chaque chiffre diffusé est recalculé par un second chemin (commande ou script qui part de la source) ; un écart bloque |
| **D. Provenance** | une valeur déduite qui devient « constatée » | après retraitement, rechargement ou réimport, l'origine (source / déduit / inconnu) ne change pas |
| **E. Unité et dénominateur** | un libellé qui ment sur ce qu'il compte | chaque ratio nomme son numérateur, son dénominateur et son unité (lignes ≠ demandes ≠ personnes) ; un « top N » ne tronque jamais un total ni une part |

Une définition d'indicateur qui n'a pas de test portant sur **sa population**
(qui est compté, sur quelle période, avec quel état) n'est pas testée, même si
la fonction qui la calcule l'est.

## 3. Le tableau qui précède la diffusion

Livré à l'utilisateur avec la version, hors dépôt public :

| Chiffre | Affiché | Recompté (méthode) | Écart | Explication |
|---|---|---|---|---|

Tout écart non nul porte son explication ; une explication qui n'existe pas
est un défaut, pas un arrondi.

## 4. Ce que cette règle ne remplace pas

- Le contrôle visuel de l'utilisateur (`collaboration.md` règles 15 et 17).
- L'AGORA pour les décisions de structure (identité des lignes, format de
  stockage, migration) : elles restent soumises avant d'être mises en œuvre.
- Les définitions métier (« 48 h », « réalisé », « bénéficiaire ») : elles se
  font trancher par l'utilisateur, jamais par Claude (règle 4).
