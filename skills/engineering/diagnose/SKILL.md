---
name: diagnose
description: Loop disciplinado de diagnóstico para bugs difíceis e regressões de performance. Reproduzir → minimizar → hipotetizar → instrumentar → corrigir → teste de regressão. Use quando o usuário disser "diagnostique isso" / "debug isso", reportar um bug, disser que algo está quebrado/lançando exceção/falhando, ou descrever uma regressão de performance.
---

# Diagnose

Uma disciplina para bugs difíceis. Pule fases somente quando justificado explicitamente.

Ao explorar a codebase, use o glossário de domínio do projeto para ter um modelo mental claro dos módulos relevantes, e cheque ADRs na área que você está mexendo.

## Fase 1 — Construa um loop de feedback

**Esta é a skill.** Todo o resto é mecânico. Se você tem um sinal de pass/fail rápido, determinístico e executável por agente para o bug, você vai encontrar a causa — bisseção, teste de hipóteses e instrumentação só consomem esse sinal. Se você não tem um, nenhuma quantidade de olhar para o código vai te salvar.

Gaste esforço desproporcional aqui. **Seja agressivo. Seja criativo. Recuse-se a desistir.**

### Maneiras de construir um — tente nesta ordem aproximada

1. **Teste falhando** em qualquer seam que alcance o bug — unit, integration, e2e.
2. **Script curl / HTTP** contra um dev server rodando.
3. **Invocação de CLI** com uma input de fixture, fazendo diff do stdout contra um snapshot conhecido.
4. **Script de browser headless** (Playwright / Puppeteer) — dirige a UI, asserta sobre DOM/console/network.
5. **Replay de um trace capturado.** Salve um request de rede / payload / event log real em disco; faça replay dele pelo code path em isolamento.
6. **Harness descartável.** Suba um subconjunto mínimo do sistema (um service, deps mockadas) que exercite o code path do bug com uma única chamada de função.
7. **Loop de property / fuzz.** Se o bug é "às vezes saída errada", rode 1000 inputs aleatórios e procure o modo de falha.
8. **Harness de bisseção.** Se o bug apareceu entre dois estados conhecidos (commit, dataset, versão), automatize "boote no estado X, cheque, repita" para que você possa rodar `git bisect run`.
9. **Loop diferencial.** Rode o mesmo input pela versão antiga vs versão nova (ou duas configs) e faça diff dos outputs.
10. **Script bash HITL.** Último recurso. Se um humano precisa clicar, dirija _ele_ com `scripts/hitl-loop.template.sh` para que o loop ainda seja estruturado. A saída capturada volta para você.

Construa o loop de feedback certo, e o bug está 90% resolvido.

### Itere sobre o próprio loop

Trate o loop como um produto. Uma vez que você tem _um_ loop, pergunte:

- Posso torná-lo mais rápido? (Cachear setup, pular init não relacionada, estreitar o escopo do teste.)
- Posso tornar o sinal mais nítido? (Asserte sobre o sintoma específico, não "não crashou".)
- Posso torná-lo mais determinístico? (Fixar tempo, semear RNG, isolar filesystem, congelar rede.)

Um loop flaky de 30 segundos é mal melhor que nenhum loop. Um loop determinístico de 2 segundos é um superpoder de debug.

### Bugs não-determinísticos

O objetivo não é um repro limpo, mas uma **taxa de reprodução maior**. Faça loop do trigger 100×, paralelize, adicione stress, estreite janelas de timing, injete sleeps. Um bug com 50% de flake é debugável; 1% não é — continue elevando a taxa até ficar debugável.

### Quando você genuinamente não consegue construir um loop

Pare e diga isso explicitamente. Liste o que você tentou. Peça ao usuário: (a) acesso a qualquer ambiente que reproduza, (b) um artefato capturado (arquivo HAR, dump de log, core dump, gravação de tela com timestamps), ou (c) permissão para adicionar instrumentação temporária em produção. **Não** prossiga para hipotetizar sem um loop.

Não prossiga para a Fase 2 até que você tenha um loop em que acredite.

## Fase 2 — Reproduza

