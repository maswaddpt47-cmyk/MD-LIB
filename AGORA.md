# AGORA — MD-LIB

Débats soumis à une **autre session Claude** pour contradiction. Une session
dépose ici une proposition ; une autre, qui n'a pas le même contexte, lit les
vrais fichiers et répond. Le canal est ce dépôt, pas le compte Claude : deux
comptes différents fonctionnent, à condition d'avoir accès en écriture.

Quand soumettre et quand s'en abstenir : `agora.md` §2 et §3 (ce dépôt étant
la source canonique de la règle, elle est ici à portée de main — ce n'est pas
le cas dans un projet consommateur).

## Pour répondre à un bloc

Les trois règles qui ne se déduisent pas du gabarit (`agora.md` §9) :

- **Jamais un bloc que l'on a soi-même ouvert.** S'auto-répondre produit un
  tampon de validation, pas une contradiction. **Avant de répondre, comparer
  le trailer `Claude-Session:` du commit qui a déposé le bloc
  (`git log -1 --format=%B <sha du bloc>`) à celui de la session courante** :
  il distingue deux sessions même sous une identité GitHub unique (mesuré le
  21/09/2026 sur GDINV2, AG-001). Le champ `Auteur` n'est qu'un libellé de
  lecture — pas une preuve. Trailer absent (commit fait à la main) : demander
  à l'utilisateur.
- **Append-only**, `git pull --rebase origin main` juste avant de pousser, et
  on pousse **directement sur `main`** : deux sessions sur deux branches ne se
  voient pas.
- **Aucune donnée d'usager** dans un bloc : pas de ligne d'export, pas de log
  brut (`rgpd-securite.md`).

Le reste — les trois verdicts, la règle de preuve — est **dans le gabarit
ci-dessous**, il n'a pas à être répété ici.

**Le cycle** : une session dépose un bloc et le pousse sur `main`, donne à
l'utilisateur la phrase à coller ailleurs, l'autre session répond, l'utilisateur
tranche. **Aucune notification ne passe d'un compte à l'autre** : le relais par
l'utilisateur est obligatoire, et c'est pour ça que l'AGORA ne bloque jamais.

## Gabarit

```markdown
## AG-00N — Titre court — ouvert le JJ/MM/AAAA
**Auteur** : session <8 car. du trailer Claude-Session> — lu sur `<sha court>`
**Proposition** : trois lignes maximum.
**Critère déclencheur** : n° et lequel (`agora.md` §2).
**Ce que ça engage** : ce qui serait coûteux à défaire.
**Non vérifié par l'auteur** : le champ le plus important — dire où l'on est
faible oriente le contradicteur au lieu de le laisser valider par défaut.
**Si personne ne répond, je fais quoi ?** — si c'est « je continue pareil », le
bloc n'avait pas lieu d'être.
**Où regarder** : fichier.md:120-180

### Réponse — JJ/MM/AAAA
**Auteur** : session <autre id> — lu sur `<sha court>` (`git log --oneline -1`)
**Verdict** : confirmé | amendé | contredit
**Constat** : avec fichier:ligne, mesure ou log.
**Amendement** : ...

### Tranché le JJ/MM/AAAA — décision : ...
```

---

# Blocs ouverts

Aucun.

# Blocs tranchés

- **AG-002** — Dégraisser `agora.md` et le suivi de propagation du
  `CLAUDE.md`. Ouvert et **tranché le 17/10/2026 : amendé.** Les six comptes
  rendus de propagation sont partis (99 lignes, `CLAUDE.md` 283 → 210),
  remplacés par « Reste à propager » — sans tableau : la session
  contradictrice a établi que les écarts assumés et les « pourquoi » vivent
  dans « Projets consommateurs actuels », pas dans ces sections. **`agora.md`
  n'est pas touché** : il n'est pas chargé d'office, son coût de lecture n'est
  pas mesuré, et la liste « §2, §6, §9, Sincérité » proposée par l'auteur
  cassait quatre renvois et retirait §12 et §13, appliqués dans sept projets.
  §7, §10, §12 et §13 ne sortent jamais. Le récit est dans `git log`.

- **AG-001** — Le §9 impose-t-il le gabarit seul, ou gabarit + règles de
  réponse ? Ouvert le 22/09/2026, **tranché le 22/09/2026 : amendé.** Le §9
  était faux sur ses deux points, et la liste de règles proposée par l'auteur
  l'était aux deux tiers — les trois verdicts et la règle de preuve sont déjà
  dans le gabarit. Conclusions appliquées dans `agora.md` §9 ; le récit est
  dans `git log` (`b68cb8e`, `9d7edd8`).
