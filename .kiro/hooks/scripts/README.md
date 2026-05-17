# Scripts dos hooks Kiro

Este diretório espelha `skills/misc/git-guardrails/scripts/`. A cópia empacotada na skill é a **fonte canônica** — é ela que documenta o comportamento na própria skill, e quem se inscreve no hook lê o `SKILL.md` da skill como referência. A cópia aqui em `.kiro/hooks/scripts/` existe apenas porque o hook JSON em `.kiro/hooks/git-guardrails.kiro.hook` invoca um caminho relativo a partir da raiz do workspace.

## Convenção de sincronia

Sempre que você alterar um script (em particular o array `DANGEROUS_PATTERNS` em `block-dangerous-git.sh`), atualize **as duas cópias**. Confirme a equivalência byte-a-byte com:

```bash
diff -q .kiro/hooks/scripts/block-dangerous-git.sh skills/misc/git-guardrails/scripts/block-dangerous-git.sh
```

O comando deve sair com código 0 e sem output. Qualquer divergência é bug.

## Por que não um symlink

A versão anterior usava `.kiro/hooks/scripts/block-dangerous-git.sh` como symlink relativo apontando para a cópia da skill. A abordagem foi revertida porque:

- Em Windows sem developer-mode/admin, `git config core.symlinks` é `false` por default; o git materializa o blob do symlink como um arquivo de texto contendo o path-string, e o hook silenciosamente vira no-op.
- Em qualquer clone com `core.symlinks=false` (mesmo em Linux/macOS), o mesmo problema acontece.
- Para um guardrail de segurança, "duas cópias byte-idênticas que podem divergir se ninguém checar" é menos pior do que "uma cópia que silenciosamente desaparece em metade das plataformas". A convenção acima (mais o `diff -q` no checklist de revisão) torna a divergência detectável.

## Verificação do schema do hook

O JSON em `.kiro/hooks/git-guardrails.kiro.hook` (chaves `when.type: "preToolUse"`, `when.toolTypes: ["shell"]`, `then.type: "runCommand"`, `then.command`, `then.timeout`) foi confirmado contra duas fontes:

- A documentação pública do Kiro em [kiro.dev/docs/hooks/](https://kiro.dev/docs/hooks/) (descreve "Pre Tool Use", o campo "Tool name" e o comando a executar).
- Um hook real exportado pela IDE Kiro num repo público: [viatoro/ecc — `.kiro/hooks/git-push-review.kiro.hook`](https://github.com/viatoro/ecc/blob/main/.kiro/hooks/git-push-review.kiro.hook), que usa exatamente a mesma forma (`when.type: "preToolUse"`, `when.toolTypes: [...]`, `then.type: "runCommand"`).

JSON não permite comentários inline, então este registro de proveniência fica aqui em vez de no próprio `.kiro.hook`.
