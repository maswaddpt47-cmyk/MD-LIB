# PWA & service worker — garde-fous

Fiche à consulter pour un projet qui utilise un service worker. Les choix
ci-dessous viennent d'ATELIERS_NEWGEN et ateliers-cd47_NextStep (19/09/2026),
après des incidents de cache. Les appliquer quand le projet présente le même
contexte ; une adaptation motivée se consigne dans son `CLAUDE.md` selon
`collaboration.md`. Un worker installé peut rester actif après un déploiement.

## 1. Ne rien mettre en cache dans un projet qui a un cache-busting `?v=N`

Quand le projet gère déjà la version de ses scripts (`shared.js?v=12`), ne pas
ajouter de cache au service worker : une stratégie *cache-first* mal alignée
peut maintenir une ancienne version malgré le déploiement.

Pour un worker dont le seul but est l'installabilité, garder le handler neutre
ci-dessous et vérifier le résultat sur les navigateurs visés. Il n'introduit ni
cache ni interception de la réponse :

```js
self.addEventListener('fetch', (event) => {
  // Ne rien faire : laisser le navigateur traiter la requête normalement.
});
```

## 2. N'ajouter `respondWith()` qu'après revalidation des tests navigateur

Un `event.respondWith(fetch(...))` ré-émet la requête depuis le worker : elle
peut échapper aux mocks du harnais, notamment `page.route()` de Playwright.
Constat du 19/09/2026 sur les projets d'origine : les 22 tests du smoke test
échouaient à la connexion avec cette interception, puis passaient sans elle.

Garder le handler neutre par défaut. Un ajout de `respondWith()` exige la
revalidation de **toutes** les suites navigateur du projet, avec le worker
réellement actif (§7), et le respect de la politique de cache du §1. L'interdit
porte sur un ajout non vérifié, pas sur toute utilisation de cette API.

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

L'enregistrement ne précède pas le chargement de l'application. Le `catch` vide
est volontaire : un échec (navigation privée, politique d'entreprise) ne doit
pas interrompre l'application. Son silence ne prouve pas que le worker est actif.

## 4. Coût résiduel à connaître, et à ne pas surestimer

Le réveil du worker peut ajouter de la latence aux requêtes, même avec un
handler neutre. L'ordre de grandeur ancien de « quelques dizaines de
millisecondes » est une estimation non mesurée ici, pas une mesure du projet.
Mesurer ce coût dans le contexte concerné avant de l'utiliser pour comparer
des chargements ou refuser une PWA.

## 5. En PWA installée, prévoir l'absence de rechargement forcé accessible

En mode installé (`display: standalone`), la barre d'adresse et le bouton de
rechargement habituels peuvent manquer. Ne pas compter sur Ctrl+F5 pour faire
recevoir une nouvelle version à l'utilisateur.

Le `?v=N` protège les ressources versionnées, **pas la page HTML elle-même**.
Un HTML conservé en cache peut continuer à référencer les anciennes versions.

- Vérifier les en-têtes de cache du HTML (`Cache-Control`) chez l'hébergeur,
  sans supposer leur durée sur GitHub Pages.
- Connaître la sortie de secours : désinstaller/réinstaller l'application ou
  vider les données du site, en tenant compte des données locales du projet.
- Après un déploiement important, vérifier qu'au moins une personne en mode
  PWA reçoit le correctif sans manipulation.

## 6. Le service worker survit — toute modification future repasse par ici

L'ajout ultérieur d'un cache peut affecter des appareils déjà équipés. Garder
dans `sw.js` un court commentaire sur la décision en vigueur et sa raison :
c'est ce fichier que la prochaine session ouvrira pour le modifier.

## 7. Avant de conclure qu'une PWA est sans effet

Relancer les suites navigateur avec le service worker **actif sur les vraies
pages** ; une page de test nue qui ne l'enregistre pas ne suffit pas. Vérifier
que le worker testé est bien actif et que les mocks réseau et les parcours
d'authentification passent toujours.
