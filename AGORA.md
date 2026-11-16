# AGORA — MD-LIB

Débats entre sessions indépendantes : travail de Claude relu par Codex,
travail de Codex relu par Claude. Le contradicteur lit les fichiers réels du
dépôt ; l'utilisateur fait le relais et tranche. Règles : `agora.md` §2 à §5
et §12. Le dépôt Git porte le débat, `CHANTIERS.md` porte la suite du travail.

Quand soumettre et quand s'en abstenir : `agora.md` §2 et §3 (ce dépôt étant
la source canonique de la règle, elle est ici à portée de main — ce n'est pas
le cas dans un projet consommateur).

## Pour répondre à un bloc

- **Jamais de réponse à son propre bloc.** Vérifier le commit de dépôt
  (`git log -1 --format=%B <sha du bloc>`) et la provenance du relais.
  Claude : vrai trailer `Claude-Session:` quand disponible. Codex : éditeur
  OpenAI, commit et trace de tâche disponible ; un trailer
  `Codex-Session: local:<id>` est une trace locale, pas un identifiant natif.
  Le champ `Auteur`, un identifiant local ou deux libellés différents ne
  prouvent pas seuls l'indépendance ; recouper avec le relais utilisateur et
  l'outil du répondant. Si l'identité reste incertaine, le signaler et demander
  l'arbitrage de l'utilisateur avant réponse (`agora.md` §10).
- **Append-only pendant le débat** : ajouter sa réponse, sans réécrire celle
  d'une autre session. Avant de rédiger, `git fetch origin main` puis
  `git merge --ff-only origin/main`, en préservant les modifications locales,
  et relire le fichier. Publier le commit vérifié **sur `main`**, selon les
  contrôles du projet. En cas de divergence, préserver le travail et reporter
  l'ajout depuis une copie à jour ; ni force-push ni rebase publié (§7).
- **Aucune donnée d'usager** dans un bloc : pas de ligne d'export, pas de log
  brut (`rgpd-securite.md`).

**Cycle** : bloc publié sur `main` → utilisateur dit « pull » au contradicteur
dans `maswaddpt47-cmyk/MD-LIB` → réponse publiée → utilisateur tranche.
Phrase complète : « pull maswaddpt47-cmyk/MD-LIB, lis son `AGORA.md`, réponds
à AG-00N, tu es <Codex ou Claude, session B> ». Aucune notification automatique
entre comptes ou outils. L'AGORA ne bloque pas le travail indépendant ; un
acte irréversible reste soumis avant le code. Une seule vérification de
livraison, puis correction des écarts démontrés sans nouveau tour d'office.

## Sincérité

1. **« Amendé » n'est valable que s'il nomme ce qui serait faux, manquant ou
   coûteux** si la proposition était appliquée telle quelle. Un amendement qui
   ne change ni code, ni décision, ni chiffre est un « confirmé ».
2. **« Confirmé » est une réponse pleine**, pas un aveu d'inutilité. Ne jamais
   chercher un amendement pour justifier sa présence.
3. **Aucune appréciation** de la proposition ni de son auteur : une réponse
   commence par un constat.

Le tableau des blocs tranchés porte le verdict et le total des trois issues.
**Le total est une alerte, pas un objectif** : le verdict découle de la
contrainte 1 appliquée au bloc, jamais de la série.

## Gabarit

```markdown
## AG-00N — Titre court — ouvert le JJ/MM/AAAA
**Auteur** : <Claude ou Codex, trace de session/travail> — lu sur `<sha court>`
**Proposition** : trois lignes maximum.
**Critère déclencheur** : n° et lequel (`agora.md` §2).
**Contradicteur** : Codex | Claude (session B)
**Ce que ça engage** : ce qui serait coûteux à défaire.
**Non vérifié par l'auteur** : limites de la vérification.
**Si personne ne répond, je fais quoi ?** : suite autorisée et décision restante.
**Où regarder** : fichier.md:120-180

### Réponse — <Codex ou Claude> — JJ/MM/AAAA
**Auteur** : <autre session/travail, trace disponible> — lu sur `<sha court>`
**Verdict** : confirmé | amendé | contredit
**Constat** : avec fichier:ligne, mesure ou log.
**Amendement** : ...

### Tranché le JJ/MM/AAAA — décision : ...
```

---

# Blocs ouverts

Aucun.

# Blocs tranchés

Total cumulé : 0 confirmé, 3 amendé, 0 contredit. Récits et preuves dans Git.

| Bloc | Décision | Verdict |
|---|---|---|
| AG-001 | 22/09/2026 — copie autonome : gabarit et règles de réponse | amendé |
| AG-002 | 17/10/2026 — alléger le suivi sans perdre les garanties et renvois | amendé |
| AG-003 | 16/11/2026 — réorganiser les instructions communes : §1-13, 71 règles, cinq familles conservés ; trois pertes corrigées (`c8cd55e`) ; Codex outil autorisé au CD47 | amendé |
