---
name: scaffold-exercises
description: Cria estruturas de diretórios de exercícios com seções, problemas, soluções e explainers que passam no linting. Use quando o usuário quiser fazer scaffold de exercícios, criar stubs de exercícios ou montar uma nova seção de curso.
---

# Scaffold Exercises

Cria estruturas de diretórios de exercícios que passam em `pnpm ai-hero-cli internal lint` e depois faz o commit com `git commit`.

## Convenção de nomes de diretório

- **Seções**: `XX-section-name/` dentro de `exercises/` (ex.: `01-retrieval-skill-building`)
- **Exercícios**: `XX.YY-exercise-name/` dentro de uma seção (ex.: `01.03-retrieval-with-bm25`)
- Número da seção = `XX`, número do exercício = `XX.YY`
- Nomes em dash-case (minúsculas, hifens)

## Variantes de exercício

Cada exercício precisa de pelo menos uma destas subpastas:

- `problem/` - workspace do aluno com TODOs
- `solution/` - implementação de referência
- `explainer/` - material conceitual, sem TODOs

Ao fazer stub, use `explainer/` como padrão a menos que o plano especifique outra coisa.

## Arquivos obrigatórios

Cada subpasta (`problem/`, `solution/`, `explainer/`) precisa de um `readme.md` que:

- **Não esteja vazio** (precisa ter conteúdo real, mesmo uma única linha de título funciona)
- Não tenha links quebrados

Ao fazer stub, crie um readme mínimo com um título e uma descrição:

```md
# Exercise Title

Description here
```

Se a subpasta tiver código, ela também precisa de um `main.ts` (>1 linha). Mas para stubs, um exercício só com readme está ok.

## Fluxo de trabalho

1. **Faça o parse do plano** - extraia nomes de seções, nomes de exercícios e tipos de variante
2. **Crie diretórios** - `mkdir -p` para cada caminho
3. **Crie readmes de stub** - um `readme.md` por pasta de variante com um título
4. **Rode o lint** - `pnpm ai-hero-cli internal lint` para validar
5. **Corrija qualquer erro** - itere até o lint passar

## Resumo das regras de lint

O linter (`pnpm ai-hero-cli internal lint`) verifica:

- Cada exercício tem subpastas (`problem/`, `solution/`, `explainer/`)
- Pelo menos uma de `problem/`, `explainer/` ou `explainer.1/` existe
- `readme.md` existe e é não-vazio na subpasta primária
- Sem arquivos `.gitkeep`
- Sem arquivos `speaker-notes.md`
- Sem links quebrados nos readmes
- Sem comandos `pnpm run exercise` nos readmes
- `main.ts` obrigatório por subpasta a menos que seja só readme

## Movendo/renomeando exercícios

Ao renumerar ou mover exercícios:

1. Use `git mv` (não `mv`) para renomear diretórios - preserva o histórico do git
2. Atualize o prefixo numérico para manter a ordem
3. Re-rode o lint depois das movimentações

Exemplo:

```bash
git mv exercises/01-retrieval/01.03-embeddings exercises/01-retrieval/01.04-embeddings
```

## Exemplo: stub a partir de um plano

Dado um plano como:

```
Section 05: Memory Skill Building
- 05.01 Introduction to Memory
- 05.02 Short-term Memory (explainer + problem + solution)
- 05.03 Long-term Memory
```

Crie:

```bash
mkdir -p exercises/05-memory-skill-building/05.01-introduction-to-memory/explainer
mkdir -p exercises/05-memory-skill-building/05.02-short-term-memory/{explainer,problem,solution}
mkdir -p exercises/05-memory-skill-building/05.03-long-term-memory/explainer
```

Depois crie os stubs de readme:

```
exercises/05-memory-skill-building/05.01-introduction-to-memory/explainer/readme.md -> "# Introduction to Memory"
exercises/05-memory-skill-building/05.02-short-term-memory/explainer/readme.md -> "# Short-term Memory"
exercises/05-memory-skill-building/05.02-short-term-memory/problem/readme.md -> "# Short-term Memory"
exercises/05-memory-skill-building/05.02-short-term-memory/solution/readme.md -> "# Short-term Memory"
exercises/05-memory-skill-building/05.03-long-term-memory/explainer/readme.md -> "# Long-term Memory"
```
