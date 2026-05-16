---
name: git-guardrails
description: Configura um hook do Kiro para bloquear comandos git perigosos (push, reset --hard, clean -f, branch -D, etc.) antes que eles executem. Use quando o usuário quiser prevenir operações git destrutivas ou adicionar hooks de segurança para git.
---

# Setup Git Guardrails

Configura um hook `preToolUse` do Kiro que intercepta e bloqueia comandos git perigosos antes que o agente os execute.

## O Que É Bloqueado

- `git push` (todas as variantes incluindo `--force`)
- `git reset --hard`
- `git clean -f` / `git clean -fd`
- `git branch -D`
- `git checkout .` / `git restore .`

Quando bloqueado, o agente vê uma mensagem de stderr informando que ele não tem autoridade para acessar esses comandos, e a chamada da ferramenta de shell encerra com status 2.

## Passos

### 1. Pergunte sobre o escopo

Pergunte ao usuário: instalar **só para este projeto** (workspace `.kiro/hooks/`) ou **para todos os projetos** (global `~/.kiro/hooks/`)?

### 2. Copie o script do hook

O script empacotado está em: [scripts/block-dangerous-git.sh](scripts/block-dangerous-git.sh)

Copie-o para o local de destino conforme o escopo:

- **Projeto**: `.kiro/hooks/scripts/block-dangerous-git.sh`
- **Global**: `~/.kiro/hooks/scripts/block-dangerous-git.sh`

Torne-o executável com `chmod +x`.

### 3. Adicione o arquivo do hook

Hooks do Kiro vivem como arquivos JSON individuais com extensão `.kiro.hook` em `.kiro/hooks/` (workspace) ou `~/.kiro/hooks/` (global). Crie um arquivo por hook.

Um exemplo funcional já vem com este repo em [`.kiro/hooks/git-guardrails.kiro.hook`](../../../.kiro/hooks/git-guardrails.kiro.hook). Copie-o para o local de destino e ajuste o caminho do script se você tiver instalado globalmente.

**Projeto** (`.kiro/hooks/git-guardrails.kiro.hook`):

```json
{
  "version": "1.0.0",
  "enabled": true,
  "name": "git-guardrails",
  "description": "Block destructive git operations (push, reset --hard, clean -f, branch -D, checkout ., restore .) before they execute.",
  "when": {
    "type": "preToolUse",
    "toolTypes": ["shell"]
  },
  "then": {
    "type": "runCommand",
    "command": "bash .kiro/hooks/scripts/block-dangerous-git.sh",
    "timeout": 10
  }
}
```

**Global** (`~/.kiro/hooks/git-guardrails.kiro.hook`): mesmo JSON, mas mude `then.command` para `bash ~/.kiro/hooks/scripts/block-dangerous-git.sh`.

Cada arquivo de hook é independente — coloque-o ao lado de qualquer outro arquivo `.kiro.hook`. Não junte hooks num único arquivo.

### 4. Pergunte sobre customização

Pergunte se o usuário quer adicionar ou remover algum padrão da lista de bloqueados. Edite o array `DANGEROUS_PATTERNS` diretamente no `block-dangerous-git.sh` que foi copiado.

### 5. Verifique

Rode um teste rápido:

```bash
bash .kiro/hooks/scripts/block-dangerous-git.sh <<< '{"tool_input":{"command":"git push origin main"}}'
echo $?
```

Deve imprimir uma mensagem BLOCKED no stderr e encerrar com código 2.
