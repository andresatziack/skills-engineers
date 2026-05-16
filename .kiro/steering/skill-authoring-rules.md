---
inclusion: fileMatch
fileMatchPattern: "skills/**/SKILL.md"
---

# Regras de autoria de skills

Estas regras se aplicam ao escrever ou editar qualquer `SKILL.md` sob `skills/`.

## Front-matter

Todo `SKILL.md` começa com um bloco YAML de front-matter delimitado por linhas `---`. Chaves obrigatórias:

- `name`: o slug em kebab-case da skill. PRECISA bater com o nome da pasta que contém o `SKILL.md` (por exemplo, `skills/engineering/tdd/SKILL.md` tem `name: tdd`).
- `description`: uma descrição-gatilho de um parágrafo. O fraseado deve combinar com a forma como o usuário invoca a skill, porque o agente usa essa string para decidir quando a skill se aplica. Escreva da perspectiva "use esta skill quando o usuário quiser ...".

Chaves opcionais:

- `disable-model-invocation: true` — defina nas skills do tipo setup que só devem ser invocadas explicitamente pelo usuário, nunca disparadas automaticamente pelo agente com base na descrição.

## Layout de arquivos

- O ponto de entrada principal da skill é o `SKILL.md` na raiz da pasta da skill.
- Subpáginas (por exemplo, `tdd/deep-modules.md`, `tdd/mocking.md`) ficam ao lado do `SKILL.md` na mesma pasta. Elas PRECISAM estar linkadas a partir do `SKILL.md` para que o agente possa descobri-las.
- Scripts empacotados ficam sob `<skill>/scripts/` (por exemplo, `diagnose/scripts/hitl-loop.template.sh`). Referencie-os a partir do `SKILL.md` com um caminho relativo.

## Consistência de slug

O nome da pasta, o valor de `name:` no front-matter e quaisquer referências à skill no `README.md` de nível superior, no `README.md` do bucket e em `.kiro/steering/published-skills.md` PRECISAM todos usar o mesmo slug em kebab-case.
