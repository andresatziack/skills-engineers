---
name: obsidian-vault
description: Busca, cria e gerencia notas no vault do Obsidian com wikilinks e index notes. Use quando o usuário quiser encontrar, criar ou organizar notas no Obsidian.
---

# Obsidian Vault

## Localização do vault

`/mnt/d/Obsidian Vault/AI Research/`

Em sua maioria plano no nível raiz.

## Convenções de nomes

- **Index notes**: agregam tópicos relacionados (ex.: `Ralph Wiggum Index.md`, `Skills Index.md`, `RAG Index.md`)
- **Title case** para todos os nomes de notas
- Sem pastas para organização — use links e index notes em vez disso

## Linkagem

- Use a sintaxe `[[wikilinks]]` do Obsidian: `[[Note Title]]`
- Notas linkam para dependências/notas relacionadas no final
- Index notes são apenas listas de `[[wikilinks]]`

## Fluxos de trabalho

### Buscar notas

```bash
# Search by filename
find "/mnt/d/Obsidian Vault/AI Research/" -name "*.md" | grep -i "keyword"

# Search by content
grep -rl "keyword" "/mnt/d/Obsidian Vault/AI Research/" --include="*.md"
```

Ou use as ferramentas Grep/Glob diretamente no caminho do vault.

### Criar uma nova nota

1. Use **Title Case** para o nome do arquivo
2. Escreva o conteúdo como uma unidade de aprendizado (conforme as regras do vault)
3. Adicione `[[wikilinks]]` para notas relacionadas no final
4. Se for parte de uma sequência numerada, use o esquema hierárquico de numeração

### Encontrar notas relacionadas

Busque por `[[Note Title]]` em todo o vault para encontrar backlinks:

```bash
grep -rl "\\[\\[Note Title\\]\\]" "/mnt/d/Obsidian Vault/AI Research/"
```

### Encontrar index notes

```bash
find "/mnt/d/Obsidian Vault/AI Research/" -name "*Index*"
```
