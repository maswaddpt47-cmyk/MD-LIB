# MD-LIB

Référence commune de travail pour Claude et Codex. Les règles en vigueur,
les procédures spécialisées et la passation ont des rôles distincts ;
l'historique des décisions reste accessible dans Git.

## Démarrer une session

1. Vérifier dépôt, branche et état local ; actualiser sans écraser les éditions
   (`git-workflow.md` §1).
2. Claude utilise [`CLAUDE.md`](CLAUDE.md) et son import `@collaboration.md`
   lorsque l'environnement les charge. Si le chargement n'est pas établi,
   ouvrir les fichiers explicitement.
3. Codex lit [`AGENTS.md`](AGENTS.md), puis explicitement
   [`collaboration.md`](collaboration.md) : il ne suit pas l'import Claude.
4. Lire la passation [`CHANTIERS.md`](CHANTIERS.md), les consignes du projet
   concerné et les fiches utiles à la tâche. Un ancien chantier ne remplace
   jamais la demande actuelle de l'utilisateur.

Les instructions de session et les décisions de l'utilisateur s'appliquent.
Une exception de projet validée garde sa portée locale. Si les décisions
existantes ne départagent pas deux consignes, exposer le conflit avant l'action.
Les contraintes de la plateforme restent applicables.

## Où lire quoi

| Besoin | Source |
|---|---|
| Règles communes et numéros historiques | [`collaboration.md`](collaboration.md) |
| Entrée Claude et fonctionnement de MD-LIB | [`CLAUDE.md`](CLAUDE.md) |
| Entrée Codex, consignes essentielles hors réseau | [`AGENTS.md`](AGENTS.md) |
| État courant, invariants, actions restantes entre projets | [`CHANTIERS.md`](CHANTIERS.md) |
| Actualisation, branches, commits et publication | [`git-workflow.md`](git-workflow.md) |
| Ajouter ou simplifier une instruction | [`hygiene-instructions.md`](hygiene-instructions.md) |
| Prouver une publication et vérifier son commit | [`deploiement.md`](deploiement.md), scripts dans `outils/` |
| Choix de cache et service worker des projets concernés | [`pwa-service-worker.md`](pwa-service-worker.md) |
| Circuit de contradiction Claude/Codex et installation | [`agora.md`](agora.md) |
| Blocs de contradiction de ce dépôt | [`AGORA.md`](AGORA.md) |
| Concevoir les données et vérifier les chiffres diffusés | [`chiffres-diffuses.md`](chiffres-diffuses.md) |
| Préparer un audit externe indépendant | [`consigne-audit-externe.md`](consigne-audit-externe.md) |
| Confidentialité, sécurité, mots de passe et limites des routines | [`rgpd-securite.md`](rgpd-securite.md) |
| Présenter l'utilisateur à une autre IA | [`Auteur.md`](Auteur.md) |
| Recueillir un bilan de collaboration | [`prompts-bilan-collaboration.md`](prompts-bilan-collaboration.md) |

Les fiches spécialisées se lisent selon la tâche. Les gabarits destinés à une
copie dans un projet doivent conserver les garanties nécessaires à leur autonomie.
Ne pas recopier les récits de propagation dans les fichiers de démarrage.

## Références institutionnelles

Références communes désignées le 29/10/2026 :

| Source | Objet |
|---|---|
| [`archivage-cd47.md`](archivage-cd47.md) | Conservation, tableau de gestion, archives publiques |
| [`charte-ia-cd47.md`](charte-ia-cd47.md) | Usage de l'IA, confidentialité, responsabilité humaine |
| [`charte-graphique-cd47.md`](charte-graphique-cd47.md) | Identité visuelle et documents CD47 |
| [`rgpd-securite.md`](rgpd-securite.md) | Minimisation, sécurité des accès et des données |

Les résumés institutionnels renvoient aux sources qui font foi ; les PDF internes
ne sont pas publiés ici. Le PDF graphique présent accompagne son résumé.
Leur portée dépend du projet : ne pas imposer l'identité ou les obligations
institutionnelles CD47 à un projet personnel sans objet. Citer les références
sans recopier leurs résumés.

## Maintenir et partager

La source commune est modifiée ici. Les copies nécessaires et les adaptations
locales suivent la procédure de [`CLAUDE.md`](CLAUDE.md#règle-de-propagation--la-plus-importante).
La modification de MD-LIB ne garantit pas sa relecture par une session déjà
ouverte. Le relais entre assistants passe par le dépôt et l'utilisateur ;
aucune conversation automatique entre leurs comptes n'est supposée.
