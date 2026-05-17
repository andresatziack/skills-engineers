---
name: handoff
description: Compacta a conversa atual em um documento de handoff para que outro agente possa pegar o trabalho.
argument-hint: "Para que a próxima sessão vai ser usada?"
---

Escreva um documento de handoff resumindo a conversa atual para que um agente fresco possa continuar o trabalho. Salve-o num path produzido por `mktemp -t handoff-XXXXXX.md` (leia o arquivo antes de escrever nele).

Sugira as skills a serem usadas, se houver, pela próxima sessão.

Não duplique conteúdo já capturado em outros artefatos (PRDs, planos, ADRs, issues, commits, diffs). Referencie-os por path ou URL em vez disso.

Se o usuário passou argumentos, trate-os como uma descrição do que a próxima sessão vai focar e ajuste o doc adequadamente.
