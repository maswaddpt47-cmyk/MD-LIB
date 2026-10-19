# CHANTIERS — passation de session

État au **19/10/2026**, mesuré via GitHub. À la demande de l’utilisateur, ce
fichier centralise la reprise du chantier WoocLight. Les règles restent dans
les fichiers de MD-LIB et l’état détaillé dans le CHANTIERS du projet.

## PAPPERBOARD — reprise par Claude si la session Codex s’interrompt

**Codex poursuit actuellement le chantier.** Avant de reprendre, actualiser les
deux dépôts et leurs CHANTIERS pour éviter des modifications concurrentes.

### Objectif et autorisation

- Feu vert explicite de l’utilisateur le 19/10/2026 pour intégrer et publier
  l’interface de la simulation dans le site PHP de production. Le gel précédent
  est levé pour ce chantier ; ne pas redemander cette permission.
- Reproduire les composants et dimensions de la simulation, conserver toutes
  les fonctions PHP réelles. Une recoloration seule ne suffit pas.
- Prévenir immédiatement en cas de blocage et donner un point utile au plus
  toutes les 60 secondes. Aucune annonce de mise en ligne sans preuve.

### Références sauvegardées

| Élément | Référence mesurée le 19/10/2026 |
|---|---|
| Production | `maswaddpt47-cmyk/PAPPERBOARD` |
| Main de production à cet état | `98c91a61dac3782536ee2e804b543e5bd3135484` ; intégration encore en branche |
| Branche d’intégration | `codex/interface-simulation-fidele` |
| Dernier commit poussé | `0507a20703af32fd2babe2258d78b5814cc8e366` ; toujours vérifier la tête réelle avant reprise |
| Vérification de ce commit | [Actions 39258220745](https://github.com/maswaddpt47-cmyk/PAPPERBOARD/actions/runs/39258220745), en attente au relevé ; résultat à actualiser |
| Prototype publié | `maswaddpt47-cmyk/PAPPERBOARD-CHATGPT`, main `0db8291e300e721cc8d588e4a2670ce1c5019795` ; Pages et contrôles verts |
| Référence visuelle figée | `PAPPERBOARD-CHATGPT@7a80fc3a81083f3cb8adf4dfc5e79e686e9fb5bb` ; fichier autonome et empreintes copiés dans `PAPPERBOARD/tests/reference/` |
| Guide complet | `PAPPERBOARD-CHATGPT/docs/CONSIGNE-CLAUDE-UI-PHP.md` ; `PAPPERBOARD/docs/interface-reference.md` |

URLs : [site PHP](https://wooclight.alwaysdata.net/admin.php) ;
[simulation](https://maswaddpt47-cmyk.github.io/PAPPERBOARD-CHATGPT/simulation.html?v=0db8291).
La première URL sert encore l’ancienne main à cet état. Le paramètre `v` force
le rafraîchissement, il ne constitue pas un gel historique.

### Travail présent dans la branche, mesuré dans le code

- `assets/interface.css` reprend les trois feuilles de composants du prototype,
  avec portée `body.admin`. Couleurs de repli centralisées dans `assets/style.css`.
  `assets/interface-php.css` relie la coque, les cartes et les formulaires PHP.
- `admin.php`, `assets/admin.js`, `assets/shell.js`, `assets/interface.js` :
  Terminer/Rouvrir dans Pilotage ; Renommer dans Mes ateliers par formulaire ;
  cartes de signaux et de questions réelles dans Animer ; fenêtres structurées
  avec en-tête, contenu et pied. Toutes les opérations utilisent les API existantes.
- `assets/tooltips.js`, `assets/aides.css` : info-bulles accessibles au survol et
  au focus dans l’animation, les dialogues, la projection et le participant.
- `screen.php`, `assets/interface-screen.css`, `assets/screen.js` : commandes
  en haut et canevas mesuré à sa taille naturelle puis ajusté au viewport ; QR
  agrandi conservé. Pas de suppression de contenu pour masquer un débordement.
- `tests/interface.js` : comparaison des styles avec la référence à 1920×1080,
  1280×720, 1024×768 et 390×844 ; contrôle des projections et actions réelles.
- CI : vrais parcours Chrome activés, captures PHP/référence dans l’artefact
  `comparaison-interface`. Après déploiement, comparaison octet par octet de
  sept ressources servies avec les fichiers du commit.

### Vérifications acquises et limites

- **Mesuré sur `e152e44`** : PHP/JS valides ; 432 e2e, 6 charge, 10 configuration,
  4 archivage, 5 protection, 15 charte, 103 parcours navigateur, 79 UI et 768
  cas de galerie réussis. Ce vert ancien ne suffit pas pour fusionner une tête ultérieure.
- **Prototype `7a80fc3`** : 769 contrôles Chrome réussis, suite PHP verte.
- Les derniers compléments de tests sont encore à confirmer sur `0507a207`.
  Les anciens échecs de ciblage de boutons, d’en-tête CSRF du test et de
  sélecteurs de la référence (bouton dans la notice volontairement masquée) sont corrigés dans la tête ; ne pas relancer
  les anciennes versions pour décider du déploiement.
- La comparaison de styles et les captures ne prouvent pas automatiquement une
  égalité de chaque pixel de tous les écrans.
- Environnement Codex actuel : PHP absent et Chromium local interdit.
  Les tests réels s’exécutent dans GitHub Actions. Réseau shell bloqué ; utiliser
  le connecteur GitHub fonctionnel, sans relancer les demandes réseau qui bloquent.
- Le travail est poussé par l’API GitHub sur l’historique distant. Ne pas pousser
  le commit local de reconstruction `e7815b0` comme s’il appartenait à cet historique.

### Suite à exécuter, dans cet ordre

1. Actualiser PAPPERBOARD, lire AGENTS.md, CLAUDE.md, CHANTIERS.md et AGORA.md.
   Vérifier la tête de `codex/interface-simulation-fidele` et son dernier workflow.
2. Attendre les tests du commit courant. Corriger les échecs réels, examiner
   l’artefact `comparaison-interface` aux mêmes tailles, puis mettre à jour
   les mesures dans le CHANTIERS du projet et ce fichier. Si une nouvelle
   modification est commise, exiger le vert sur ce nouveau SHA.
3. Quand les vérifications du dernier SHA sont vertes, avancer main en avance
   rapide avec comparaison du SHA attendu ; ne jamais forcer ni écraser une
   éventuelle avancée concurrente. Le déploiement Alwaysdata part automatiquement.
4. Vérifier le workflow de main : l’étape « Copier l’application » ET l’étape
   « Vérifier la mise en ligne » doivent réellement réussir, pas être ignorées.
   Vérifier les ressources servies et appliquer `outils/attendre-deploiement.sh`
   de MD-LIB. Un état global vert avec deploy ignoré ne prouve pas la mise en ligne.
5. Donner l’URL testable et où cliquer. Actualiser la passation avec le SHA
   réellement déployé et les limites restantes ; retirer les tâches achevées.

### Points à ne pas défaire

- API, authentification, CSRF, CSP, anonymat, modération, purge horaire réelle,
  démonstrations, relecture JSON par une autre IA, exports et coût du polling.
- Aucune lecture/écriture de config.php, aucun secret ni donnée réelle dans les tests.
- AG-007 : `#8A6500` refusé par l’utilisateur, garder la moutarde de production
  `#B18400`. Le prototype n’autorise pas à annuler cet arbitrage silencieusement.
- Projection dans un nouvel onglet. L’aperçu participant ouvre la vraie page PHP
  dans une fenêtre séparée, synchronisée par le serveur ; CSP inchangée.
- Distinguer prototype statique, branche testée et production effectivement publiée.
