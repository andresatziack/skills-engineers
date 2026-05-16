---
name: writing-shape
description: Pega um arquivo markdown de matéria-prima e o molda em um artigo por meio de uma sessão conversacional — esboçando aberturas candidatas, crescendo o texto parágrafo por parágrafo, argumentando sobre formato (listas, tabelas, callouts, citações) a cada passo. Use quando o usuário tem uma pilha de notas, fragmentos ou um rascunho cru e quer ajuda para transformá-lo em algo publicável.
---

<what-to-do>

O usuário passou (ou vai passar) um arquivo markdown de matéria-prima. Trate-o como a pilha de entrada — qualquer coisa, de uma lista organizada de fragmentos a uma parede de prosa não estruturada a uma transcrição. O formato não importa. Leia-o de ponta a ponta antes de fazer qualquer outra coisa.

Depois rode uma sessão de moldagem que produza um documento de artigo separado. Não edite o arquivo de matéria-prima — ele é somente leitura para esta skill.

Se o usuário não disse onde salvar o artigo, pergunte uma vez e lembre o caminho. O usuário vai estar editando o arquivo do artigo durante a sessão; sempre releia antes de escrever para que as edições dele sejam preservadas.

</what-to-do>

<supporting-info>

## O loop

1. **Leia a pilha.** Leia o arquivo de entrada por inteiro. Forme uma noção do que está nele.
2. **Esboce 2-3 aberturas candidatas.** Cada abertura deve implicar uma tese ou ângulo diferente para o artigo. Mostre todas. Force o usuário a escolher ou compor um híbrido. A abertura escolhida define o que o resto do artigo precisa fazer.
3. **Cresça parágrafo por parágrafo.** Depois que a abertura aterrissar, pergunte "dado este início, o que o leitor precisa ouvir a seguir?" Puxe material da pilha para responder. Argumente sobre se o próximo beat é um parágrafo, uma lista, uma tabela, um callout, uma citação, um bloco de código. Cada escolha de formato deve ser deliberada e defensável.
4. **Anexe ao arquivo do artigo conforme você for.** Não faça em batch. Escreva cada parágrafo ou bloco acordado imediatamente para que o usuário possa ver o artigo tomando forma.
5. **Repita o passo 3 até o artigo estar pronto.** O usuário decide quando está pronto.

## Sensação conversacional

Esta é uma sessão de grilling invertida. Na ideação, a pergunta era "o que você está realmente notando?" Aqui é "o que este artigo está realmente argumentando, e em que ordem o leitor precisa ouvir?" Empurre de volta. Recuse-se a deixar transições fracas passarem. Se um parágrafo não merece seu lugar, corte-o.

Movimentos específicos para continuar usando:

- "What does this paragraph do for the reader that the previous one didn't?"
- "If I cut this, what breaks?"
- "Is this prose, or should it be a list? Why prose?"
- "This sentence is doing two jobs — split it or pick one."
- "The opening promised X. We've drifted to Y. Either re-thread it or change the opening."

## Puxando da pilha

Trate a matéria-prima como uma pedreira, não como um roteiro. Puxe um fragmento, retrabalhe-o para se encaixar no parágrafo ao redor e o coloque. Um fragmento pode ser dividido entre vários parágrafos, fundido com outro ou parafraseado. O trabalho da pilha é ser minerada; o trabalho do artigo é ler como uma única voz.

Se a pilha não tiver algo que o artigo precisa, nomeie a lacuna explicitamente: "We need an example here and the pile doesn't have one — give me one now or we cut this section."

## Argumentos de formato para realmente ter

Ao escolher como renderizar um beat, pondere essas trade-offs em voz alta com o usuário, não em silêncio:

- **Prosa vs. lista.** Prosa carrega argumento; listas carregam itens paralelos. Se os itens não são realmente paralelos, prosa é melhor. Se são, uma lista é mais rápida de escanear.
- **Inline vs. callout.** Tips, warnings e apartes vão em callouts (`> [!TIP]`, `> [!NOTE]`) — mas só se eles fossem genuinamente descarrilhar o argumento principal inline. Caso contrário, deixe inline.
- **Tabela vs. estrutura repetida.** Se a mesma forma se repete 3+ vezes com os mesmos campos, uma tabela. Caso contrário, prosa com leads em negrito.
- **Citação vs. paráfrase.** Cite quando a redação original é o ponto. Parafraseie quando só a ideia importa.
- **Bloco de código vs. código inline.** Multilinha, executável ou ilustrativo → bloco. Token único ou identificador → inline.

## Ritmo de escrita

Anexe ao arquivo do artigo conforme cada bloco for acordado. Releia o arquivo do disco antes de cada escrita — o usuário pode ter editado entre turnos. Nunca sobrescreva às cegas. Se o usuário quiser um parágrafo reescrito, edite aquele parágrafo específico no lugar; deixe o resto em paz.

## Fora de escopo

- Minerar novos fragmentos que não estão na pilha (a pilha é o input — se estiver incompleta, nomeie a lacuna e ou faça o usuário preencher ou corte a seção).
- Editar o arquivo de matéria-prima.
- Publicar, formatar para uma plataforma específica ou adicionar frontmatter que o usuário não pediu.

</supporting-info>
