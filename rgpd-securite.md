# Routine RGPD & sécurité des accès/données

Mémoire générale, valable pour tous les projets (actuels et futurs). Objectif :
que Claude alerte systématiquement, sans attendre d'être interrogé, si une
règle RGPD ou de sécurité n'est manifestement pas garantie.

## Quand vérifier

1. **En début de session** — dès qu'un fichier touchant à des données
   utilisateurs, des accès, des identifiants ou une config d'hébergement est
   lu ou modifié : passer mentalement la checklist ci-dessous.
2. **À chaque chantier** — avant de considérer une fonctionnalité terminée
   (formulaire, export, nouvel appel API, stockage, authentification) :
   repasser la checklist sur le périmètre du chantier avant de dire que
   c'est fini.
3. **Immédiatement si un doute apparaît** — ne pas attendre la fin de la
   tâche pour signaler un point RGPD/sécurité repéré en cours de route.

Le signalement se fait **explicitement dans la réponse** (pas juste en
commentaire dans le code), même si l'utilisateur n'a rien demandé sur le
sujet — cf. règle de collaboration n°4 (signaler toute déviation au moment
où elle est constatée).

## Checklist RGPD

- **Minimisation** : les champs/données collectés sont-ils tous nécessaires
  à la finalité affichée ? Pas de champ "au cas où".
- **Base légale** : la collecte a-t-elle une justification claire (consentement,
  obligation légale, intérêt légitime) ? Signaler si absente ou implicite.
- **Durée de conservation** : y a-t-il une purge/anonymisation prévue, ou les
  données s'accumulent indéfiniment ?
- **Droits des personnes** : accès, rectification, suppression possibles en
  pratique (pas juste en théorie) ?
- **Sous-traitants / hébergement** : où les données transitent-elles/sont-elles
  stockées (Google Apps Script, CDN, mutualisé, hors UE) ? Signaler tout
  transfert hors UE ou vers un service tiers sans base contractuelle connue.
- **Données sensibles** : santé, origine, opinions, données de mineurs — niveau
  de protection renforcé attendu, à signaler explicitement si présent.
- **Traçabilité** : les traitements (formulaires, exports, imports) sont-ils
  documentés quelque part (même sommairement) ?

## Checklist sécurité des accès et des données

- **Secrets en clair** : clé API, mot de passe, token, URL de webhook non
  publique — jamais commités en clair dans le code ou poussés sur un repo
  public. Vérifier avant chaque commit/push (cf. règle git déjà en place).
- **Contrôle d'accès** : une action sensible (suppression, export massif,
  administration) est-elle protégée par une authentification/autorisation
  réelle, ou accessible à qui a l'URL ?
- **Transport** : les échanges de données sensibles passent-ils en HTTPS ?
  Pas d'endpoint en clair pour des données personnelles.
- **Stockage côté client** : localStorage/sessionStorage/cookies — pas de
  donnée sensible stockée sans nécessité, pas de token longue durée exposé
  côté navigateur sans raison.
- **Dépendances** : ajout d'une nouvelle lib/CDN externe — vérifier qu'elle
  ne s'exécute pas avec des privilèges disproportionnés (accès DOM complet,
  requêtes réseau non maîtrisées).
- **Permissions par défaut** : un nouvel utilisateur/rôle créé a-t-il le
  minimum de droits nécessaires, ou hérite-t-il par défaut de droits larges ?
- **Logs** : les logs (erreurs, exécutions GAS, etc.) contiennent-ils des
  données personnelles en clair qui ne devraient pas y être ?

## Format du signalement

Quand un point n'est pas garanti, le dire dans ces termes (court, direct,
sans bloquer le travail sauf si c'est critique) :

> ⚠️ RGPD/sécurité : <point précis>. <conséquence concrète si possible>.
> <action recommandée ou question pour trancher>.

Ne pas transformer ça en audit permanent qui ralentit tout : un point
mineur et déjà connu de l'utilisateur ne mérite qu'une ligne, pas un
paragraphe. Un point critique (secret exposé, donnée sensible non protégée)
doit être signalé immédiatement, avant de continuer la tâche en cours.

## Audit de sécurité approfondi trimestriel

En complément de la vigilance légère ci-dessus (déclenchée au fil de l'eau
sur ce qui est touché en session), un audit plus poussé est prévu tous les
trois mois sur ATELIERS_NEWGEN, Ateliers CD47 NextStep, GDINV2, SMS-mail et
sms-mail-multi (ajoutés le 23/09/2026) et `ateliers-backups` (ajouté le
30/09/2026 : workflows de copie chiffrée seulement, jamais le dossier
`copies/`) :
`/security-review`
sur `main` (injection, XSS, secrets, contrôle d'accès, dépendances
vulnérables) + repassage complet de la checklist RGPD/sécurité sur tout le
repo, pas seulement les derniers changements.

