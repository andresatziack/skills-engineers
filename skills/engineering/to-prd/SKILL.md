---
name: to-prd
description: Transforma o contexto da conversa atual em um PRD e o publica no issue tracker do projeto. Use quando o usuário quer criar um PRD a partir do contexto atual.
---

Esta skill pega o contexto da conversa atual e o entendimento da codebase e produz um PRD. NÃO entreviste o usuário — só sintetize o que você já sabe.

O issue tracker e o vocabulário de labels de triagem deveriam ter sido fornecidos a você — rode `/setup-matt-pocock-skills` se não.

## Processo

1. Explore o repo para entender o estado atual da codebase, se ainda não fez isso. Use o vocabulário do glossário de domínio do projeto ao longo do PRD, e respeite quaisquer ADRs na área que você está mexendo.

2. Esboce os principais módulos que você vai precisar construir ou modificar para completar a implementação. Procure ativamente por oportunidades de extrair módulos profundos que possam ser testados em isolamento.

Um módulo profundo (em oposição a um módulo raso) é aquele que encapsula muita funcionalidade numa interface simples e testável que raramente muda.

Cheque com o usuário se esses módulos combinam com as expectativas dele. Cheque com o usuário para quais módulos ele quer testes escritos.

3. Escreva o PRD usando o template abaixo, depois publique-o no issue tracker do projeto. Aplique a label de triagem `ready-for-agent` — sem necessidade de triagem adicional.

<prd-template>

## Problem Statement

O problema que o usuário está enfrentando, da perspectiva do usuário.

## Solution

A solução para o problema, da perspectiva do usuário.

## User Stories

Uma lista LONGA e numerada de user stories. Cada user story deve estar no formato:

1. As an <actor>, I want a <feature>, so that <benefit>

<user-story-example>
1. As a mobile bank customer, I want to see balance on my accounts, so that I can make better informed decisions about my spending
</user-story-example>

Esta lista de user stories deve ser extremamente extensa e cobrir todos os aspectos da feature.

## Implementation Decisions

Uma lista de decisões de implementação que foram tomadas. Isso pode incluir:

- Os módulos que vão ser construídos/modificados
- As interfaces desses módulos que vão ser modificadas
- Esclarecimentos técnicos da pessoa dev
- Decisões arquiteturais
- Mudanças de schema
- Contratos de API
- Interações específicas

NÃO inclua paths específicos de arquivo ou snippets de código. Eles podem acabar ficando desatualizados muito rapidamente.

Exceção: se um protótipo produziu um snippet que codifica uma decisão de forma mais precisa do que a prosa pode (state machine, reducer, schema, formato de tipo), inclua-o dentro da decisão relevante e anote brevemente que veio de um protótipo. Apare para as partes ricas em decisão — não uma demo funcional, só os pedaços importantes.

## Testing Decisions

Uma lista de decisões de teste que foram tomadas. Inclua:

- Uma descrição do que faz um bom teste (testar apenas comportamento externo, não detalhes de implementação)
- Quais módulos vão ser testados
- Prior art para os testes (ou seja, tipos similares de testes na codebase)

## Out of Scope

Uma descrição das coisas que estão fora do escopo deste PRD.

## Further Notes

Quaisquer notas adicionais sobre a feature.

</prd-template>
