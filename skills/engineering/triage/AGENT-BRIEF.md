# Escrevendo Agent Briefs

Um agent brief é um comentário estruturado postado numa issue do GitHub quando ela move para `ready-for-agent`. É a especificação autoritativa a partir da qual um agente AFK vai trabalhar. O body original da issue e a discussão são contexto — o agent brief é o contrato.

## Princípios

### Durabilidade sobre precisão

A issue pode ficar em `ready-for-agent` por dias ou semanas. A codebase vai mudar nesse meio tempo. Escreva o brief de modo que ele continue útil mesmo enquanto arquivos são renomeados, movidos ou refatorados.

- **Faça** descreva interfaces, tipos e contratos comportamentais
- **Faça** nomeie tipos específicos, assinaturas de função ou formatos de config que o agente deveria procurar ou modificar
- **Não** referencie file paths — eles ficam desatualizados
- **Não** referencie números de linha
- **Não** assuma que a estrutura atual de implementação vai permanecer a mesma

### Comportamental, não procedural

Descreva **o quê** o sistema deveria fazer, não **como** implementar. O agente vai explorar a codebase fresco e tomar suas próprias decisões de implementação.

- **Bom:** "O tipo `SkillConfig` deveria aceitar um campo opcional `schedule` do tipo `CronExpression`"
- **Ruim:** "Abra src/types/skill.ts e adicione um campo schedule na linha 42"
- **Bom:** "Quando um usuário roda `/triage` sem argumentos, ele deveria ver um resumo de issues que precisam de atenção"
- **Ruim:** "Adicione um switch statement na função handler principal"

### Critérios de aceitação completos

O agente precisa saber quando está pronto. Cada agent brief precisa ter critérios de aceitação concretos e testáveis. Cada critério deve ser independentemente verificável.

- **Bom:** "Rodar `gh issue list --label needs-triage` retorna issues que passaram por classificação inicial"
- **Ruim:** "Triagem deveria funcionar corretamente"

### Limites de escopo explícitos

Declare o que está fora de escopo. Isso impede o agente de gold-platear ou fazer suposições sobre features adjacentes.

## Template

```markdown
## Agent Brief

**Category:** bug / enhancement
**Summary:** descrição de uma linha do que precisa acontecer

**Current behavior:**
Descreva o que acontece agora. Para bugs, é o comportamento quebrado.
Para enhancements, é o status quo sobre o qual a feature constrói.

**Desired behavior:**
Descreva o que deveria acontecer depois que o trabalho do agente está completo.
Seja específico sobre casos de borda e condições de erro.

**Key interfaces:**
- `TypeName` — o que precisa mudar e por quê
- `functionName()` return type — o que retorna agora vs o que deveria retornar
- Config shape — quaisquer novas opções de configuração necessárias

**Acceptance criteria:**
- [ ] Critério específico e testável 1
- [ ] Critério específico e testável 2
- [ ] Critério específico e testável 3

**Out of scope:**
- Coisa que NÃO deveria ser mudada ou endereçada nesta issue
- Feature adjacente que pode parecer relacionada mas é separada
```

## Exemplos

### Bom agent brief (bug)

```markdown
## Agent Brief

**Category:** bug
**Summary:** Truncamento de descrição de skill quebra no meio da palavra, produzindo saída quebrada

**Current behavior:**
Quando uma descrição de skill excede 1024 caracteres, ela é truncada em exatamente
1024 caracteres independentemente das fronteiras de palavra. Isso produz descrições
que terminam no meio da palavra (ex.: "Use when the user wants to confi").

**Desired behavior:**
Truncamento deveria quebrar na última fronteira de palavra antes de 1024 caracteres
e anexar "..." para indicar truncamento.

**Key interfaces:**
- O campo `description` do tipo `SkillMetadata` — sem mudança de tipo necessária,
  mas a lógica de validação/processamento que o popula precisa respeitar
  fronteiras de palavra
- Qualquer função que lê o frontmatter do SKILL.md e extrai a descrição

**Acceptance criteria:**
- [ ] Descrições abaixo de 1024 chars ficam inalteradas
- [ ] Descrições acima de 1024 chars são truncadas na última fronteira de palavra
      antes de 1024 chars
- [ ] Descrições truncadas terminam com "..."
- [ ] O comprimento total incluindo "..." não excede 1024 chars

**Out of scope:**
- Mudar o limite de 1024 chars em si
- Suporte a descrição multilinha
```

### Bom agent brief (enhancement)

```markdown
## Agent Brief

**Category:** enhancement
**Summary:** Adicionar suporte a diretório `.out-of-scope/` para rastrear pedidos de feature rejeitados

**Current behavior:**
Quando um pedido de feature é rejeitado, a issue é fechada com uma label `wontfix`
e um comentário. Não há registro persistente da decisão ou raciocínio.
Pedidos similares futuros exigem que o mantenedor lembre ou pesquise pela
discussão prévia.

**Desired behavior:**
Pedidos de feature rejeitados deveriam ser documentados em arquivos
`.out-of-scope/<concept>.md` que capturam a decisão, raciocínio e links para todas
as issues que pediram a feature. Ao triar novas issues, esses arquivos
deveriam ser checados em busca de matches.

**Key interfaces:**
- Formato de arquivo markdown em `.out-of-scope/` — cada arquivo deveria ter um
  cabeçalho `# Concept Name`, uma linha `**Decision:**`, uma linha `**Reason:**`,
  e uma lista `**Prior requests:**` com links de issue
- O fluxo de triagem deveria ler todos os arquivos `.out-of-scope/*.md` cedo
  e dar match em issues de entrada contra eles por similaridade de conceito

**Acceptance criteria:**
- [ ] Fechar uma feature como wontfix cria/atualiza um arquivo em `.out-of-scope/`
- [ ] O arquivo inclui a decisão, raciocínio e link para a issue fechada
- [ ] Se um arquivo `.out-of-scope/` correspondente já existe, a nova issue é
      anexada à sua lista "Prior requests" em vez de criar uma duplicata
- [ ] Durante a triagem, arquivos `.out-of-scope/` existentes são checados e trazidos à tona
      quando uma nova issue corresponde a uma rejeição prévia

**Out of scope:**
- Matching automatizado (humano confirma o match)
- Reabrir features previamente rejeitadas
- Bug reports (apenas rejeições de enhancement vão para `.out-of-scope/`)
```

### Agent brief ruim

```markdown
## Agent Brief

**Summary:** Conserta o bug de triagem

**What to do:**
A coisa de triagem está quebrada. Olhe o arquivo principal e conserte.
A função em volta da linha 150 tem o problema.

**Files to change:**
- src/triage/handler.ts (linha 150)
- src/types.ts (linha 42)
```

Isto é ruim porque:
- Sem categoria
- Descrição vaga ("a coisa de triagem está quebrada")
- Referencia file paths e números de linha que vão ficar desatualizados
- Sem critérios de aceitação
- Sem limites de escopo
- Sem descrição de comportamento atual vs desejado
