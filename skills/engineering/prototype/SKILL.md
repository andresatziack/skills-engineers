---
name: prototype
description: Construa um protótipo descartável para amadurecer um design antes de se comprometer com ele. Roteia entre dois ramos — um app de terminal executável para perguntas de estado/lógica de negócio, ou várias variações radicalmente diferentes de UI alternáveis a partir de uma única rota. Use quando o usuário quer prototipar, sanity-checar um modelo de dados ou state machine, mockar uma UI, explorar opções de design, ou diz "prototype this", "let me play with it", "try a few designs".
---

# Prototype

Um protótipo é **código descartável que responde a uma pergunta**. A pergunta decide a forma.

## Escolha um ramo

Identifique qual pergunta está sendo respondida — a partir do prompt do usuário, do código ao redor, ou perguntando se o usuário estiver disponível:

- **"Esta lógica / modelo de estado parece certa?"** → [LOGIC.md](LOGIC.md). Construa um pequeno app interativo de terminal que empurra a state machine por casos difíceis de raciocinar no papel.
- **"Como isso deveria parecer?"** → [UI.md](UI.md). Gere várias variações radicalmente diferentes de UI numa única rota, alternáveis via um search param de URL e uma barra inferior flutuante.

Os dois ramos produzem artefatos muito diferentes — errar isso desperdiça o protótipo inteiro. Se a pergunta é genuinamente ambígua e o usuário não está alcançável, default para o ramo que combina melhor com o código ao redor (um módulo de backend → lógica; uma página ou componente → UI) e declare a suposição no topo do protótipo.

## Regras que se aplicam aos dois

1. **Descartável desde o dia um, e claramente marcado como tal.** Localize o código do protótipo perto de onde ele de fato vai ser usado (próximo do módulo ou página para a qual está prototipando) para que o contexto seja óbvio — mas dê um nome que deixe claro a um leitor casual que é um protótipo, não produção. Para rotas de UI descartáveis, obedeça a convenção de roteamento que o projeto já usa; não invente uma nova estrutura de top-level.
2. **Um comando para rodar.** Seja lá o que o task runner existente do projeto suportar — `pnpm <name>`, `python <path>`, `bun <path>`, etc. O usuário precisa conseguir iniciar sem pensar.
3. **Sem persistência por default.** Estado vive em memória. Persistência é a coisa que o protótipo está _checando_, não algo de que ele deveria depender. Se a pergunta envolve explicitamente um banco de dados, bata num DB de scratch ou num arquivo local com um nome claro de "PROTOTYPE — wipe me".
4. **Pule o polimento.** Sem testes, sem tratamento de erro além do que torna o protótipo _executável_, sem abstrações. O ponto é aprender algo rápido e depois deletar.
5. **Traga o estado à tona.** Depois de cada ação (lógica) ou em cada troca de variante (UI), imprima ou renderize o estado relevante completo para que o usuário possa ver o que mudou.
6. **Delete ou absorva quando terminar.** Quando o protótipo respondeu sua pergunta, ou delete-o ou dobre a decisão validada para dentro do código real — não deixe apodrecendo no repo.

## Quando terminar

A _resposta_ é a única coisa que vale a pena guardar de um protótipo. Capture-a em algum lugar durável (mensagem de commit, ADR, issue, ou um `NOTES.md` ao lado do protótipo) junto com a pergunta que ela respondia. Se o usuário está por perto, essa captura é uma conversa rápida; se não, deixe o placeholder para que ele (ou você, na próxima passada) possa preencher o veredito antes de deletar o protótipo.
