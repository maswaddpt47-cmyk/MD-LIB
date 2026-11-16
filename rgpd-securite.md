# Routine RGPD & sécurité des accès/données

Mémoire générale pour Claude et Codex, valable pour tous les projets (actuels
et futurs). Objectif : signaler sans attendre d'être interrogé une règle RGPD
ou de sécurité manifestement non garantie. Les obligations institutionnelles
du CD47 s'appliquent aux projets concernés ; les projets personnels suivent
leur propre politique de données.

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
- **Indice de mot de passe** : aucun aide-mémoire, indice ou description de la
  construction d'un mot de passe ou d'une clé dans une page ou un dépôt public ;
  la mémoire, c'est le gestionnaire de mots de passe (`collaboration.md`
  règle 69). Retirer un indice publié n'efface pas l'historique Git : changer
  le secret concerné.
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
- **Captures d'écran et fichiers envoyés à une IA** (charte d'utilisation de
  l'IA du CD47, §4 : pas de données personnelles ni confidentielles dans les
  outils d'IA ; ajouté le 06/10/2026) : captures faites dans un bac à sable ou
  sur des données fictives, sinon recadrées ; fichiers de test anonymisés.
  Une capture qui montre des données réelles se signale en une ligne :
  rappel d'habitude, pas alerte RGPD. Ne jamais dramatiser une donnée
  anonyme : la règle vise l'identifiable.
- **Durées et purges** : pour les projets soumis aux règles des archives
  publiques, une purge automatique est une élimination soumise au tableau de
  gestion et au visa des Archives départementales (`archivage-cd47.md`).
  Consignes IA du CD47 : `charte-ia-cd47.md`.

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
sms-mail-multi et `ateliers-backups` (**workflows de copie chiffrée seulement,
jamais le dossier `copies/`**). Périmètre : `main`, injection, XSS, secrets,
contrôle d'accès, dépendances vulnérables et checklist RGPD/sécurité sur tout
le dépôt, pas seulement les derniers changements. Dans Claude,
`/security-review` désigne ce parcours lorsqu'il est disponible ; ce n'est
pas une commande Codex. Le circuit de contradiction indépendante suit
`agora.md` §12 et `consigne-audit-externe.md`.

Inclure les workflows GitHub Actions (secrets, `permissions:`, accès SSH par
clé), la non-régression des tests RGPD-01 à RGPD-18 des Ateliers et la
confrontation du code au registre de sécurité (`ateliers-backups/documents/`) : une mesure
décrite qui n'est plus vraie est une trouvaille. Vérifier les points ouverts
du registre et le maintien des corrections déjà apportées, sans présumer
qu'un état ancien est encore vrai. Quand l'architecture change, actualiser
la consigne d'audit dans la foulée.

**Dernier état consigné (01–10/10/2026), relu le 16/11/2026** :

- La routine **`trig_01J6ZMsLHKbgXAQsRYgQL16q`** a été créée le 01/10/2026
  par l'utilisateur dans l'interface Routines de Claude, avec les dépôts
  attachés à la création. Configuration consignée : cron `0 8 1 1,4,7,10 *`
  en UTC, session neuve à chaque déclenchement
  (`create_new_session_on_fire`), notifications push et e-mail.
- L'ancienne routine `trig_018SBR4ihGT8Y2ud7sP5kxYm`, à consigne GAS
  périmée, a été **désactivée le 10/10/2026, pas supprimée**.
- Au contrôle du 10/10/2026, la routine créée dans l'interface n'apparaissait
  pas dans `list_triggers` : **cet outil ne permet pas de vérifier toutes les
  routines**. Pour celle-ci, consulter l'interface Routines et le rapport
  d'exécution ; son absence dans un outil ne prouve pas sa disparition.
- PAPPERBOARD a été ajouté le 10/10/2026 aux rappels d'audit Codex ; son
  ajout à la routine Claude restait à faire par l'utilisateur, avec le texte
  de `PAPPERBOARD/docs/routine-audit-trimestriel.md`.

**État actuel et exécutions réelles : non vérifiés au 16/11/2026.** Cette
note décrit une configuration, pas une surveillance démontrée. Lors du
contrôle trimestriel, ou sans notification depuis plus de 3–4 mois, vérifier
dans l'interface concernée les passages réels, les dépôts effectivement
audités et les omissions du rapport avant d'envisager une reprogrammation.
Ne pas supposer que les outils de routines de Claude existent dans Codex.

**Limite consignée le 01/10/2026** : une routine créée dans l'interface ne
pouvait pas être modifiée par `update_trigger`. Dans ce cas, l'IA prépare
la consigne complète et l'utilisateur la colle dans le champ « Instructions ».
L'historique détaillé des anciennes routines et incidents reste dans Git.

## Règle de mot de passe imposée à la connexion (13/11/2026)

Une règle vérifiée seulement au **choix** d'un mot de passe laisse passer les anciens (repris à un import, provisoires) :
le serveur la vérifie **aussi à chaque connexion** ; hors règle, le compte passe en « doit changer », **le serveur refuse
toute autre action** que le changement (pas seulement l'écran), et les sessions déjà ouvertes tombent au passage, sous
verrou. Constat : ATELIERS (AG-059/060), un compte superviseur encore sur un ancien mot de passe devinable, l'Admin
ignorait « doit changer ».
