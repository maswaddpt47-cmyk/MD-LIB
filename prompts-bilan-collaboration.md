# Prompts — bilan de collaboration avec une IA

Trois prompts pour recueillir et synthétiser des comptes rendus de collaboration,
à donner à une session en fin de travail. Déplacés le 04/11/2026 depuis le
`CLAUDE.md` de sms-mail-multi (ménage des `CLAUDE.md`, décision de l'utilisateur).
Ce ne sont pas des règles : rien à copier dans les projets.
Les gabarits conviennent à Claude comme à Codex ; nommer l'IA concernée dans
le contexte pour attribuer les constats à la bonne session.

## Interroger une nouvelle session sur sa collaboration

> D'après notre collaboration sur ce projet, décris-moi franchement comment tu la
> trouves. Réponds avec cette structure exacte, en markdown :
>
> ```
> ## Contexte
> [1-2 phrases sur le projet/la nature du travail]
>
> ### Tendances observées chez l'IA
> [liste à puces, un exemple concret par point, tiré de nos échanges réels — pas de généralités]
>
> ### Ce qui fonctionne bien
> [liste à puces, exemples concrets]
>
> ### Suggestions concrètes
> Côté IA :
> [liste à puces]
>
> Côté utilisateur :
> [liste à puces]
> ```
>
> Base-toi uniquement sur des exemples concrets de nos échanges, jamais des
> généralités. Sois honnête même si ce n'est pas flatteur.

## Reformater un compte-rendu déjà donné (sans changer le fond)

> Remets ta réponse précédente (celle où tu décrivais notre collaboration) exactement
> dans cette structure markdown, sans changer le fond ni ajouter de nouveaux
> exemples — juste réorganiser ce que tu as déjà dit :
>
> ```
> ## Contexte
> [1-2 phrases sur le projet/la nature du travail]
>
> ### Tendances observées chez l'IA
> [liste à puces, reprends tes exemples déjà donnés]
>
> ### Ce qui fonctionne bien
> [liste à puces, reprends tes exemples déjà donnés]
>
> ### Suggestions concrètes
> Côté IA :
> [liste à puces]
>
> Côté utilisateur :
> [liste à puces]
> ```
>
> Si un de tes points ne rentre dans aucune de ces cases, mets-le dans celle qui s'en
> approche le plus plutôt que de le supprimer.

## Régénérer le document de synthèse final avec de nouvelles entrées

> Voici plusieurs comptes-rendus de collaboration, chacun structuré en Contexte /
> Tendances observées chez l'IA / Ce qui fonctionne bien / Suggestions concrètes
> (Côté IA, Côté utilisateur), recueillis dans des sessions et projets différents.
> Les anciens libellés « chez Claude » ou « Côté Claude » se lisent dans ces
> mêmes rubriques ; conserve l'attribution à Claude ou Codex dans les constats.
>
> **Finalité** : produire un guide de référence durable que je réutiliserai au
> démarrage de mes futures sessions avec Claude ou Codex, sur n'importe quel
> projet — pas un compte-rendu de plus, un document qui doit directement améliorer
> la collaboration dès la prochaine fois que je l'utilise.
>
> **Usage prévu** : je collerai ce document (ou des extraits) en début de conversation
> dans de futures sessions Claude ou Codex, ou je m'en servirai comme proposition
> d'amélioration des instructions de mes projets (`CLAUDE.md` ou `AGENTS.md`).
> La synthèse doit être utilisable sans l'historique de conversation. Les règles
> nouvelles restent proposées à l'utilisateur avant leur inscription ; celles
> déjà présentes dans MD-LIB sont référencées plutôt que recopiées en doublon.
>
> **Analyse à produire** :
> 1. Identifie les tendances qui reviennent dans au moins deux entrées différentes
>    (patterns récurrents, donc probablement fiables) — cite les projets concernés
>    pour chaque pattern.
> 2. Identifie les points qui n'apparaissent qu'une seule fois — à noter comme
>    spécifiques à un contexte, sans les généraliser.
> 3. Termine par une liste de règles de collaboration concrètes et actionnables (pas
>    de généralités), pour moi et pour l'IA, classée par ordre de priorité — les
>    patterns récurrents en premier.
> 4. Ne garde que ce qui est exploitable en pratique, pas un résumé pour le plaisir de
>    résumer.
>
> Voici les entrées :
> [coller ici toutes les "Entrées" collectées, anciennes et nouvelles]
