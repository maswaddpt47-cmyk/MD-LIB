# Consigne d'audit par une IA d'un autre éditeur — modèle

Modèle établi le 06/10/2026, clarifié le 16/11/2026. Auteur Claude : audit
Codex ; auteur Codex : audit Claude (`agora.md` §12). Adapter le CONTEXTE et,
pour les calculs, le périmètre selon `chiffres-diffuses.md`.

**Avant** : accès en lecture seule aux seuls dépôts audités (jamais un dépôt
privé de sauvegardes ou de registres) ; autorisations « Lecture seule » ;
réflexion au plus haut niveau ; aucune donnée réelle, capture ni identifiant.
**Après** : vérifier chaque point dans le code avant de le croire ; ranger le
rapport vérifié hors de tout dépôt public ; mettre les registres à jour.

```text
Tu es auditeur de sécurité et de conformité RGPD. Audit en LECTURE SEULE :
ne modifie aucun fichier, ne crée ni branche ni pull request, n'appelle aucune
URL de production.

CONTEXTE (faits, pas conclusions)
<ce que fait l'application, pour qui ; architecture (pages, serveur, base,
hébergement) ; authentification et rôles ; déploiement ; données
personnelles traitées>

RÈGLE DE MÉTHODE
Lis les instructions obligatoires de fonctionnement et de sûreté du dépôt
(AGENTS.md, CLAUDE.md et règles applicables). Elles ne remplacent pas la
vérification du code. Évite de consulter les conclusions et anciens rapports
d'audit, y compris ceux de CHANTIERS.md ou AGORA.md, avant ton propre relevé.
S'ils sont mêlés aux instructions ou déjà connus, signale cette limite :
ne prétends pas les avoir ignorés. Compare tes résultats à la fin.
N'ouvre aucune sauvegarde ni fichier réel d'usagers ; ne reproduis aucun
secret ou identifiant découvert. Pour un rejeu, utilise seulement un jeu
fictif autorisé. Les diagnostics sur données réelles restent dans
l'application de l'utilisateur, chiffres seuls, sans lecture par l'IA.

À EXAMINER
1. Contrôle d'accès : pour CHAQUE action du serveur, quel rôle peut l'appeler,
   et peut-on contourner (jeton d'un autre rôle, paramètre forcé, données
   d'un autre utilisateur) ?
2. Sessions et mots de passe : création, durée, annulation, changement,
   réinitialisation, blocage après échecs.
3. Injections : SQL, XSS (tout HTML construit à la main), formules dans les
   exports CSV/Excel, en-têtes de mail.
4. Pages publiques (sans connexion) : abus possibles, données exposées.
5. Secrets et configuration : secret en clair, configuration accessible,
   erreurs trop bavardes, CORS, services externes appelés.
6. Workflows de déploiement : injections, permissions, secrets.
7. Bibliothèques embarquées : versions et failles connues.
8. RGPD : minimisation, durées de conservation et purges réellement
   appliquées, données personnelles dans les journaux et dans le code.

FORMAT DE RÉPONSE (en français)
Un tableau, un problème par ligne, du plus grave au moins grave :
| N° | Gravité | fichier:ligne | Problème | Scénario concret | Correction proposée | Confiance |
|---|---|---|---|---|---|---|
Gravité : critique / haute / moyenne / basse. Confiance : certain / probable / à vérifier.

Règles :
- Pas de problème sans fichier:ligne et sans scénario concret. Un risque
  théorique sans chemin d'exploitation va dans une liste à part
  « Remarques ».
- Chaque ligne doit avoir été vérifiée en lisant le code appelant. Précise
  la voie d'entrée (écran, import, ancienne donnée, API) et les rôles concernés.
- Termine par « Ce que je n'ai pas pu vérifier ».
- Si tu ne trouves rien de grave dans une catégorie, dis-le en une ligne.
```