C'est une routine planifiée (id **`trig_01J6ZMsLHKbgXAQsRYgQL16q`**, créée
par l'utilisateur dans l'interface Routines le 01/10/2026, **6 dépôts
attachés** ; l'ancienne `trig_018quyGJKmHRXRWYxpw9ous4`, sans dépôt, a été
supprimée le 01/10/2026 à la demande de l'utilisateur, cron `0 8 1 1,4,7,10 *` — évalué en
**UTC**, soit 09 h ou 10 h heure française selon la saison), configurée en mode
**session neuve à chaque déclenchement** (`create_new_session_on_fire`) — donc
indépendante de toute session de travail : la supprimer, la fermer ou la
laisser expirer n'affecte pas la routine. Notification push + email à chaque
exécution.

⚠️ **La routine a disparu une première fois.** Recréée le 23/09/2026 : un
`list_triggers` ce jour-là n'a renvoyé **aucune** routine, alors que ce
fichier et les trois `CLAUDE.md` consommateurs affirmaient depuis le
20/09/2026 qu'un audit trimestriel tournait. L'id précédent
(`trig_018SBR4ihGT8Y2ud7sP5kxYm`) n'existait plus. Cause inconnue — jamais
créée, ou supprimée depuis. **Leçon : cette note ne prouve rien par
elle-même.** Le seul contrôle qui vaut est `list_triggers`.

⚠️ **Limite connue de la routine recréée** : elle a été créée depuis une
session qui ne portait aucun connecteur, donc les sessions qu'elle déclenche
tournent **sans les outils `mcp__*`** — notamment l'attachement de dépôts et
l'API GitHub. Conséquence possible : l'audit ne couvre que les dépôts déjà
attachés par défaut à l'environnement. **Non vérifié** — à constater au
premier déclenchement (01/10/2026). Si le rapport ne couvre pas les cinq
dépôts, recréer la routine depuis l'interface Routines de claude.ai, ou depuis
une session qui porte les connecteurs.

**Consigne mise à jour le 30/09/2026** (`update_trigger`, même id) : elle
décrivait encore Google Apps Script (endpoints sans jeton, `PropertiesService`)
alors que les Ateliers tournent sur l'API PHP d'Alwaysdata depuis le 25/09.
Elle porte désormais : l'architecture actuelle ; les workflows GitHub Actions
(secrets, `permissions:`, accès SSH par clé) ; la non-régression des tests
RGPD-01 à RGPD-18 ; la confrontation du code au registre de sécurité
(`ateliers-backups/documents/`, une mesure décrite qui n'est plus vraie est
une trouvaille) ; les points ouverts du §9 du registre (faille ACME
d'Alwaysdata, DPA, GitHub sur la liste DPF). Réalignée le soir même :
l'historique des copies et l'ancien secret SSH, soldés le 30/09, y sont
devenus des points à vérifier qu'ils restent soldés. Le texte fait foi dans la routine elle-même : le relire par
`get_trigger`, pas ici. **Quand l'architecture d'un projet audité change,
mettre à jour la consigne dans la foulée** — elle a eu cinq jours de retard
cette fois.

⚠️ La routine n'a **aucun dépôt attaché** (`sources` vide) ni connecteur :
l'audit dépend de `add_repo` dans la session déclenchée. Premier
déclenchement le 01/10/2026 : vérifier en tête du rapport la liste des dépôts
non audités.

**Leçon du 01/10/2026** : la première exécution (ancienne routine, aucun
dépôt attaché, aucun connecteur) a tourné 4 minutes sans rien consigner ;
l'audit a été refait en session. Une routine d'audit doit avoir ses dépôts
attachés à la création (champ « Sélectionner un dépôt » de l'interface,
introuvable ensuite) ; aucun connecteur n'est nécessaire. Une routine créée dans l'interface **ne peut pas
être modifiée par Claude** (`update_trigger` refusé) : toute mise à jour de
la consigne passe par l'utilisateur (champ « Instructions », seul champ
modifiable). Claude prépare le texte complet, l'utilisateur le colle.

**Contrôle à faire** : si aucune notification n'est arrivée depuis plus de
3-4 mois, vérifier avec `list_triggers` et reprogrammer.
