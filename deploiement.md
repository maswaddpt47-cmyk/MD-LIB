# Vérifier le déploiement avant d'annoncer « en ligne »

Règle établie le 13/10/2026 après deux déploiements de NextStep en échec,
annoncés à tort comme disponibles. Le contrôle porte sur le commit publié et
sur les étapes qui le mettent réellement en ligne.

## La règle

Avant d'écrire « c'est en ligne », « c'est déployé » ou « à recharger », obtenir
la preuve que le déploiement attendu du **commit poussé** a réussi. Un test local
ou un push réussi ne constitue pas cette preuve.

Pour GitHub Actions, utiliser `outils/attendre-deploiement.sh` ; si l'environnement
ne permet pas son exécution ou son accès à l'API, vérifier les mêmes éléments
avec le connecteur GitHub disponible : SHA, workflows attendus, étapes de
publication et résultats. Nommer le moyen utilisé et les limites éventuelles.

- **✅ Succès vérifié pour le SHA nommé** : l'annonce est possible.
- **❌ Échec** : signaler l'étape en échec ; corriger une cause établie, sans
  inventer un défaut du dépôt ni une panne de la plateforme.
- **⏳ En cours** : le dire et surveiller la suite en arrière-plan.
- **➖ Publication non vérifiée** : rechercher la preuve de publication avant
  toute annonce.

**Échec sans étape exécutée** : regarder l'état de l'exécution, la définition du
workflow et les journaux disponibles. Des tests locaux verts ne prouvent pas
que le dépôt est hors de cause. Ne pas pousser de commit vide pour débloquer.
Relancer **une fois** la même exécution si une relance est pertinente, puis
vérifier https://www.githubstatus.com (Actions, Pages). Si cette page est
inaccessible depuis la session, demander à l'utilisateur de la consulter.
Incident confirmé : programmer une relance avec l'outil disponible après le
délai annoncé, sans boucle, et consigner l'état réel dans `CHANTIERS.md`.

**« Aucun workflow vu » ne prouve pas l'absence de déploiement** : lire les
exécutions passées et la configuration d'hébergement. Si Pages est attendu mais
aucune construction n'est partie pour le commit, la publication reste non
vérifiée ; comparer le commit réellement servi avant de conclure sur sa version.
Ne rien pousser pour débloquer. Quand le réglage Pages est en cause, la relance
par Settings → Pages, Branch « None » puis branche publiée / root, se fait selon
la configuration du projet ; vérifier ensuite la publication du SHA attendu.

**Pages refusé « in progress » malgré une demande annulée** : comparer le SHA
de l'erreur et l'état de cette demande dans l'API Pages. Ne pas ajouter de
workflow de récupération ni enchaîner les relances. Pour le cas déjà constaté
où l'API indique `deployment_cancelled`, attendre environ vingt minutes, puis
relancer **une fois** le workflow existant sur la branche publiée. Ce délai
vient d'un incident ; il ne garantit pas le temps de résolution du suivant.

## Comment il se déclenche

- **Claude Code, hook effectivement installé** : le Setup script
  `outils/script-demarrage.sh` installe un hook `PostToolUse` sur Bash. Après une
  commande contenant `git push`, il recherche les dépôts voisins dont `main`,
  `master`, `sandbox` ou `gh-pages` vient d'être poussé et vérifie la publication
  automatique GitHub Pages. Vérifier l'installation et les chemins dans cet
  environnement. Le mécanisme dépend de la configuration de la session cloud.
- **Codex, session locale ou absence de rapport du hook** : lancer explicitement
  le script depuis la copie de MD-LIB présente dans la session, ou utiliser le
  contrôle GitHub décrit ci-dessus si le script n'est pas utilisable.

Exemple depuis la racine de MD-LIB, avec le chemin réel du dépôt et son SHA :

```bash
bash outils/attendre-deploiement.sh /chemin/du-depot SHA_COMMIT
```

Sans workflow précisé, le script cherche d'abord dans `.github/workflows/` du
dépôt l'unique étape `uses: actions/deploy-pages` et vérifie ce workflow, sa
tâche et cette étape (hook compris ; 24/11/2026, SpeedDial). Sinon, pour GitHub
Pages automatique, il vérifie la dernière exécution du workflow
`dynamic/pages/pages-build-deployment` pour le SHA et la réussite de sa tâche
`deploy`, étape `Deploy to GitHub Pages`. Si plusieurs workflows publient, ou
si la détection ne convient pas, donner son chemin, le nom exact de la tâche et
celui de l'étape de publication.
L'exemple suivant suppose que ces trois noms correspondent à la configuration.

```bash
bash outils/attendre-deploiement.sh /chemin/du-depot SHA_COMMIT \
  .github/workflows/publier.yml 'Déploiement production' 'Publier en production'
```

Si le même workflow, la même tâche et la même étape servent plusieurs branches,
indiquer à la place du SHA le nom de la branche publiée. Le script lit son SHA
distant et filtre les exécutions de cette branche. Un déploiement manuel,
planifié ou déclenché par une pull request se vérifie directement sur GitHub.
Procéder de même si le workflow ou l'étape de publication attendus ne peuvent
être identifiés par le script.

Le script lit GitHub Actions avec `$GITHUB_TOKEN` s'il est disponible. Il attend
jusqu'à 90 s l'apparition du workflow attendu et 8 minutes par défaut une
exécution en cours. Les attentes longues se surveillent en arrière-plan
(`collaboration.md`, règle 52).

| Code | Résultat |
|---|---|
| 0 | ✅ Workflow, tâche et étape attendus réussis pour le SHA indiqué |
| 1 | ❌ Échec du workflow, de la tâche ou de l'étape attendus |
| 2 | ⏳ Exécution attendue toujours en cours à l'expiration du délai |
| 3 | ➖ Publication non vérifiée. Preuve absente, étape ignorée ou API indisponible, par exemple. |

## Dans les projets

Ne pas recopier cette procédure. Le projet indique sa branche publiée, son
hébergeur et ses étapes de publication, puis renvoie ici. Le hook dépend de
l'environnement Claude Code ; Codex ne le suppose jamais installé. Le contrôle
réel du commit reste nécessaire quel que soit l'outil.
