---
name: setup-pre-commit
description: Configura hooks de pre-commit do Husky com lint-staged (Prettier), type checking e testes no repositório atual. Use quando o usuário quiser adicionar hooks de pre-commit, configurar Husky, configurar lint-staged ou adicionar formatação/typechecking/testes no momento do commit.
---

# Setup Pre-Commit Hooks

## O Que Isto Configura

- Hook de **pre-commit** do Husky
- **lint-staged** rodando Prettier em todos os arquivos staged
- Configuração do **Prettier** (se faltar)
- Scripts de **typecheck** e **test** no hook de pre-commit

## Passos

### 1. Detecte o gerenciador de pacotes

Procure por `package-lock.json` (npm), `pnpm-lock.yaml` (pnpm), `yarn.lock` (yarn), `bun.lockb` (bun). Use o que estiver presente. Por padrão use npm se não estiver claro.

### 2. Instale dependências

Instale como devDependencies:

```
husky lint-staged prettier
```

### 3. Inicialize o Husky

```bash
npx husky init
```

Isto cria o diretório `.husky/` e adiciona `prepare: "husky"` ao package.json.

### 4. Crie `.husky/pre-commit`

Escreva este arquivo (sem necessidade de shebang para Husky v9+):

```
npx lint-staged
npm run typecheck
npm run test
```

**Adapte**: substitua `npm` pelo gerenciador de pacotes detectado. Se o repo não tem script `typecheck` ou `test` no package.json, omita essas linhas e avise o usuário.

### 5. Crie `.lintstagedrc`

```json
{
  "*": "prettier --ignore-unknown --write"
}
```

### 6. Crie `.prettierrc` (se faltar)

Só crie se não existir uma configuração do Prettier. Use estes padrões:

```json
{
  "useTabs": false,
  "tabWidth": 2,
  "printWidth": 80,
  "singleQuote": false,
  "trailingComma": "es5",
  "semi": true,
  "arrowParens": "always"
}
```

### 7. Verifique

- [ ] `.husky/pre-commit` existe e é executável
- [ ] `.lintstagedrc` existe
- [ ] Script `prepare` no package.json é `"husky"`
- [ ] Configuração do `prettier` existe
- [ ] Rode `npx lint-staged` para verificar que funciona

### 8. Commit

Adicione todos os arquivos modificados/criados ao stage e faça commit com a mensagem: `Add pre-commit hooks (husky + lint-staged + prettier)`

Isso vai passar pelos novos hooks de pre-commit — um bom smoke test de que tudo funciona.

## Notas

- Husky v9+ não precisa de shebangs nos arquivos de hook
- `prettier --ignore-unknown` pula arquivos que o Prettier não consegue analisar (imagens, etc.)
- O pre-commit roda lint-staged primeiro (rápido, só staged), depois typecheck completo e testes
