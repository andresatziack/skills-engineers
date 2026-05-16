---
name: git-guardrails
description: Set up a Kiro hook to block dangerous git commands (push, reset --hard, clean -f, branch -D, etc.) before they execute. Use when the user wants to prevent destructive git operations or add git safety hooks.
---

# Setup Git Guardrails

Sets up a Kiro `preToolUse` hook that intercepts and blocks dangerous git commands before the agent executes them.

## What Gets Blocked

- `git push` (all variants including `--force`)
- `git reset --hard`
- `git clean -f` / `git clean -fd`
- `git branch -D`
- `git checkout .` / `git restore .`

When blocked, the agent sees a stderr message telling it that it does not have authority to access these commands, and the shell tool call exits with status 2.

## Steps

### 1. Ask scope

Ask the user: install for **this project only** (workspace `.kiro/hooks/`) or **all projects** (global `~/.kiro/hooks/`)?

### 2. Copy the hook script

The bundled script is at: [scripts/block-dangerous-git.sh](scripts/block-dangerous-git.sh)

Copy it to the target location based on scope:

- **Project**: `.kiro/hooks/scripts/block-dangerous-git.sh`
- **Global**: `~/.kiro/hooks/scripts/block-dangerous-git.sh`

Make it executable with `chmod +x`.

### 3. Add the hook file

Kiro hooks live as individual JSON files with a `.kiro.hook` extension under `.kiro/hooks/` (workspace) or `~/.kiro/hooks/` (global). Create one file per hook.

A working example is shipped with this repo at [`.kiro/hooks/git-guardrails.kiro.hook`](../../../.kiro/hooks/git-guardrails.kiro.hook). Copy it to the target location and adjust the script path if you installed globally.

**Project** (`.kiro/hooks/git-guardrails.kiro.hook`):

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

**Global** (`~/.kiro/hooks/git-guardrails.kiro.hook`): same JSON, but change `then.command` to `bash ~/.kiro/hooks/scripts/block-dangerous-git.sh`.

Each hook file is independent — drop it next to any other `.kiro.hook` files. Don't merge hooks into a single file.

### 4. Ask about customization

Ask if the user wants to add or remove any patterns from the blocked list. Edit the `DANGEROUS_PATTERNS` array directly in the copied `block-dangerous-git.sh`.

### 5. Verify

Run a quick test:

```bash
bash .kiro/hooks/scripts/block-dangerous-git.sh <<< '{"tool_input":{"command":"git push origin main"}}'
echo $?
```

Should print a BLOCKED message to stderr and exit with code 2.
