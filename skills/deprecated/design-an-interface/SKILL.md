---
name: design-an-interface
description: Gera múltiplos designs de interface radicalmente diferentes para um módulo usando sub-agentes paralelos. Use quando o usuário quiser desenhar uma API, explorar opções de interface, comparar formas de módulo ou mencionar "design it twice".
---

# Design an Interface

Baseado em "Design It Twice" de "A Philosophy of Software Design": é improvável que sua primeira ideia seja a melhor. Gere múltiplos designs radicalmente diferentes e depois compare.

## Fluxo de trabalho

### 1. Levante Requisitos

Antes de desenhar, entenda:

- [ ] Que problema este módulo resolve?
- [ ] Quem são os chamadores? (outros módulos, usuários externos, testes)
- [ ] Quais são as operações-chave?
- [ ] Alguma restrição? (performance, compatibilidade, padrões existentes)
- [ ] O que deve ficar escondido por dentro vs exposto?

Pergunte: "What does this module need to do? Who will use it?"

### 2. Gere Designs (Sub-Agentes Paralelos)

Dispare 3+ sub-agentes simultaneamente usando a ferramenta Task. Cada um precisa produzir uma abordagem **radicalmente diferente**.

```
Prompt template for each sub-agent:

Design an interface for: [module description]

Requirements: [gathered requirements]

Constraints for this design: [assign a different constraint to each agent]
- Agent 1: "Minimize method count - aim for 1-3 methods max"
- Agent 2: "Maximize flexibility - support many use cases"
- Agent 3: "Optimize for the most common case"
- Agent 4: "Take inspiration from [specific paradigm/library]"

Output format:
1. Interface signature (types/methods)
2. Usage example (how caller uses it)
3. What this design hides internally
4. Trade-offs of this approach
```

### 3. Apresente os Designs

Mostre cada design com:

1. **Assinatura da interface** - tipos, métodos, params
2. **Exemplos de uso** - como os chamadores realmente a usam na prática
3. **O que ela esconde** - complexidade mantida interna

Apresente os designs sequencialmente para que o usuário possa absorver cada abordagem antes da comparação.

### 4. Compare os Designs

Depois de mostrar todos os designs, compare-os em:

- **Simplicidade da interface**: menos métodos, params mais simples
- **Propósito geral vs especializada**: flexibilidade vs foco
- **Eficiência da implementação**: a forma permite internas eficientes?
- **Profundidade**: interface pequena escondendo complexidade significativa (bom) vs interface grande com implementação fina (ruim)
- **Facilidade de uso correto** vs **facilidade de uso indevido**

Discuta as trade-offs em prosa, não em tabelas. Destaque onde os designs divergem mais.

### 5. Sintetize

Frequentemente o melhor design combina insights de múltiplas opções. Pergunte:

- "Which design best fits your primary use case?"
- "Any elements from other designs worth incorporating?"

## Critérios de Avaliação

De "A Philosophy of Software Design":

**Interface simplicity**: Menos métodos, params mais simples = mais fácil de aprender e usar corretamente.

**General-purpose**: Pode lidar com casos de uso futuros sem mudanças. Mas cuidado com supergeneralização.

**Implementation efficiency**: A forma da interface permite implementação eficiente? Ou força internas estranhas?

**Depth**: Interface pequena escondendo complexidade significativa = módulo profundo (bom). Interface grande com implementação fina = módulo raso (evitar).

## Antipadrões

- Não deixe os sub-agentes produzirem designs parecidos - imponha diferença radical
- Não pule a comparação - o valor está no contraste
- Não implemente - isto é puramente sobre a forma da interface
- Não avalie com base no esforço de implementação
