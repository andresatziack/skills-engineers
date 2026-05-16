# Matt Pocock Skills

Uma coleção de skills de agente (Kiro steering files e comportamentos) carregadas pelo Kiro. As skills são organizadas em buckets e consumidas pela configuração por repositório emitida por `/setup-matt-pocock-skills`.

## Linguagem

**Issue tracker**:
A ferramenta que hospeda as issues de um repositório — GitHub Issues, Linear, uma convenção markdown local em `.scratch/`, ou similar. Skills como `to-issues`, `to-prd`, `triage` e `qa` leem dele e escrevem nele.
_Evite_: backlog manager, backlog backend, issue host

**Issue**:
Uma única unidade rastreada de trabalho dentro de um **Issue tracker** — um bug, tarefa, PRD ou fatia produzida por `to-issues`.
_Evite_: ticket (use somente ao citar sistemas externos que os chamam de tickets)

**Triage role**:
Um rótulo canônico de máquina de estados aplicado a uma **Issue** durante a triagem (por exemplo, `needs-triage`, `ready-for-afk`). Cada role mapeia para uma string de label real no **Issue tracker** via `.kiro/steering/triage-labels.md`.

## Relações

- Um **Issue tracker** contém muitas **Issues**
- Uma **Issue** carrega uma **Triage role** por vez

## Ambiguidades sinalizadas

- "backlog" era usado anteriormente para significar tanto a *ferramenta* que hospeda as issues quanto o *corpo de trabalho* dentro dela — resolvido: a ferramenta é o **Issue tracker**; "backlog" não é mais usado como termo de domínio.
- "backlog backend" / "backlog manager" — resolvido: colapsados em **Issue tracker**.
