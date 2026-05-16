# Issue tracker: GitLab

Issues e PRDs deste repo vivem como issues do GitLab. Use o CLI [`glab`](https://gitlab.com/gitlab-org/cli) para todas as operações.

## Convenções

- **Criar uma issue**: `glab issue create --title "..." --description "..."`. Use um heredoc para descrições multilinha. Passe `--description -` para abrir um editor.
- **Ler uma issue**: `glab issue view <number> --comments`. Use `-F json` para saída legível por máquina.
- **Listar issues**: `glab issue list -F json` com filtros `--label` apropriados.
- **Comentar numa issue**: `glab issue note <number> --message "..."`. O GitLab chama comentários de "notes".
- **Aplicar / remover labels**: `glab issue update <number> --label "..."` / `--unlabel "..."`. Múltiplas labels podem ser separadas por vírgula ou repetir a flag.
- **Fechar**: `glab issue close <number>`. `glab issue close` não aceita um comentário de fechamento, então poste a explicação primeiro com `glab issue note <number> --message "..."`, depois feche.
- **Merge requests**: O GitLab chama PRs de "merge requests". Use `glab mr create`, `glab mr view`, `glab mr note`, etc. — a mesma forma de `gh pr ...` com `mr` no lugar de `pr` e `note`/`--message` no lugar de `comment`/`--body`.

Infira o repo a partir de `git remote -v` — `glab` faz isso automaticamente quando rodado dentro de um clone.

## Quando uma skill diz "publicar no issue tracker"

Crie uma issue no GitLab.

## Quando uma skill diz "buscar o ticket relevante"

Rode `glab issue view <number> --comments`.
