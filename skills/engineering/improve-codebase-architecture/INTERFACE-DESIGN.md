# Interface Design

Quando o usuário quer explorar interfaces alternativas para um candidato escolhido a aprofundamento, use este padrão de sub-agente paralelo. Baseado em "Design It Twice" (Ousterhout) — sua primeira ideia provavelmente não é a melhor.

Usa o vocabulário em [LANGUAGE.md](LANGUAGE.md) — **module**, **interface**, **seam**, **adapter**, **leverage**.

## Processo

### 1. Enquadre o espaço do problema

Antes de spawnar sub-agentes, escreva uma explicação voltada ao usuário do espaço do problema para o candidato escolhido:

- As restrições que qualquer nova interface precisaria satisfazer
- As dependências em que ela se apoiaria, e em qual categoria caem (veja [DEEPENING.md](DEEPENING.md))
- Um esboço ilustrativo de código para ancorar as restrições — não uma proposta, só uma forma de tornar as restrições concretas

Mostre isso ao usuário, depois prossiga imediatamente para o Passo 2. O usuário lê e pensa enquanto os sub-agentes trabalham em paralelo.

### 2. Spawn sub-agentes

Spawne 3+ sub-agentes em paralelo usando a Agent tool. Cada um precisa produzir uma interface **radicalmente diferente** para o módulo aprofundado.

Faça o prompt de cada sub-agente com um briefing técnico separado (file paths, detalhes de acoplamento, categoria de dependência de [DEEPENING.md](DEEPENING.md), o que fica atrás do seam). O briefing é independente da explicação do espaço do problema voltada ao usuário no Passo 1. Dê a cada agente uma restrição de design diferente:

- Agente 1: "Minimize a interface — vise 1–3 entry points no máximo. Maximize leverage por entry point."
- Agente 2: "Maximize flexibilidade — suporte muitos casos de uso e extensão."
- Agente 3: "Otimize para o chamador mais comum — torne o caso default trivial."
- Agente 4 (se aplicável): "Desenhe em torno de ports & adapters para dependências cross-seam."

Inclua tanto o vocabulário de [LANGUAGE.md](LANGUAGE.md) quanto o vocabulário de CONTEXT.md no briefing para que cada sub-agente nomeie coisas consistentemente com a linguagem de arquitetura e a linguagem de domínio do projeto.

Cada sub-agente produz:

1. Interface (tipos, métodos, params — mais invariantes, ordenação, modos de erro)
2. Exemplo de uso mostrando como chamadores a usam
3. O que a implementação esconde atrás do seam
4. Estratégia de dependência e adapters (veja [DEEPENING.md](DEEPENING.md))
5. Trade-offs — onde leverage está alta, onde está fina

### 3. Apresente e compare

Apresente designs sequencialmente para que o usuário absorva cada um, depois compare-os em prosa. Contraste por **depth** (alavancagem na interface), **locality** (onde a mudança se concentra) e posicionamento de seam.

Depois de comparar, dê sua própria recomendação: qual design você acha mais forte e por quê. Se elementos de designs diferentes combinariam bem, proponha um híbrido. Seja opinativo — o usuário quer uma leitura forte, não um cardápio.
