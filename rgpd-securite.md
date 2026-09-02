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
trois mois sur ATELIERS_NEWGEN et Ateliers CD47 NextStep : `/security-review`
sur `main` (injection, XSS, secrets, contrôle d'accès, dépendances
vulnérables) + repassage complet de la checklist RGPD/sécurité sur tout le
repo, pas seulement les derniers changements.

**Important — ceci n'est PAS automatique dans l'absolu.** C'est une routine
planifiée (`create_trigger`) **rattachée à une session Claude Code Remote
précise**, pas une propriété de ce fichier ni des `CLAUDE.md` des projets.
Si cette session expire ou est fermée avant sa prochaine échéance, la
routine s'arrête et personne n'est prévenu automatiquement — il faut la
reprogrammer depuis une session active. Cette note sert de traçabilité :
si l'audit trimestriel n'a pas eu lieu depuis plus de 3-4 mois, c'est le
signal qu'il faut la reprogrammer.
