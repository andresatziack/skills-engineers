---
name: tdd
description: Desenvolvimento orientado a testes com loop red-green-refactor. Use quando o usuário quer construir features ou corrigir bugs usando TDD, menciona "red-green-refactor", quer integration tests, ou pede desenvolvimento test-first.
---

# Test-Driven Development

## Filosofia

**Princípio central**: Testes devem verificar comportamento por interfaces públicas, não por detalhes de implementação. Código pode mudar inteiramente; testes não deveriam.

**Bons testes** são integration-style: exercitam code paths reais por APIs públicas. Descrevem _o que_ o sistema faz, não _como_ ele faz. Um bom teste se lê como uma especificação — "user can checkout with valid cart" diz exatamente qual capacidade existe. Esses testes sobrevivem a refactors porque não se importam com estrutura interna.

**Testes ruins** são acoplados à implementação. Eles mockam colaboradores internos, testam métodos privados ou verificam por meios externos (como consultar um banco diretamente em vez de usar a interface). O sinal de alerta: seu teste quebra quando você refatora, mas o comportamento não mudou. Se você renomeia uma função interna e os testes falham, esses testes estavam testando implementação, não comportamento.

Veja [tests.md](tests.md) para exemplos e [mocking.md](mocking.md) para diretrizes de mocking.

## Anti-Padrão: Fatias Horizontais

**NÃO escreva todos os testes primeiro, depois toda a implementação.** Isso é "fatia horizontal" — tratar RED como "escreva todos os testes" e GREEN como "escreva todo o código".

Isso produz **testes ruins**:

- Testes escritos em massa testam comportamento _imaginado_, não _real_
- Você acaba testando a _forma_ das coisas (estruturas de dados, assinaturas de função) em vez de comportamento voltado ao usuário
- Testes ficam insensíveis a mudanças reais — passam quando o comportamento quebra, falham quando o comportamento está certo
- Você ultrapassa seus faróis, comprometendo-se com estrutura de teste antes de entender a implementação

**Abordagem correta**: Fatias verticais via tracer bullets. Um teste → uma implementação → repita. Cada teste responde ao que você aprendeu do ciclo anterior. Como você acabou de escrever o código, você sabe exatamente qual comportamento importa e como verificá-lo.

```
ERRADO (horizontal):
  RED:   test1, test2, test3, test4, test5
  GREEN: impl1, impl2, impl3, impl4, impl5

CERTO (vertical):
  RED→GREEN: test1→impl1
  RED→GREEN: test2→impl2
  RED→GREEN: test3→impl3
  ...
```

## Workflow

### 1. Planejamento

Ao explorar a codebase, use o glossário de domínio do projeto para que nomes de teste e vocabulário de interface combinem com a linguagem do projeto, e respeite ADRs na área que você está mexendo.

Antes de escrever qualquer código:

- [ ] Confirme com o usuário quais mudanças de interface são necessárias
- [ ] Confirme com o usuário quais comportamentos testar (priorize)
- [ ] Identifique oportunidades para [deep modules](deep-modules.md) (interface pequena, implementação profunda)
- [ ] Desenhe interfaces para [testabilidade](interface-design.md)
- [ ] Liste os comportamentos a testar (não passos de implementação)
- [ ] Obtenha aprovação do usuário no plano

Pergunte: "Como deveria ser a interface pública? Quais comportamentos são mais importantes para testar?"

**Você não pode testar tudo.** Confirme com o usuário exatamente quais comportamentos importam mais. Concentre o esforço de teste em caminhos críticos e lógica complexa, não em todo caso de borda possível.

### 2. Tracer Bullet

Escreva UM teste que confirma UMA coisa sobre o sistema:

```
RED:   Escreva teste para o primeiro comportamento → teste falha
GREEN: Escreva código mínimo para passar → teste passa
```

Esse é seu tracer bullet — prova que o caminho funciona end-to-end.

### 3. Loop Incremental

Para cada comportamento restante:

```
RED:   Escreva o próximo teste → falha
GREEN: Código mínimo para passar → passa
```

Regras:

- Um teste por vez
- Apenas código suficiente para passar o teste atual
- Não antecipe testes futuros
- Mantenha testes focados em comportamento observável

### 4. Refactor

Depois que todos os testes passarem, procure por [candidatos a refactor](refactoring.md):

- [ ] Extraia duplicação
- [ ] Aprofunde módulos (mova complexidade para trás de interfaces simples)
- [ ] Aplique princípios SOLID onde for natural
- [ ] Considere o que o código novo revela sobre o código existente
- [ ] Rode testes depois de cada passo de refactor

**Nunca refatore enquanto RED.** Chegue a GREEN primeiro.

## Checklist por Ciclo

```
[ ] Teste descreve comportamento, não implementação
[ ] Teste usa apenas a interface pública
[ ] Teste sobreviveria a um refactor interno
[ ] Código é mínimo para este teste
[ ] Nenhuma feature especulativa adicionada
```
