# Modo Verify/Check para `setup-matt-pocock-skills`

Este projeto não vai adicionar um modo dedicado de verify/check (nem uma skill separada de verificação) para `setup-matt-pocock-skills`.

## Por que isso está fora do escopo

Uma segunda skill — ou uma flag `--verify` — para checar se os artefatos `docs/agents/*.md` ainda batem com o schema dos templates-semente duplicaria trabalho que a skill de setup existente já cobre em conversa.

O fluxo pretendido é: **execute `/setup-matt-pocock-skills` e diga a ela para verificar seu setup atual.** A skill é orientada a prompt, então o mantenedor pode delimitá-la a um passo de verificação ("não reescreva nada, só confira meus arquivos atuais contra os templates-semente atuais e relate desvios") sem precisar de um caminho de código separado. Adicionar uma flag ou uma skill irmã dividiria a superfície de uma funcionalidade que já é expressável pelo ponto de entrada em linguagem natural.

Manter a gestão de configuração em uma única skill também evita o custo de manutenção de duas skills divergindo entre si quando os templates-semente evoluírem.

## Pedidos anteriores

- #106 — Feature request: verify/check mode for setup-matt-pocock-skills
