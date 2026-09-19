# PWA & service worker — garde-fous

Mémoire générale, valable pour tous les projets (actuels et futurs). Rendre un
site installable en PWA est peu coûteux, mais un service worker est le seul
morceau de code qui **survit au déploiement suivant** : il reste installé sur
l'appareil et s'interpose entre l'utilisateur et le serveur. Les règles
ci-dessous existent pour que ce pouvoir ne se retourne pas contre le projet.

Établies le 19/09/2026 sur ATELIERS_NEWGEN et ateliers-cd47_NextStep, après
deux incidents de cache en production (16/09/2026).

## 1. Ne rien mettre en cache dans un projet qui a un cache-busting `?v=N`

**La règle la plus importante.** Si les pages chargent leurs scripts avec un
paramètre de version (`shared.js?v=12`), le versioning est déjà géré à la
main, et un service worker en *cache-first* recrée exactement l'incident que
ce paramètre sert à éviter — en pire, parce que le cache du service worker ne
se vide pas avec les données de navigation habituelles.

Un service worker dont le seul but est l'installabilité n'a besoin d'aucun
cache : il lui suffit d'exister et d'avoir un handler `fetch` enregistré.

```js
self.addEventListener('fetch', (event) => {
  // Ne rien faire : laisser le navigateur traiter la requête normalement.
});
```

## 2. Jamais de `respondWith()` — ça casse les tests de bout en bout

Un `event.respondWith(fetch(...))` ré-émet la requête **depuis le contexte du
service worker**, hors de portée des mocks réseau des tests navigateur
(`page.route()` de Playwright, par exemple).

Constaté le 19/09/2026 : avec `respondWith`, les 22 tests du smoke test
échouaient tous à la connexion (la réponse mockée n'arrivait jamais) ; sans,
tous passaient. Le symptôme ne ressemble pas à sa cause — on croit à une
régression de l'application alors que c'est le service worker qui détourne le
trafic.

Ne pas ajouter `respondWith()` sans revalider **toutes** les suites de tests
navigateur du projet.

## 3. Enregistrer sur `load`, en fin de `<body>`

```html
<script>
if ('serviceWorker' in navigator) {
  window.addEventListener('load', function () {
    navigator.serviceWorker.register('sw.js').catch(function () {});
  });
}
</script>
```

L'enregistrement ne doit jamais précéder le chargement de l'application. Le
`catch` vide est volontaire : un enregistrement qui échoue (navigation privée,
politique d'entreprise) ne doit pas remonter d'erreur à l'utilisateur ni
apparaître dans les tests.

## 4. Coût résiduel à connaître, et à ne pas surestimer

Même vide, un handler `fetch` oblige le navigateur à réveiller le worker
endormi avant de traiter les requêtes : quelques dizaines de millisecondes,
un peu plus sur mobile d'entrée de gamme.

C'est réel mais négligeable dès que le projet parle à un backend qui répond en
secondes. Ne pas invoquer ce coût pour refuser une PWA, ni l'oublier en
comparant deux mesures de chargement.

## 5. ⚠️ En PWA installée, l'utilisateur ne peut plus forcer un rechargement

Le point le plus sous-estimé. En mode installé (`display: standalone`), il n'y
a plus de barre d'adresse, donc **plus de Ctrl+F5 ni de bouton recharger**.

Or le `?v=N` protège les scripts et les feuilles de style, **pas la page HTML
elle-même**. Si le HTML reste en cache navigateur, il continue de référencer
les anciennes versions, et l'utilisateur en mode PWA n'a aucun moyen simple
d'en sortir.

- Vérifier les en-têtes de cache servis sur le HTML (`Cache-Control`) par
  l'hébergeur. Sur GitHub Pages, un `max-age` de quelques minutes fait que le
  problème se résorbe seul — mais c'est à confirmer, pas à supposer.
- Sortie de secours à connaître et à transmettre aux utilisateurs :
  désinstaller/réinstaller l'application, ou vider les données du site.
- Après un déploiement important, s'assurer qu'au moins une personne en mode
  PWA reçoit bien le correctif sans manipulation.

## 6. Le service worker survit — toute modification future repasse par ici

Une fois installé sur un appareil, il y reste. Le jour où quelqu'un ajoutera
du cache « juste pour accélérer un peu », l'incident reviendra sur des postes
que plus personne ne surveille.

Écrire ces raisons **en commentaire dans `sw.js` lui-même**, pas seulement
dans la documentation : c'est le fichier qu'on ouvrira pour le modifier.

## 7. Avant de conclure qu'une PWA est sans effet

Relancer les suites de tests navigateur **avec le service worker actif sur les
vraies pages** (pas seulement sur une page de test nue, qui ne l'enregistre
pas). C'est le seul moyen de vérifier que les mocks réseau et les parcours
d'authentification passent toujours.
