---
name: write-a-skill
description: Cria novas skills de agente com estrutura adequada, divulgação progressiva e recursos empacotados. Use quando o usuário quer criar, escrever ou construir uma nova skill.
---

# Writing Skills

## Processo

1. **Reúna requisitos** - pergunte ao usuário sobre:
   - Que tarefa/domínio a skill cobre?
   - Quais casos de uso específicos ela deveria tratar?
   - Ela precisa de scripts executáveis ou só instruções?
   - Algum material de referência para incluir?

2. **Rascunhe a skill** - crie:
   - SKILL.md com instruções concisas
   - Arquivos de referência adicionais se o conteúdo exceder 500 linhas
   - Scripts utilitários se operações determinísticas forem necessárias

3. **Revise com o usuário** - apresente o rascunho e pergunte:
   - Isto cobre seus casos de uso?
   - Algo faltando ou pouco claro?
   - Alguma seção deveria ser mais/menos detalhada?

## Estrutura da Skill

```
skill-name/
├── SKILL.md           # Instruções principais (obrigatório)
├── REFERENCE.md       # Docs detalhados (se necessário)
├── EXAMPLES.md        # Exemplos de uso (se necessário)
└── scripts/           # Scripts utilitários (se necessário)
    └── helper.js
```

## Template do SKILL.md

```md
---
name: skill-name
description: Brief description of capability. Use when [specific triggers].
---

# Skill Name

## Quick start

[Exemplo mínimo funcional]

## Workflows

[Processos passo a passo com checklists para tarefas complexas]

## Advanced features

[Link para arquivos separados: See [REFERENCE.md](REFERENCE.md)]
```

## Requisitos da Description

A description é **a única coisa que seu agente vê** ao decidir qual skill carregar. Ela aparece no system prompt junto com todas as outras skills instaladas. Seu agente lê essas descriptions e escolhe a skill relevante baseado no pedido do usuário.

**Objetivo**: Dê ao seu agente apenas info suficiente para saber:

1. Que capacidade esta skill provê
2. Quando/por que disparar (palavras-chave específicas, contextos, tipos de arquivo)

**Formato**:

- Máx 1024 chars
- Escreva em terceira pessoa
- Primeira frase: o que ela faz
- Segunda frase: "Use when [specific triggers]"

**Bom exemplo**:

```
Extract text and tables from PDF files, fill forms, merge documents. Use when working with PDF files or when user mentions PDFs, forms, or document extraction.
```

**Mau exemplo**:

```
Helps with documents.
```

O exemplo ruim não dá ao seu agente nenhuma forma de distinguir isto de outras skills de documento.

## Quando Adicionar Scripts

Adicione scripts utilitários quando:

- A operação é determinística (validação, formatação)
- O mesmo código seria gerado repetidamente
- Erros precisam de tratamento explícito

Scripts economizam tokens e melhoram confiabilidade vs código gerado.

## Quando Dividir Arquivos

Divida em arquivos separados quando:

- SKILL.md excede 100 linhas
- O conteúdo tem domínios distintos (schemas de finanças vs vendas)
- Features avançadas são raramente necessárias

## Checklist de Revisão

Depois de rascunhar, verifique:

- [ ] Description inclui triggers ("Use when...")
- [ ] SKILL.md abaixo de 100 linhas
- [ ] Sem info sensível ao tempo
- [ ] Terminologia consistente
- [ ] Exemplos concretos incluídos
- [ ] Referências a um nível de profundidade
