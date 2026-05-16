# Ponteiro explícito para `/setup-matt-pocock-skills` apenas em dependências rígidas

As skills de engenharia dependem de configuração por repositório (issue tracker, vocabulário de labels de triagem, layout dos docs de domínio) semeada por `/setup-matt-pocock-skills`. Algumas skills não conseguem funcionar de forma significativa sem essa configuração — elas precisam publicar em um issue tracker específico ou aplicar uma string de label específica. Outras só usam a configuração para afiar a saída (vocabulário, conhecimento de ADRs) e degradam graciosamente sem ela.

Dividimos essas skills em **dependência rígida** e **dependência leve**:

- **Dependência rígida** (`to-issues`, `to-prd`, `triage`) — incluem uma frase explícita de uma linha: _"… deveria ter sido fornecida a você — execute `/setup-matt-pocock-skills` se não foi."_ Sem o mapeamento, a saída fica errada, não apenas imprecisa.
- **Dependência leve** (`diagnose`, `tdd`, `improve-codebase-architecture`, `zoom-out`) — referenciam "o glossário de domínio do projeto" e "ADRs na área que você está mexendo" apenas em prosa vaga. Se os documentos não estiverem lá, a skill ainda funciona; a saída só fica menos afiada.

A divisão mantém as skills de dependência leve econômicas em tokens e evita que o ponteiro de setup seja replicado por inércia em lugares onde ele não é essencial.
