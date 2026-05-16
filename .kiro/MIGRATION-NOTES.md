# Migração para Kiro

Este repositório foi originalmente construído como um plugin para outra IDE de agente. Este documento registra a migração para um projeto 100% nativo do Kiro: estrutura `.kiro/`, hooks e steering files. Toda a documentação foi traduzida para Português do Brasil.

## Arquivos criados

- `.kiro/README.md` — orientação rápida para a estrutura `.kiro/` deste repositório.
- `.kiro/steering/skill-organization.md` — convenções de organização das skills por bucket (`inclusion: always`).
- `.kiro/steering/skill-authoring-rules.md` — regras de autoria para qualquer `SKILL.md` (`inclusion: fileMatch` em `skills/**/SKILL.md`).
- `.kiro/steering/published-skills.md` — inventário canônico das skills publicadas (`inclusion: manual`).
- `.kiro/hooks/git-guardrails.kiro.hook` — hook de exemplo que bloqueia comandos git destrutivos (`when.type: preToolUse`, `then.type: runCommand`).
- `.kiro/hooks/scripts/block-dangerous-git.sh` — symlink para `skills/misc/git-guardrails/scripts/block-dangerous-git.sh` (a cópia empacotada na skill é canônica; o hook a invoca via path relativo a partir da raiz do workspace).
- `.kiro/settings/mcp.json` — configuração MCP do workspace (`{"mcpServers": {}}` por padrão).

## Arquivos modificados

- `README.md`, `CONTEXT.md` — descrições reescritas em termos nativos do Kiro e traduzidas para PT-BR.
- `scripts/link-skills.sh` — reescrito para aceitar destino configurável (default `$HOME/.local/share/skills-engineers`) e remover toda referência à IDE de origem.
- `skills/misc/README.md` — entrada da skill antiga substituída por `git-guardrails`.
- `skills/engineering/setup-matt-pocock-skills/SKILL.md` — fluxo reescrito para emitir arquivos em `.kiro/steering/` em vez dos antigos arquivos de instrução na raiz e em `docs/agents/`.
- `skills/engineering/setup-matt-pocock-skills/issue-tracker-local.md` — referência interna atualizada para `.kiro/steering/triage-labels.md`.
- `skills/in-progress/review/SKILL.md` — fontes de standards atualizadas para `.kiro/steering/*.md`.
- Todos os demais arquivos `.md` do repositório foram traduzidos para PT-BR (mantendo em inglês: paths, slugs, comandos CLI, blocos de código, URLs, nomes de produtos, citações de livros em inglês).

## Arquivos removidos

- O antigo arquivo de instruções gerais na raiz do repositório — conteúdo migrado para `.kiro/steering/skill-organization.md`.
- O diretório de manifesto de plugin da IDE de origem — substituído por `.kiro/steering/published-skills.md`.

## Pasta renomeada

- `skills/misc/git-guardrails-<antiga-ide>/` → `skills/misc/git-guardrails/` — o `SKILL.md` foi reescrito para ensinar como configurar o equivalente em Kiro (um `.kiro.hook` JSON com `when.type: preToolUse`).

## Mapeamento da IDE de origem para Kiro

| Conceito anterior | Equivalente Kiro |
| --- | --- |
| Arquivo de instruções gerais na raiz do repositório | `.kiro/steering/*.md` (vários arquivos temáticos com front-matter `inclusion`) |
| Manifesto de plugin (`plugin.json` em diretório dedicado) | `.kiro/steering/published-skills.md` (steering manual com a lista de skills publicadas) |
| Hooks `PreToolUse` no arquivo de settings da IDE anterior (matcher `Bash`) | Arquivos `.kiro/hooks/<name>.kiro.hook` com `when.type: "preToolUse"`, `when.toolTypes: ["shell"]`, `then.type: "runCommand"` |
| Configuração MCP no arquivo de settings da IDE anterior | `.kiro/settings/mcp.json` (chave `mcpServers`) |
| Variável de ambiente da IDE anterior que apontava para a raiz do projeto | Caminho relativo a partir da raiz do workspace dentro do JSON do hook |
| Diretório global de skills no `$HOME` da IDE anterior | Não há equivalente direto em Kiro. O script `scripts/link-skills.sh` foi reescrito para criar links em `$HOME/.local/share/skills-engineers/` por padrão; a partir daí o usuário copia ou cria symlink em `<workspace>/.kiro/steering/` (preferencialmente com `inclusion: manual`) para cada skill que quiser ativar. |
| Comandos slash (`/setup-matt-pocock-skills`, `/grill-me`, etc.) | A invocação por slash continua funcionando: o nome de cada skill (slug em kebab-case) é o gatilho. No Kiro, o conteúdo do `SKILL.md` é injetado via referência manual em chat (`#<slug>`) ou via steering files com `inclusion: manual` que aparecem como comandos `/`. |

## Conceitos sem equivalente direto

- **Manifesto de plugin**: Kiro descobre steering files por varredura do diretório `.kiro/steering/`, não por manifesto. A solução foi materializar o inventário como `.kiro/steering/published-skills.md` (com `inclusion: manual`), que dobra como documentação navegável.
- **Diretório global de skills no `$HOME` da IDE anterior**: Kiro tem `~/.kiro/steering/` para steering global, mas não há um diretório global para "pacotes de skills" arbitrários. A solução foi reescrever `scripts/link-skills.sh` para gerar links em `$HOME/.local/share/skills-engineers/` (sob controle do usuário), e documentar no próprio script como copiar ou symlinkar cada `SKILL.md` para `<workspace>/.kiro/steering/` quando quiser usá-lo.
- **Variável de ambiente que apontava para a raiz do projeto**: hooks Kiro rodam com a raiz do workspace como CWD, então caminhos relativos (`bash .kiro/hooks/scripts/block-dangerous-git.sh`) substituem a variável diretamente.
