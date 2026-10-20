# CHANTIERS — relais vers le projet

État au **20/10/2026**, mesuré ; la passation WoocLight ci-dessous date du 19/10/2026.

## Propagation des consignes Codex — intégration restante

- PAPPERBOARD : adaptation de `AGENTS.md` poussée sur
  `codex/regles-collaboration`, commit `4aff306` (20/10/2026).
- Reste : vérifier le contrôle CI `tests` sur ce commit, puis intégrer à
  `main` en avance rapide selon le `CLAUDE.md` du projet. Ne pas contourner
  la protection de `main`. L’accès à l’API GitHub Actions a renvoyé HTTP 403
  dans cette session ; résultat de CI non vérifié.
- SMS-mail reste gelé : aucune propagation dans ce dépôt.

## Reprise WoocLight / PAPPERBOARD

La source principale de passation est **PAPPERBOARD/CHANTIERS.md**.
Ce fichier de MD-LIB est seulement un renvoi ; il ne duplique pas l’état du projet.

- Dépôt : `maswaddpt47-cmyk/PAPPERBOARD`.
- Branche à reprendre : `codex/interface-simulation-fidele`.
- [Passation complète dans la branche](https://github.com/maswaddpt47-cmyk/PAPPERBOARD/blob/codex/interface-simulation-fidele/CHANTIERS.md).
- Commit de passation : `f19df16850ab4a970d21715643b1f63c3495e9a3`.
- L’utilisateur a ouvert une autre session Codex pour reprendre ; l’ancienne
  session arrête ses modifications après cette transmission.

Dans la nouvelle session : actualiser le dépôt, lire ses AGENTS.md, CLAUDE.md
et CHANTIERS.md sur cette branche, puis poursuivre à partir de l’état constaté.
Ne pas reprendre les anciens paragraphes de main comme état du complément non
encore déployé. Les autorisations et prochaines actions sont dans la passation.
