---
name: ubiquitous-language
description: Extrai um glossário de linguagem ubíqua estilo DDD a partir da conversa atual, sinalizando ambiguidades e propondo termos canônicos. Salva em UBIQUITOUS_LANGUAGE.md. Use quando o usuário quiser definir termos de domínio, montar um glossário, endurecer terminologia, criar uma linguagem ubíqua ou mencionar "modelo de domínio" ou "DDD".
disable-model-invocation: true
---

# Ubiquitous Language

Extraia e formalize a terminologia de domínio da conversa atual num glossário consistente, salvo num arquivo local.

## Processo

1. **Escaneie a conversa** em busca de substantivos, verbos e conceitos relevantes ao domínio
2. **Identifique problemas**:
   - Mesma palavra usada para conceitos diferentes (ambiguidade)
   - Palavras diferentes usadas para o mesmo conceito (sinônimos)
   - Termos vagos ou sobrecarregados
3. **Proponha um glossário canônico** com escolhas opinativas de termos
4. **Escreva em `UBIQUITOUS_LANGUAGE.md`** no diretório de trabalho usando o formato abaixo
5. **Imprima um resumo** inline na conversa

## Formato de Saída

Escreva um arquivo `UBIQUITOUS_LANGUAGE.md` com esta estrutura:

```md
# Ubiquitous Language

## Order lifecycle

| Term        | Definition                                              | Aliases to avoid      |
| ----------- | ------------------------------------------------------- | --------------------- |
| **Order**   | A customer's request to purchase one or more items      | Purchase, transaction |
| **Invoice** | A request for payment sent to a customer after delivery | Bill, payment request |

## People

| Term         | Definition                                  | Aliases to avoid       |
| ------------ | ------------------------------------------- | ---------------------- |
| **Customer** | A person or organization that places orders | Client, buyer, account |
| **User**     | An authentication identity in the system    | Login, account         |

## Relationships

- An **Invoice** belongs to exactly one **Customer**
- An **Order** produces one or more **Invoices**

## Example dialogue

> **Dev:** "When a **Customer** places an **Order**, do we create the **Invoice** immediately?"
> **Domain expert:** "No — an **Invoice** is only generated once a **Fulfillment** is confirmed. A single **Order** can produce multiple **Invoices** if items ship in separate **Shipments**."
> **Dev:** "So if a **Shipment** is cancelled before dispatch, no **Invoice** exists for it?"
> **Domain expert:** "Exactly. The **Invoice** lifecycle is tied to the **Fulfillment**, not the **Order**."

## Flagged ambiguities

- "account" was used to mean both **Customer** and **User** — these are distinct concepts: a **Customer** places orders, while a **User** is an authentication identity that may or may not represent a **Customer**.
```

## Regras

- **Seja opinativo.** Quando existem várias palavras para o mesmo conceito, escolha a melhor e liste as outras como aliases a evitar.
- **Sinalize conflitos explicitamente.** Se um termo for usado de forma ambígua na conversa, chame atenção para ele na seção "Flagged ambiguities" com uma recomendação clara.
- **Inclua apenas termos relevantes para domain experts.** Pule nomes de módulos ou classes a menos que tenham significado na linguagem de domínio.
- **Mantenha definições apertadas.** No máximo uma frase. Defina o que ELE É, não o que faz.
- **Mostre relações.** Use nomes de termo em negrito e expresse cardinalidade onde óbvio.
- **Inclua apenas termos de domínio.** Pule conceitos genéricos de programação (array, função, endpoint) a menos que tenham significado específico de domínio.
- **Agrupe termos em múltiplas tabelas** quando clusters naturais emergirem (ex.: por subdomínio, ciclo de vida ou ator). Cada grupo recebe seu próprio heading e tabela. Se todos os termos pertencem a um único domínio coeso, uma tabela está ok — não force agrupamentos.
- **Escreva um diálogo de exemplo.** Uma conversa curta (3-5 trocas) entre uma pessoa dev e um domain expert que demonstre como os termos interagem naturalmente. O diálogo deve esclarecer fronteiras entre conceitos relacionados e mostrar termos sendo usados com precisão.

<example>

## Example dialogue

> **Dev:** "How do I test the **sync service** without Docker?"

> **Domain expert:** "Provide the **filesystem layer** instead of the **Docker layer**. It implements the same **Sandbox service** interface but uses a local directory as the **sandbox**."

> **Dev:** "So **sync-in** still creates a **bundle** and unpacks it?"

> **Domain expert:** "Exactly. The **sync service** doesn't know which layer it's talking to. It calls `exec` and `copyIn` — the **filesystem layer** just runs those as local shell commands."

</example>

## Re-execução

Quando invocada de novo na mesma conversa:

1. Leia o `UBIQUITOUS_LANGUAGE.md` existente
2. Incorpore quaisquer novos termos de discussão posterior
3. Atualize definições se a compreensão tiver evoluído
4. Re-sinalize quaisquer novas ambiguidades
5. Reescreva o diálogo de exemplo para incorporar novos termos
