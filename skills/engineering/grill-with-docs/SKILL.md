---
name: grill-with-docs
description: Sessão de grilling que confronta seu plano com o modelo de domínio existente, afia a terminologia e atualiza a documentação (CONTEXT.md, ADRs) no caminho conforme as decisões cristalizam. Use quando o usuário quer estressar um plano contra a linguagem do projeto e suas decisões documentadas.
---

<what-to-do>

Me entreviste implacavelmente sobre cada aspecto deste plano até alcançarmos um entendimento compartilhado. Caminhe por cada ramo da árvore de design, resolvendo dependências entre decisões uma por uma. Para cada pergunta, forneça a sua resposta recomendada.

Faça as perguntas uma de cada vez, esperando feedback em cada pergunta antes de continuar.

Se uma pergunta puder ser respondida explorando a codebase, explore a codebase em vez disso.

</what-to-do>

<supporting-info>

## Consciência de domínio

Durante a exploração da codebase, procure também por documentação existente:

### Estrutura de arquivos

A maioria dos repos tem um único contexto:

```
/
├── CONTEXT.md
├── docs/
│   └── adr/
│       ├── 0001-event-sourced-orders.md
│       └── 0002-postgres-for-write-model.md
└── src/
```

Se um `CONTEXT-MAP.md` existe na raiz, o repo tem múltiplos contextos. O mapa aponta para onde cada um vive:

```
/
├── CONTEXT-MAP.md
├── docs/
│   └── adr/                          ← decisões de todo o sistema
├── src/
│   ├── ordering/
│   │   ├── CONTEXT.md
│   │   └── docs/adr/                 ← decisões específicas do contexto
│   └── billing/
│       ├── CONTEXT.md
│       └── docs/adr/
```

Crie arquivos preguiçosamente — só quando você tem algo para escrever. Se nenhum `CONTEXT.md` existe, crie um quando o primeiro termo for resolvido. Se nenhum `docs/adr/` existe, crie quando o primeiro ADR for necessário.

## Durante a sessão

### Confronte com o glossário

Quando o usuário usa um termo que conflita com a linguagem existente em `CONTEXT.md`, sinalize imediatamente. "Seu glossário define 'cancellation' como X, mas você parece estar querendo dizer Y — qual dos dois?"

### Afie linguagem nebulosa

Quando o usuário usa termos vagos ou sobrecarregados, proponha um termo canônico preciso. "Você está dizendo 'account' — você quer dizer o Customer ou o User? São coisas diferentes."

### Discuta cenários concretos

Quando relações de domínio estão sendo discutidas, estresse-as com cenários específicos. Invente cenários que sondam casos de borda e forçam o usuário a ser preciso sobre as fronteiras entre conceitos.

### Cruze referências com o código

Quando o usuário declara como algo funciona, cheque se o código concorda. Se você encontra uma contradição, traga à tona: "Seu código cancela Orders inteiras, mas você acabou de dizer que cancelamento parcial é possível — qual está certo?"

### Atualize CONTEXT.md no caminho

Quando um termo é resolvido, atualize `CONTEXT.md` ali mesmo. Não acumule esses updates — capture-os conforme acontecem. Use o formato em [CONTEXT-FORMAT.md](./CONTEXT-FORMAT.md).

`CONTEXT.md` deve ser totalmente desprovido de detalhes de implementação. Não trate `CONTEXT.md` como uma spec, um rascunho ou um repositório de decisões de implementação. É um glossário e nada mais.

### Ofereça ADRs com parcimônia

Só ofereça criar um ADR quando todos os três forem verdade:

1. **Difícil de reverter** — o custo de mudar de ideia depois é significativo
2. **Surpreendente sem contexto** — um leitor futuro vai se perguntar "por que fizeram desse jeito?"
3. **Resultado de um trade-off real** — havia alternativas genuínas e você escolheu uma por razões específicas

Se algum dos três está faltando, pule o ADR. Use o formato em [ADR-FORMAT.md](./ADR-FORMAT.md).

</supporting-info>
