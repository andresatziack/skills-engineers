---
name: writing-fragments
description: Sessão de grilling que minera o usuário em busca de fragmentos — pepitas heterogêneas de escrita (afirmações, vinhetas, frases afiadas, meios-pensamentos) — e os anexa a um único documento como matéria-prima para um futuro artigo. Use quando o usuário quiser desenvolver ideias antes de impor estrutura, ou mencionar "fragmentos", "ideação" ou "matéria-prima" para escrita.
---

<what-to-do>

Rode uma sessão de grilling que produza fragmentos. Entreviste o usuário implacavelmente sobre o que quer que ele queira escrever. Não imponha fases, outlines ou estrutura — isso está explicitamente fora do escopo.

Conforme fragmentos emergem dos dois lados da conversa, anexe-os a um único arquivo markdown. O usuário vai estar editando esse arquivo durante a sessão; sempre releia antes de escrever para que as edições dele sejam preservadas.

Se o usuário não passou um caminho, pergunte uma vez onde salvar o documento e depois lembre dele pelo resto da sessão.

Capture fragmentos da primeiríssima coisa que o usuário diz, incluindo o prompt inicial.

Na primeira escrita, coloque um único H1 no topo com um título de trabalho (ele pode mudar depois) e nada mais — sem metadata, sem TOC, sem data.

</what-to-do>

<supporting-info>

## O que é um fragmento

Um fragmento é qualquer pedaço de texto que pode sobreviver até o artigo final. Ele precisa ser _legível pelo autor_ — o autor consegue dizer o que significa — mas não precisa definir seus termos nem ser compreensível para um leitor frio. A barra é "isto é um pedaço de boa escrita?", não "isto é um argumento autocontido?"

Fragmentos são deliberadamente heterogêneos. Exemplos do que pode ser um fragmento:

- Uma frase afiada que você gostaria de usar em algum lugar mas ainda não sabe onde.
- Uma afirmação com uma justificativa de uma linha.
- Uma vinheta: algo que aconteceu, um trecho de código, um cenário, uma analogia.
- Um meio-pensamento: "algo sobre como X parece com Y, depois eu trabalho isso melhor."
- Uma citação, um pedaço de diálogo, uma frase ouvida por acaso.
- Uma lista de observações relacionadas que se sustentam por afinidade.
- Uma reclamação, uma confissão, uma piada.

O diário do romancista é o modelo: anos de notas não estruturadas que mais tarde são mineradas para virar matéria-prima. Fragmentos são notas.

## Formato do arquivo

```markdown
# Working title

A first fragment lives here.

It can be multiple paragraphs. It can include lists, code, quotes — whatever
shape the fragment naturally takes.

---

A second fragment.

---

> A quoted line that the user wants to keep around.

A reaction to it.

---

- A cluster of related observations
- That hang together by feel
- And want to be near each other
```

Fragmentos são separados por uma régua horizontal (`\n---\n`). Sem headings dentro do corpo. Sem tags. Sem ordem além da ordem em que foram adicionados.

## Ritmo de escrita

Anexe em silêncio. Não peça permissão para cada fragmento. Mencione o que você adicionou de passagem ("adicionando isso"), mas não interrompa a conversa com diálogos de salvar.

Antes de cada escrita: releia o arquivo do disco. O usuário pode ter editado, reordenado ou deletado fragmentos entre turnos — preserve as mudanças dele. Nunca sobrescreva o arquivo; só anexe (ou, se o usuário pedir, edite um fragmento específico no lugar).

O usuário pode dizer "cut the last one", "rewrite that one sharper", "merge those two" a qualquer momento. Trate isso como instruções de primeira classe.

</supporting-info>
