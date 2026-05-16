---
name: request-refactor-plan
description: Cria um plano de refactor detalhado com commits minúsculos via entrevista com o usuário, depois o registra como uma issue no GitHub. Use quando o usuário quiser planejar um refactor, criar uma RFC de refactor ou quebrar um refactor em passos incrementais seguros.
---

Esta skill será invocada quando o usuário quiser criar um pedido de refactor. Você deve seguir os passos abaixo. Pode pular passos se considerar que não são necessários.

1. Peça ao usuário uma descrição longa e detalhada do problema que ele quer resolver e quaisquer ideias potenciais de soluções.

2. Explore o repo para verificar as afirmações dele e entender o estado atual da codebase.

3. Pergunte se ele considerou outras opções e apresente outras opções a ele.

4. Entreviste o usuário sobre a implementação. Seja extremamente detalhado e minucioso.

5. Cinzele o escopo exato da implementação. Defina o que você planeja mudar e o que planeja não mudar.

6. Olhe na codebase para checar a cobertura de testes desta área da codebase. Se a cobertura de testes for insuficiente, pergunte ao usuário quais são os planos dele para testes.

7. Quebre a implementação em um plano de commits minúsculos. Lembre do conselho do Martin Fowler: "make each refactoring step as small as possible, so that you can always see the program working."

8. Crie uma issue no GitHub com o plano de refactor. Use o template a seguir para a descrição da issue:

<refactor-plan-template>

## Problem Statement

The problem that the developer is facing, from the developer's perspective.

## Solution

The solution to the problem, from the developer's perspective.

## Commits

A LONG, detailed implementation plan. Write the plan in plain English, breaking down the implementation into the tiniest commits possible. Each commit should leave the codebase in a working state.

## Decision Document

A list of implementation decisions that were made. This can include:

- The modules that will be built/modified
- The interfaces of those modules that will be modified
- Technical clarifications from the developer
- Architectural decisions
- Schema changes
- API contracts
- Specific interactions

Do NOT include specific file paths or code snippets. They may end up being outdated very quickly.

## Testing Decisions

A list of testing decisions that were made. Include:

- A description of what makes a good test (only test external behavior, not implementation details)
- Which modules will be tested
- Prior art for the tests (i.e. similar types of tests in the codebase)

## Out of Scope

A description of the things that are out of scope for this refactor.

## Further Notes (optional)

Any further notes about the refactor.

</refactor-plan-template>
