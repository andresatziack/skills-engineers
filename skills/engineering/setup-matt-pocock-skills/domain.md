# Domain Docs

Como as skills de engenharia devem consumir a documentação de domínio deste repo ao explorar a codebase.

## Antes de explorar, leia estes

- **`CONTEXT.md`** na raiz do repo, ou
- **`CONTEXT-MAP.md`** na raiz do repo se existir — ele aponta para um `CONTEXT.md` por contexto. Leia cada um relevante ao tópico.
- **`docs/adr/`** — leia ADRs que toquem a área que você está prestes a trabalhar. Em repos multi-contexto, cheque também `src/<context>/docs/adr/` para decisões com escopo de contexto.

Se algum desses arquivos não existir, **prossiga em silêncio**. Não sinalize a ausência; não sugira criá-los upfront. A skill produtora (`/grill-with-docs`) os cria preguiçosamente quando termos ou decisões de fato são resolvidos.

## Estrutura de arquivos

Repo de contexto único (a maioria dos repos):

```
/
├── CONTEXT.md
├── docs/adr/
│   ├── 0001-event-sourced-orders.md
│   └── 0002-postgres-for-write-model.md
└── src/
```

Repo multi-contexto (presença de `CONTEXT-MAP.md` na raiz):

```
/
├── CONTEXT-MAP.md
├── docs/adr/                          ← decisões de todo o sistema
└── src/
    ├── ordering/
    │   ├── CONTEXT.md
    │   └── docs/adr/                  ← decisões específicas do contexto
    └── billing/
        ├── CONTEXT.md
        └── docs/adr/
```

## Use o vocabulário do glossário

Quando sua saída nomeia um conceito de domínio (num título de issue, numa proposta de refactor, numa hipótese, num nome de teste), use o termo como definido em `CONTEXT.md`. Não derive para sinônimos que o glossário explicitamente evita.

Se o conceito que você precisa ainda não está no glossário, isso é um sinal — ou você está inventando linguagem que o projeto não usa (reconsidere) ou há uma lacuna real (anote para `/grill-with-docs`).

## Sinalize conflitos com ADR

Se sua saída contradiz um ADR existente, traga à tona explicitamente em vez de sobrescrever em silêncio:

> _Contradiz ADR-0007 (event-sourced orders) — mas vale reabrir porque…_
