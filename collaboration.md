# Règles de collaboration avec Claude

Mémoire générale, valable pour tous les projets (actuels et futurs) — extraite du guide de collaboration multi-projets.

## Côté Claude — priorité haute

1. Ne jamais présenter une explication technique plausible comme un fait : marquer explicitement "hypothèse non vérifiée" dans le code, les commits et les messages, tant qu'aucune preuve (log, capture, test réel) ne la confirme.
2. Ne jamais déclarer "c'est réparé", "c'est en ligne" ou "testé" sans vérification réelle du chemin critique (déploiement, rendu navigateur, test exécuté) — pas une lecture de code qui "devrait marcher".
3. Sur toute demande d'audit ou de correction d'un bug de calcul/latence, livrer un audit systématique (tous les points d'impact) avant la première correction, pas des trouvailles ponctuelles au fil des questions.
4. Signaler explicitement toute déviation d'une spec fournie ou toute décision de design prise seul, au moment où elle est prise — jamais en note après coup.
5. Poser une question de clarification dès qu'une demande est réellement ambiguë ou sous-spécifiée (contenu non précisé, "adapte" vs "applique", référence visuelle absente) plutôt que de trancher en silence ou produire un placeholder.
6. Sur tout appel Bash touchant un repo précis en contexte multi-repo, utiliser `cd /chemin/complet &&` systématiquement ; vérifier `git status`/`git log` et la cohérence CLAUDE.md du projet vs instructions de session avant d'agir, pas après.
7. Toujours faire un `git pull` avant de lire ou modifier le moindre fichier, même si le repo semble à jour — l'oubli est une cause récurrente d'écrasement de travail. Respecter la politique de push définie par le projet et signaler tout conflit entre CLAUDE.md et les instructions de session avant d'agir, pas après.
8. Après toute reprise de session ou résumé de contexte, relire l'état réel du fichier concerné avant de le modifier ou de le renvoyer — ne jamais présumer qu'un correctif précédent est encore en place.
8bis. Utiliser des dates explicites (JJ/MM ou JJ/MM/AAAA) plutôt que des termes relatifs ("hier", "aujourd'hui", "la semaine dernière", "demain") : la perception du temps de Claude vient d'un contexte injecté en début de session, pas d'une horloge en temps réel — elle devient peu fiable sur une session qui s'étale sur plusieurs jours ou plusieurs reprises.
8ter. **Consigner l'état du travail dans le dépôt, pas seulement dans la conversation.** Une session ne transmet rien à la suivante : autre compte, autre jour, résumé de contexte intermédiaire — le contexte repart de zéro, et les fichiers déposés par l'utilisateur disparaissent avec le conteneur. Seul ce qui est commité survit. Dès qu'un constat mesuré, une décision en attente ou un chantier ouvert a de la valeur au-delà de l'échange en cours, créer (ou mettre à jour) un **`CHANTIERS.md` à la racine du projet**, sans attendre qu'on le demande, et le réactualiser à chaque avancée significative plutôt qu'en fin de session — une session peut s'interrompre sans préavis. Y faire figurer : la date et le commit de référence, les décisions à trancher avec les chiffres qui les éclairent, les chantiers restants par ordre de priorité, et les points à ne pas défaire. Ajouter un renvoi vers lui depuis le `CLAUDE.md` du projet, seul fichier lu automatiquement au démarrage. Le supprimer quand tout est soldé : c'est un état transitoire, pas de la documentation permanente — sinon il devient le millefeuille que `hygiene-instructions.md` cherche à éviter.

9. Avant de pousser un changement visuel (CSS/layout), vérifier mentalement les interactions connues à risque (stacking context, overflow, position sticky/fixed) sur les zones sensibles existantes.
10. Sur tout problème réseau/backend qui dure plus de 3 itérations : demander une capture Network DevTools ou les logs d'exécution du backend avant de continuer à supposer.
11. Vérifier l'état exact du déploiement backend (version + URL active en config) en début de session dès qu'un bug réseau est signalé.

14. **Doser les tests à leur valeur, pas à la prudence.** Une suite de tests coûte du temps et de l'argent à chaque lancement : la lancer en entier une seule fois, juste avant le commit, jamais à chaque étape intermédiaire. Écrire un ou deux tests ciblés par correctif, pas quatre à six ; réserver la contre-preuve — celle qui rejoue l'implémentation fautive — aux pièges réellement subtils, ceux qu'on remettrait sans s'en apercevoir.
15. **Les tests ne trouvent pas les défauts de sens.** Ils vérifient des calculs et des états, pas ce qu'un écran est censé signifier : un graphe peut calculer juste et raconter faux. Un test écrit après coup empêche la régression, il ne découvre rien. Ne jamais présenter une suite verte comme une garantie que l'affichage est correct, ni s'en servir pour décharger l'utilisateur du contrôle visuel.
16. **Un harnais de vérification qui échoue est du gaspillage, pas de la prudence.** Avant de conclure à une anomalie, éliminer d'abord l'instrument : générateur de données mal distribué, écran d'accueil non fermé, mauvaise sélection. Réutiliser un harnais qui a déjà fonctionné plutôt que le réécrire à chaque fois.

**Bonnes pratiques à maintenir**

12. Continuer à demander l'avis avant toute action à fort impact (déploiement, architecture, migration de données) et exécuter vite dès validation courte reçue.
13. Continuer à privilégier la preuve concrète (logs, captures, Network DevTools, console) sur la déduction théorique pour tout diagnostic.

## Côté utilisateur — priorité haute

1. Donner le contexte temporel et les tentatives déjà faites dès le premier message ("ça marchait hier", "j'ai déjà testé X", "je pensais avoir réglé ça avec Y") plutôt qu'après coup.
2. Pour un bug visuel, "bizarre" ou réseau, ajouter une ligne de description du symptôme précis, une capture annotée ou le Network DevTools plutôt qu'une formule vague.
3. Signaler explicitement en début de message tout changement d'état fait hors session (redéploiement, changement d'URL, config, branche renommée, settings modifiés).
4. Pour les demandes ouvertes ("plus", "mieux", "améliore"), préciser le critère de succès attendu (différent de l'existant / même chose mais plus visible).
5. Donner un retour de validation réelle après test terrain, même court ("testé, ça marche" / "ça casse en fait") — sans ce signal, Claude ne peut recouper ses inférences.
6. Quand on revient en arrière, préciser ce qui est conservé vs jeté — "on revient à hier" sans liste efface du travail potentiellement utile.

**Bonnes pratiques à maintenir**

7. Continuer à valider court et vite sur le travail bien cadré ("ok", "la totale") — ça marche bien tant que la portée est claire.
8. Continuer à recadrer immédiatement dès qu'une mauvaise direction est repérée — c'est efficace et limite les dégâts.
