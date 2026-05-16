---
name: review
description: Revisa as mudanças desde um ponto fixo (commit, branch, tag ou merge-base) em dois eixos — Standards (o código segue os padrões de código documentados deste repo?) e Spec (o código corresponde ao que a issue/PRD originadora pediu?). Roda as duas revisões em sub-agentes paralelos e as reporta lado a lado. Use quando o usuário quiser revisar uma branch, um PR, mudanças em andamento ou pedir para "revisar desde X".
---

# Review

Revisão de dois eixos do diff entre `HEAD` e um ponto fixo que o usuário fornece:

- **Standards** — o código está em conformidade com os padrões de código documentados deste repo?
- **Spec** — o código implementa fielmente a issue / PRD / spec originadora?

Os dois eixos rodam como **sub-agentes paralelos** para que não poluam o contexto um do outro, e então esta skill agrega as descobertas.

O issue tracker deveria ter sido fornecido a você — rode `/setup-matt-pocock-skills` se `.kiro/steering/issue-tracker.md` estiver faltando.

## Processo

### 1. Fixe o ponto fixo

O que quer que o usuário tenha dito é o ponto fixo — um SHA de commit, nome de branch, tag, `main`, `HEAD~5`, etc. Não seja opinativo; passe adiante. Se ele não especificar um, pergunte: "Revisar contra o quê — uma branch, um commit ou `main`?" Não prossiga até ter isso.

Capture o comando de diff uma vez: `git diff <fixed-point>...HEAD` (três pontos, para que a comparação seja contra o merge-base). Anote também a lista de commits via `git log <fixed-point>..HEAD --oneline`.

### 2. Identifique a fonte da spec

Procure pela spec originadora, nesta ordem:

1. Referências a issues nas mensagens de commit (`#123`, `Closes #45`, `!67` no GitLab, etc.) — busque pelo workflow em `.kiro/steering/issue-tracker.md`.
2. Um caminho que o usuário passou como argumento.
3. Um arquivo de PRD/spec em `docs/`, `specs/` ou `.scratch/` que case com o nome da branch ou da feature.
4. Se nada for encontrado, pergunte ao usuário onde está a spec. Se ele disser que não há uma, o sub-agente de **Spec** vai pular e reportar "no spec available".

### 3. Identifique as fontes de standards

Qualquer coisa no repo que documente como o código deve ser escrito. Locais comuns:

- `.kiro/steering/*.md` (os arquivos de steering que o Kiro carrega automaticamente)
- `CONTRIBUTING.md`
- `CONTEXT.md`, `CONTEXT-MAP.md`, arquivos `CONTEXT.md` por contexto
- `docs/adr/` (decisões arquiteturais são standards)
- `.editorconfig`, `eslint.config.*`, `biome.json`, `prettier.config.*`, `tsconfig.json` (standards reforçados por máquina — anote-os mas não verifique de novo o que o tooling já checa)
- Qualquer `STYLE.md`, `STANDARDS.md`, `STYLEGUIDE.md` ou similar na raiz do repo ou em `docs/`

Colete a lista de arquivos. O sub-agente de **Standards** vai lê-los.

### 4. Dispare os dois sub-agentes em paralelo

Envie uma única mensagem com duas chamadas da ferramenta `Agent`. Use o subagent `general-purpose` para os dois.

**Prompt do sub-agente de Standards** — inclua:

- O comando de diff completo e a lista de commits.
- A lista de arquivos-fonte de standards que você encontrou no passo 3.
- O briefing: "Read the standards docs. Then read the diff. Report — per file/hunk where relevant — every place the diff violates a documented standard. Cite the standard (file + the rule). Distinguish hard violations from judgement calls. Skip anything tooling enforces. Under 400 words."

**Prompt do sub-agente de Spec** — inclua:

- O comando de diff e a lista de commits.
- O caminho ou o conteúdo já buscado da spec.
- O briefing: "Read the spec. Then read the diff. Report: (a) requirements the spec asked for that are missing or partial; (b) behaviour in the diff that wasn't asked for (scope creep); (c) requirements that look implemented but where the implementation looks wrong. Quote the spec line for each finding. Under 400 words."

Se a spec estiver faltando, pule o sub-agente de Spec e anote isso no relatório final.

### 5. Agregue

Apresente os dois relatórios sob os headings `## Standards` e `## Spec`, verbatim ou levemente limpos. **Não** mescle nem reordene as descobertas — os dois eixos são deliberadamente separados para que o usuário possa vê-los de forma independente.

Termine com um resumo de uma linha: total de descobertas por eixo e o pior problema individual (se houver) sinalizado.

## Por que dois eixos

Uma mudança pode passar em um eixo e falhar no outro:

- Código que segue todos os standards mas implementa a coisa errada → **Standards passa, Spec falha.**
- Código que faz exatamente o que a issue pediu mas quebra as convenções do projeto → **Spec passa, Standards falha.**

Reportá-los separadamente impede que um eixo mascare o outro.
