---
inclusion: manual
---

# Issue tracker: GitHub

Issues e PRDs deste repo vivem como issues do GitHub. Use o CLI `gh` para todas as operações.

## Convenções

- **Criar uma issue**: `gh issue create --title "..." --body "..."`. Use um heredoc para bodies multilinha.
- **Ler uma issue**: `gh issue view <number> --comments`, filtrando comentários por `jq` e também buscando labels.
- **Listar issues**: `gh issue list --state open --json number,title,body,labels,comments --jq '[.[] | {number, title, body, labels: [.labels[].name], comments: [.comments[].body]}]'` com filtros `--label` e `--state` apropriados.
- **Comentar numa issue**: `gh issue comment <number> --body "..."`
- **Aplicar / remover labels**: `gh issue edit <number> --add-label "..."` / `--remove-label "..."`
- **Fechar**: `gh issue close <number> --comment "..."`

Infira o repo a partir de `git remote -v` — `gh` faz isso automaticamente quando rodado dentro de um clone.

## Quando uma skill diz "publicar no issue tracker"

Crie uma issue no GitHub.

## Quando uma skill diz "buscar a issue relevante"

Rode `gh issue view <number> --comments`.
