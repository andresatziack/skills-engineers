---
name: to-issues
description: Quebra um plano, spec ou PRD em issues independentemente pegáveis no issue tracker do projeto usando fatias verticais tracer-bullet. Use quando o usuário quer converter um plano em issues, criar issues de implementação ou quebrar trabalho em issues.
---

# To Issues

Quebre um plano em issues independentemente pegáveis usando fatias verticais (tracer bullets).

O issue tracker e o vocabulário de labels de triagem deveriam ter sido fornecidos a você — rode `/setup-matt-pocock-skills` se não.

## Processo

### 1. Reúna contexto

Trabalhe com o que já está no contexto da conversa. Se o usuário passar uma referência de issue (número, URL ou path) como argumento, busque do issue tracker e leia o body completo e os comentários.

### 2. Explore a codebase (opcional)

Se você ainda não explorou a codebase, faça isso para entender o estado atual do código. Títulos e descrições de issues devem usar o vocabulário do glossário de domínio do projeto, e respeitar ADRs na área que você está mexendo.

### 3. Rascunhe fatias verticais

Quebre o plano em issues **tracer bullet**. Cada issue é uma fatia vertical fina que corta TODAS as camadas de integração end-to-end, NÃO uma fatia horizontal de uma camada.

Fatias podem ser 'HITL' ou 'AFK'. Fatias HITL exigem interação humana, como uma decisão arquitetural ou uma revisão de design. Fatias AFK podem ser implementadas e mergeadas sem interação humana. Prefira AFK em vez de HITL onde possível.

<vertical-slice-rules>
- Cada fatia entrega um caminho estreito mas COMPLETO por cada camada (schema, API, UI, testes)
- Uma fatia completada é demoável ou verificável por si só
- Prefira muitas fatias finas em vez de poucas fatias grossas
</vertical-slice-rules>

### 4. Quizze o usuário

Apresente a quebra proposta como uma lista numerada. Para cada fatia, mostre:

- **Title**: nome curto descritivo
- **Type**: HITL / AFK
- **Blocked by**: quais outras fatias (se houver) precisam completar antes
- **User stories covered**: quais user stories isto endereça (se o material fonte tiver)

Pergunte ao usuário:

- A granularidade parece certa? (grossa demais / fina demais)
- As relações de dependência estão corretas?
- Alguma fatia deveria ser fundida ou quebrada mais?
- As fatias certas estão marcadas como HITL e AFK?

Itere até o usuário aprovar a quebra.

### 5. Publique as issues no issue tracker

Para cada fatia aprovada, publique uma nova issue no issue tracker. Use o template de body de issue abaixo. Estas issues são consideradas prontas para agentes AFK, então publique com a label de triagem correta a menos que instruído de outra forma.

Publique issues em ordem de dependência (bloqueadores primeiro) para que você possa referenciar identificadores reais de issue no campo "Blocked by".

<issue-template>
## Parent

Uma referência à issue pai no issue tracker (se a fonte foi uma issue existente, caso contrário omita esta seção).

## What to build

Uma descrição concisa desta fatia vertical. Descreva o comportamento end-to-end, não implementação camada-por-camada.

Evite paths específicos de arquivo ou snippets de código — eles ficam desatualizados rápido. Exceção: se um protótipo produziu um snippet que codifica uma decisão de forma mais precisa do que a prosa pode (state machine, reducer, schema, formato de tipo), inclua-o aqui e anote brevemente que veio de um protótipo. Apare para as partes ricas em decisão — não uma demo funcional, só os pedaços importantes.

## Acceptance criteria

- [ ] Critério 1
- [ ] Critério 2
- [ ] Critério 3

## Blocked by

- Uma referência ao ticket bloqueador (se houver)

Ou "None - can start immediately" se nenhum bloqueador.

</issue-template>

NÃO feche ou modifique nenhuma issue pai.
