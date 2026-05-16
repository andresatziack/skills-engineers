---
name: improve-codebase-architecture
description: Encontra oportunidades de aprofundamento numa codebase, informada pela linguagem de domínio em CONTEXT.md e pelas decisões em docs/adr/. Use quando o usuário quer melhorar arquitetura, encontrar oportunidades de refactor, consolidar módulos fortemente acoplados, ou tornar uma codebase mais testável e navegável por IA.
---

# Improve Codebase Architecture

Traga à tona fricção arquitetural e proponha **oportunidades de aprofundamento** — refactors que transformam módulos rasos em profundos. O objetivo é testabilidade e navegabilidade por IA.

## Glossário

Use estes termos exatamente em cada sugestão. Linguagem consistente é o ponto — não derive para "component", "service", "API" ou "boundary". Definições completas em [LANGUAGE.md](LANGUAGE.md).

- **Module** — qualquer coisa com uma interface e uma implementação (função, classe, package, fatia).
- **Interface** — tudo que um chamador precisa saber para usar o módulo: tipos, invariantes, modos de erro, ordenação, configuração. Não apenas a assinatura de tipo.
- **Implementation** — o código por dentro.
- **Depth** — alavancagem na interface: muito comportamento por trás de uma interface pequena. **Deep** = alta alavancagem. **Shallow** = interface quase tão complexa quanto a implementação.
- **Seam** — onde uma interface vive; um lugar em que comportamento pode ser alterado sem editar in-place. (Use isto, não "boundary".)
- **Adapter** — uma coisa concreta que satisfaz uma interface num seam.
- **Leverage** — o que os chamadores ganham com profundidade.
- **Locality** — o que mantenedores ganham com profundidade: mudança, bugs e conhecimento concentrados num só lugar.

Princípios-chave (veja [LANGUAGE.md](LANGUAGE.md) para a lista completa):

- **Teste de deleção**: imagine deletar o módulo. Se a complexidade some, era um pass-through. Se a complexidade reaparece em N chamadores, ele estava ganhando seu sustento.
- **A interface é a superfície de teste.**
- **Um adapter = seam hipotético. Dois adapters = seam real.**

Esta skill é _informada_ pelo modelo de domínio do projeto. A linguagem de domínio dá nomes a bons seams; ADRs registram decisões que a skill não deve re-litigar.

## Processo

### 1. Explore

Leia primeiro o glossário de domínio do projeto e quaisquer ADRs na área que você está mexendo.

Depois use a Agent tool com `subagent_type=Explore` para caminhar pela codebase. Não siga heurísticas rígidas — explore organicamente e anote onde você sente fricção:

- Onde entender um conceito exige pular entre muitos módulos pequenos?
- Onde os módulos são **shallow** — interface quase tão complexa quanto a implementação?
- Onde funções puras foram extraídas só por testabilidade, mas os bugs reais se escondem em como elas são chamadas (sem **locality**)?
- Onde módulos fortemente acoplados vazam pelos seus seams?
- Quais partes da codebase estão sem testes, ou são difíceis de testar pela sua interface atual?

Aplique o **teste de deleção** a qualquer coisa que você suspeite ser shallow: deletá-lo concentraria a complexidade ou só a moveria? Um "sim, concentra" é o sinal que você quer.

### 2. Apresente candidatos

Apresente uma lista numerada de oportunidades de aprofundamento. Para cada candidato:

- **Files** — quais arquivos/módulos estão envolvidos
- **Problem** — por que a arquitetura atual está causando fricção
- **Solution** — descrição em prosa do que mudaria
- **Benefits** — explicado em termos de locality e leverage, e também em como os testes melhorariam

**Use o vocabulário de CONTEXT.md para o domínio, e o vocabulário de [LANGUAGE.md](LANGUAGE.md) para a arquitetura.** Se `CONTEXT.md` define "Order", fale sobre "o módulo de intake de Order" — não "o FooBarHandler", e não "o Order service".

**Conflitos com ADR**: se um candidato contradiz um ADR existente, só traga à tona quando a fricção é real o bastante para justificar revisitar o ADR. Marque claramente (ex.: _"contradiz ADR-0007 — mas vale reabrir porque…"_). Não liste cada refactor teórico que um ADR proíbe.

NÃO proponha interfaces ainda. Pergunte ao usuário: "Qual destes você gostaria de explorar?"

### 3. Loop de grilling

Uma vez que o usuário escolhe um candidato, caia em uma conversa de grilling. Caminhe pela árvore de design com ele — restrições, dependências, a forma do módulo aprofundado, o que fica atrás do seam, quais testes sobrevivem.

Efeitos colaterais acontecem no caminho, conforme as decisões cristalizam:

- **Nomeando um módulo aprofundado a partir de um conceito que não está em `CONTEXT.md`?** Adicione o termo a `CONTEXT.md` — mesma disciplina que `/grill-with-docs` (veja [CONTEXT-FORMAT.md](../grill-with-docs/CONTEXT-FORMAT.md)). Crie o arquivo preguiçosamente se ele não existir.
- **Afiando um termo nebuloso durante a conversa?** Atualize `CONTEXT.md` ali mesmo.
- **Usuário rejeita o candidato com uma razão estrutural?** Ofereça um ADR, enquadrado como: _"Quer que eu registre isto como um ADR para que revisões de arquitetura futuras não re-sugiram?"_ Só ofereça quando a razão realmente seria necessária para um futuro explorador evitar re-sugerir a mesma coisa — pule razões efêmeras ("não vale agora") e auto-evidentes. Veja [ADR-FORMAT.md](../grill-with-docs/ADR-FORMAT.md).
- **Quer explorar interfaces alternativas para o módulo aprofundado?** Veja [INTERFACE-DESIGN.md](INTERFACE-DESIGN.md).
