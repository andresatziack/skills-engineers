# Formato do CONTEXT.md

## Estrutura

```md
# {Nome do Contexto}

{Descrição de uma ou duas frases do que este contexto é e por que existe.}

## Language

**Order**:
{Uma descrição concisa do termo}
_Avoid_: Purchase, transaction

**Invoice**:
A request for payment sent to a customer after delivery.
_Avoid_: Bill, payment request

**Customer**:
A person or organization that places orders.
_Avoid_: Client, buyer, account

## Relationships

- An **Order** produces one or more **Invoices**
- An **Invoice** belongs to exactly one **Customer**

## Example dialogue

> **Dev:** "When a **Customer** places an **Order**, do we create the **Invoice** immediately?"
> **Domain expert:** "No — an **Invoice** is only generated once a **Fulfillment** is confirmed."

## Flagged ambiguities

- "account" was used to mean both **Customer** and **User** — resolved: these are distinct concepts.
```

## Regras

- **Seja opinativo.** Quando múltiplas palavras existem para o mesmo conceito, escolha a melhor e liste as outras como aliases a evitar.
- **Sinalize conflitos explicitamente.** Se um termo é usado de forma ambígua, traga isso à tona em "Flagged ambiguities" com uma resolução clara.
- **Mantenha as definições apertadas.** Uma frase no máximo. Defina o que ELE É, não o que ele faz.
- **Mostre relações.** Use nomes de termos em negrito e expresse cardinalidade onde for óbvio.
- **Inclua apenas termos específicos do contexto deste projeto.** Conceitos gerais de programação (timeouts, tipos de erro, padrões utilitários) não pertencem mesmo que o projeto os use extensivamente. Antes de adicionar um termo, pergunte: este é um conceito único deste contexto, ou um conceito geral de programação? Apenas o primeiro pertence.
- **Agrupe termos sob subtítulos** quando clusters naturais emergem. Se todos os termos pertencem a uma única área coesa, uma lista plana está bem.
- **Escreva um diálogo de exemplo.** Uma conversa entre uma pessoa dev e um domain expert que demonstra como os termos interagem naturalmente e clareia fronteiras entre conceitos relacionados.

## Repos de contexto único vs múltiplo

**Contexto único (a maioria dos repos):** Um `CONTEXT.md` na raiz do repo.

**Múltiplos contextos:** Um `CONTEXT-MAP.md` na raiz do repo lista os contextos, onde vivem e como se relacionam:

```md
# Context Map

## Contexts

- [Ordering](./src/ordering/CONTEXT.md) — receives and tracks customer orders
- [Billing](./src/billing/CONTEXT.md) — generates invoices and processes payments
- [Fulfillment](./src/fulfillment/CONTEXT.md) — manages warehouse picking and shipping

## Relationships

- **Ordering → Fulfillment**: Ordering emits `OrderPlaced` events; Fulfillment consumes them to start picking
- **Fulfillment → Billing**: Fulfillment emits `ShipmentDispatched` events; Billing consumes them to generate invoices
- **Ordering ↔ Billing**: Shared types for `CustomerId` and `Money`
```

A skill infere qual estrutura se aplica:

- Se `CONTEXT-MAP.md` existe, leia-o para encontrar contextos
- Se apenas um `CONTEXT.md` raiz existe, contexto único
- Se nenhum existe, crie um `CONTEXT.md` raiz preguiçosamente quando o primeiro termo for resolvido

Quando múltiplos contextos existem, infira a qual deles o tópico atual se relaciona. Se não estiver claro, pergunte.