Rode o loop. Veja o bug aparecer.

Confirme:

- [ ] O loop produz o modo de falha que o **usuário** descreveu — não uma falha diferente que acontece de estar por perto. Bug errado = correção errada.
- [ ] A falha é reprodutível em múltiplas execuções (ou, para bugs não-determinísticos, reprodutível a uma taxa alta o bastante para debugar).
- [ ] Você capturou o sintoma exato (mensagem de erro, saída errada, timing lento) para que fases posteriores possam verificar que a correção realmente o endereça.

Não prossiga até reproduzir o bug.

## Fase 3 — Hipotetize

Gere **3 a 5 hipóteses ranqueadas** antes de testar qualquer uma delas. Geração de hipótese única ancora na primeira ideia plausível.

Cada hipótese deve ser **falseável**: declare a previsão que ela faz.

> Formato: "Se <X> é a causa, então <mudar Y> vai fazer o bug desaparecer / <mudar Z> vai piorar."

Se você não consegue declarar a previsão, a hipótese é um vibe — descarte ou afie-a.

**Mostre a lista ranqueada para o usuário antes de testar.** Frequentemente eles têm conhecimento de domínio que reranqueia instantaneamente ("acabamos de fazer deploy de uma mudança em #3"), ou conhecem hipóteses que já descartaram. Checkpoint barato, grande economia de tempo. Não bloqueie nele — prossiga com seu ranking se o usuário estiver AFK.

## Fase 4 — Instrumente

Cada probe deve mapear para uma previsão específica da Fase 3. **Mude uma variável por vez.**

Preferência de ferramentas:

1. **Inspeção via debugger / REPL** se o ambiente suportar. Um breakpoint vence dez logs.
2. **Logs direcionados** nas fronteiras que distinguem hipóteses.
3. Nunca "logue tudo e dê grep".

**Marque cada log de debug** com um prefixo único, ex.: `[DEBUG-a4f2]`. Cleanup no final vira um único grep. Logs sem marca sobrevivem; logs marcados morrem.

**Branch de perf.** Para regressões de performance, logs geralmente estão errados. Em vez disso: estabeleça uma medição baseline (timing harness, `performance.now()`, profiler, query plan), depois bisseccione. Meça primeiro, corrija depois.

## Fase 5 — Correção + teste de regressão

Escreva o teste de regressão **antes da correção** — mas só se houver um **seam correto** para ele.

Um seam correto é aquele em que o teste exercita o **padrão real do bug** como ele ocorre no call site. Se o único seam disponível é raso demais (teste com chamador único quando o bug precisa de múltiplos chamadores, unit test que não consegue replicar a cadeia que disparou o bug), um teste de regressão ali dá falsa confiança.

**Se nenhum seam correto existe, isso em si é o achado.** Anote. A arquitetura da codebase está impedindo o bug de ser travado. Sinalize isso para a próxima fase.

Se um seam correto existe:

1. Transforme o repro minimizado em um teste falhando naquele seam.
2. Veja-o falhar.
3. Aplique a correção.
4. Veja-o passar.
5. Re-rode o loop de feedback da Fase 1 contra o cenário original (não-minimizado).

## Fase 6 — Cleanup + post-mortem

Obrigatório antes de declarar feito:

- [ ] Repro original não reproduz mais (re-rode o loop da Fase 1)
- [ ] Teste de regressão passa (ou ausência de seam está documentada)
- [ ] Toda instrumentação `[DEBUG-...]` removida (`grep` o prefixo)
- [ ] Protótipos descartáveis deletados (ou movidos para uma localização claramente marcada como debug)
- [ ] A hipótese que se mostrou correta está declarada na mensagem de commit / PR — para que o próximo debugger aprenda

**Então pergunte: o que teria prevenido este bug?** Se a resposta envolve mudança arquitetural (sem bom seam de teste, chamadores emaranhados, acoplamento escondido), passe para a skill `/improve-codebase-architecture` com as especificidades. Faça a recomendação **depois** que a correção estiver no lugar, não antes — você tem mais informação agora do que tinha quando começou.
