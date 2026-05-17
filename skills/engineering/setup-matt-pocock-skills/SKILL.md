---
name: setup-matt-pocock-skills
description: Configura steering files do Kiro sob `.kiro/steering/` (um índice `agent-skills-config.md` mais `issue-tracker.md`, `triage-labels.md` e `domain.md`) para que as skills de engenharia conheçam o issue tracker deste repo (GitHub ou markdown local), o vocabulário de labels de triagem e o layout dos docs de domínio. Rode antes do primeiro uso de `to-issues`, `to-prd`, `triage`, `diagnose`, `tdd`, `improve-codebase-architecture` ou `zoom-out` — ou se essas skills parecem estar faltando contexto sobre o issue tracker, labels de triagem ou docs de domínio.
disable-model-invocation: true
---

# Setup Matt Pocock's Skills

Faça o scaffold da configuração por repositório que as skills de engenharia assumem:

- **Issue tracker** — onde issues vivem (GitHub por padrão; markdown local também é suportado out of the box)
- **Triage labels** — as strings usadas para os cinco papéis canônicos de triagem
- **Domain docs** — onde `CONTEXT.md` e ADRs vivem, e as regras de consumo para lê-los

Esta é uma skill dirigida por prompt, não um script determinístico. Explore, apresente o que encontrou, confirme com o usuário e depois escreva.

## Processo

### 1. Explore

Olhe o repo atual para entender seu estado inicial. Leia o que existir; não assuma:

- `git remote -v` e `.git/config` — este é um repo do GitHub? Qual deles?
- Procure por steering files existentes sob `.kiro/steering/` — especificamente `agent-skills-config.md`, ou qualquer arquivo contendo um bloco `## Agent skills`. Anote também se `.kiro/` em si existe.
- `CONTEXT.md` e `CONTEXT-MAP.md` na raiz do repo
- `docs/adr/` e quaisquer diretórios `src/*/docs/adr/`
- Olhe `.kiro/steering/` em busca de qualquer saída anterior desta skill (ex.: `issue-tracker.md`, `triage-labels.md`, `domain.md`).
- `.scratch/` — sinal de que uma convenção de issue tracker em markdown local já está em uso

### 2. Apresente os achados e pergunte

Resuma o que está presente e o que está faltando. Depois caminhe com o usuário pelas três decisões **uma de cada vez** — apresente uma seção, obtenha a resposta do usuário, então mova para a próxima. Não despeje as três de uma vez.

Assuma que o usuário não sabe o que esses termos significam. Cada seção começa com uma explicação curta (o que é, por que estas skills precisam dele, o que muda se ele escolher diferente). Depois mostre as opções e o default.

**Seção A — Issue tracker.**

> Explicação: O "issue tracker" é onde issues vivem para este repo. Skills como `to-issues`, `triage`, `to-prd` e `qa` lêem dele e escrevem nele — precisam saber se devem chamar `gh issue create`, escrever um arquivo markdown sob `.scratch/` ou seguir algum outro fluxo que você descreva. Escolha o lugar onde você de fato acompanha trabalho para este repo.

Postura default: estas skills foram desenhadas para o GitHub. Se um `git remote` aponta para o GitHub, proponha isso. Se um `git remote` aponta para o GitLab (`gitlab.com` ou um host self-hosted), proponha o GitLab. Caso contrário (ou se o usuário preferir), ofereça:

