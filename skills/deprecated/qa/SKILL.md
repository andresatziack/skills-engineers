---
name: qa
description: Sessão de QA interativa em que o usuário reporta bugs ou problemas conversacionalmente, e o agente abre issues no GitHub. Explora a codebase em segundo plano para contexto e linguagem de domínio. Use quando o usuário quiser reportar bugs, fazer QA, abrir issues conversacionalmente ou mencionar "QA session".
---

# QA Session

Rode uma sessão de QA interativa. O usuário descreve problemas que está encontrando. Você esclarece, explora a codebase em busca de contexto e abre issues do GitHub que sejam duráveis, focadas no usuário e que usem a linguagem de domínio do projeto.

## Para cada issue que o usuário levanta

### 1. Escute e esclareça levemente

Deixe o usuário descrever o problema com as palavras dele. Faça **no máximo 2-3 perguntas curtas de esclarecimento** focadas em:

- O que ele esperava vs o que de fato aconteceu
- Passos para reproduzir (se não for óbvio)
- Se é consistente ou intermitente

NÃO superentreviste. Se a descrição estiver clara o suficiente para registrar, siga em frente.

### 2. Explore a codebase em segundo plano

Enquanto fala com o usuário, dispare um Agent (subagent_type=Explore) em segundo plano para entender a área relevante. O objetivo NÃO é encontrar uma correção — é:

- Aprender a linguagem de domínio usada naquela área (cheque UBIQUITOUS_LANGUAGE.md)
- Entender o que a feature deveria fazer
- Identificar a fronteira de comportamento voltada ao usuário

Esse contexto te ajuda a escrever uma issue melhor — mas a issue em si NÃO deve referenciar arquivos específicos, números de linha ou detalhes de implementação interna.

### 3. Avalie o escopo: issue única ou desmembramento?

Antes de registrar, decida se isto é uma **issue única** ou precisa ser **desmembrada** em múltiplas issues.

Desmembre quando:

- A correção atravessa múltiplas áreas independentes (ex.: "the form validation is wrong AND the success message is missing AND the redirect is broken")
- Há preocupações claramente separáveis em que pessoas diferentes poderiam trabalhar em paralelo
- O usuário descreve algo que tem múltiplos modos de falha distintos ou sintomas

Mantenha como issue única quando:

- É um comportamento que está errado em um lugar
- Os sintomas são todos causados pelo mesmo comportamento raiz

### 4. Registre a(s) issue(s) no GitHub

Crie issues com `gh issue create`. NÃO peça para o usuário revisar antes — apenas registre e compartilhe as URLs.

Issues precisam ser **duráveis** — devem continuar fazendo sentido depois de refactors grandes. Escreva da perspectiva do usuário.

#### Para uma issue única

Use este template:

```
## What happened

[Describe the actual behavior the user experienced, in plain language]

## What I expected

[Describe the expected behavior]

## Steps to reproduce

1. [Concrete, numbered steps a developer can follow]
2. [Use domain terms from the codebase, not internal module names]
3. [Include relevant inputs, flags, or configuration]

## Additional context

[Any extra observations from the user or from codebase exploration that help frame the issue — e.g. "this only happens when using the Docker layer, not the filesystem layer" — use domain language but don't cite files]
```

#### Para um desmembramento (múltiplas issues)

Crie as issues em ordem de dependência (bloqueadoras primeiro) para que você possa referenciar números de issue reais.

Use este template para cada sub-issue:

```
## Parent issue

#<parent-issue-number> (if you created a tracking issue) or "Reported during QA session"

## What's wrong

[Describe this specific behavior problem — just this slice, not the whole report]

## What I expected

[Expected behavior for this specific slice]

## Steps to reproduce

1. [Steps specific to THIS issue]

## Blocked by

- #<issue-number> (if this issue can't be fixed until another is resolved)

Or "None — can start immediately" if no blockers.

## Additional context

[Any extra observations relevant to this slice]
```

Ao criar um desmembramento:

- **Prefira muitas issues finas a poucas grossas** — cada uma deve ser independentemente corrigível e verificável
- **Marque relações de bloqueio honestamente** — se a issue B genuinamente não pode ser testada até A ser corrigida, diga isso. Se forem independentes, marque ambas como "None — can start immediately"
- **Crie as issues em ordem de dependência** para que você possa referenciar números de issue reais em "Blocked by"
- **Maximize o paralelismo** — o objetivo é que múltiplas pessoas (ou agentes) possam pegar issues diferentes simultaneamente

#### Regras para todos os corpos de issue

- **Sem caminhos de arquivo nem números de linha** — esses ficam desatualizados
- **Use a linguagem de domínio do projeto** (cheque UBIQUITOUS_LANGUAGE.md se existir)
- **Descreva comportamentos, não código** — "the sync service fails to apply the patch" não "applyPatch() throws on line 42"
- **Passos de reprodução são obrigatórios** — se você não conseguir determiná-los, pergunte ao usuário
- **Mantenha conciso** — uma pessoa dev deve conseguir ler a issue em 30 segundos

Depois de registrar, imprima todas as URLs das issues (com as relações de bloqueio resumidas) e pergunte: "Next issue, or are we done?"

### 5. Continue a sessão

Continue até o usuário dizer que terminou. Cada issue é independente — não as agrupe em batch.