- **GitHub** — issues vivem no GitHub Issues do repo (usa o CLI `gh`)
- **GitLab** — issues vivem no GitLab Issues do repo (usa o CLI [`glab`](https://gitlab.com/gitlab-org/cli))
- **Markdown local** — issues vivem como arquivos sob `.scratch/<feature>/` neste repo (bom para projetos solo ou repos sem remote)
- **Outro** (Jira, Linear, etc.) — peça ao usuário para descrever o fluxo em um parágrafo; a skill vai gravar como prosa livre

**Seção B — Vocabulário de labels de triagem.**

> Explicação: Quando a skill `triage` processa uma issue de entrada, ela a move por uma máquina de estados — precisa de avaliação, esperando o reporter, pronto para um agente AFK pegar, pronto para um humano, ou wontfix. Para fazer isso, ela precisa aplicar labels (ou o equivalente no seu issue tracker) que combinem com strings *que você de fato configurou*. Se seu repo já usa nomes de labels diferentes (ex.: `bug:triage` em vez de `needs-triage`), mapeie-os aqui para que a skill aplique os corretos em vez de criar duplicatas.

Os cinco papéis canônicos:

- `needs-triage` — mantenedor precisa avaliar
- `needs-info` — esperando o reporter
- `ready-for-agent` — totalmente especificada, pronta para AFK (um agente pode pegar sem contexto humano)
- `ready-for-human` — precisa de implementação humana
- `wontfix` — não vai ser feito

Default: a string de cada papel é igual ao seu nome. Pergunte ao usuário se quer sobrescrever algum. Se o issue tracker dele não tem labels existentes, os defaults estão bem.

**Seção C — Domain docs.**

> Explicação: Algumas skills (`improve-codebase-architecture`, `diagnose`, `tdd`) lêem um arquivo `CONTEXT.md` para aprender a linguagem de domínio do projeto, e `docs/adr/` para decisões arquiteturais passadas. Elas precisam saber se o repo tem um contexto único global ou múltiplos (ex.: um monorepo com contextos separados de frontend/backend) para procurarem no lugar certo.

Confirme o layout:

- **Single-context** — um `CONTEXT.md` + `docs/adr/` na raiz do repo. A maioria dos repos é assim.
- **Multi-context** — `CONTEXT-MAP.md` na raiz apontando para arquivos `CONTEXT.md` por contexto (tipicamente um monorepo).

### 3. Confirme e edite

Mostre ao usuário um rascunho de:

- O steering file `agent-skills-config.md` (que o Kiro vai carregar em cada interação).
- Os conteúdos de `.kiro/steering/issue-tracker.md`, `.kiro/steering/triage-labels.md`, `.kiro/steering/domain.md`.

Deixe-os editar antes de escrever.

### 4. Escreva

Escreva quatro arquivos em `.kiro/steering/` (criando o diretório se ausente):

- `agent-skills-config.md` — o arquivo de índice com front-matter `inclusion: always`, contendo os três resumos de uma linha mostrados abaixo.
- `issue-tracker.md` — a partir do template seed correspondente (veja abaixo). O template já vem com `inclusion: manual` no topo; preserve esse front-matter ao copiar.
- `triage-labels.md` — a partir de [triage-labels.md](./triage-labels.md). O template já vem com `inclusion: manual`.
- `domain.md` — a partir de [domain.md](./domain.md). O template já vem com `inclusion: manual`.

Se `.kiro/steering/agent-skills-config.md` já existe, atualize-o no lugar (substituindo o bloco `## Agent skills`) em vez de sobrescrever o conteúdo ao redor. Não sobrescreva edições do usuário em outras seções desse arquivo.

O bloco:

```markdown
---
inclusion: always
---

## Agent skills

### Issue tracker

[resumo de uma linha de onde issues são acompanhadas]. Veja `.kiro/steering/issue-tracker.md`.

### Triage labels

[resumo de uma linha do vocabulário de labels]. Veja `.kiro/steering/triage-labels.md`.

### Domain docs

[resumo de uma linha do layout — "single-context" ou "multi-context"]. Veja `.kiro/steering/domain.md`.
```

Apenas `agent-skills-config.md` tem `inclusion: always`, sendo o único arquivo carregado em toda interação. Os três arquivos de detalhe (`issue-tracker.md`, `triage-labels.md`, `domain.md`) são escritos com `inclusion: manual` e são puxados sob demanda, ou pelo agente referenciando explicitamente (`#issue-tracker`, `#triage-labels`, `#domain`) ou pelo usuário invocá-los como comandos slash. O bloco `## Agent skills` acima já é contexto suficiente para sempre carregar; os detalhes ficam fora do contexto até serem solicitados.

Escolha o template seed correspondente para o issue tracker:

- [issue-tracker-github.md](./issue-tracker-github.md) — issue tracker do GitHub
- [issue-tracker-gitlab.md](./issue-tracker-gitlab.md) — issue tracker do GitLab
- [issue-tracker-local.md](./issue-tracker-local.md) — issue tracker em markdown local

Escreva seu conteúdo em `.kiro/steering/issue-tracker.md`. Para issue trackers "outros", escreva `.kiro/steering/issue-tracker.md` do zero usando a descrição do usuário.

### 5. Pronto

Diga ao usuário que o setup está completo e quais skills de engenharia agora vão ler desses arquivos. Mencione que ele pode editar `.kiro/steering/issue-tracker.md`, `.kiro/steering/triage-labels.md` ou `.kiro/steering/domain.md` diretamente depois — re-rodar esta skill só é necessário se quiser trocar de issue tracker ou recomeçar do zero.
