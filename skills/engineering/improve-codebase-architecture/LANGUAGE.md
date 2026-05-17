# Language

Vocabulário compartilhado para cada sugestão que esta skill faz. Use estes termos exatamente — não substitua por "component", "service", "API" ou "boundary". Linguagem consistente é o ponto inteiro.

## Termos

**Module**
Qualquer coisa com uma interface e uma implementação. Deliberadamente agnóstico de escala — aplica-se igualmente a uma função, classe, package ou fatia que cruza camadas.
_Avoid_: unit, component, service.

**Interface**
Tudo que um chamador precisa saber para usar o módulo corretamente. Inclui a assinatura de tipo, mas também invariantes, restrições de ordenação, modos de erro, configuração necessária e características de performance.
_Avoid_: API, signature (estreitos demais — esses se referem apenas à superfície a nível de tipo).

**Implementation**
O que está dentro de um módulo — seu corpo de código. Distinto de **Adapter**: uma coisa pode ser um adapter pequeno com uma implementation grande (um repo Postgres) ou um adapter grande com uma implementation pequena (um fake em memória). Use "adapter" quando o seam é o tópico; "implementation" caso contrário.

**Depth**
Alavancagem na interface — a quantidade de comportamento que um chamador (ou teste) consegue exercitar por unidade de interface que precisa aprender. Um módulo é **deep** quando uma grande quantidade de comportamento fica atrás de uma interface pequena. Um módulo é **shallow** quando a interface é quase tão complexa quanto a implementação.

**Seam** _(de Michael Feathers)_
Um lugar onde você pode alterar o comportamento sem editar naquele lugar. A *localização* na qual a interface de um módulo vive. Escolher onde colocar o seam é uma decisão de design por si só, distinta do que vai atrás dele.
_Avoid_: boundary (sobrecarregado com bounded context do DDD).

**Adapter**
Uma coisa concreta que satisfaz uma interface num seam. Descreve *papel* (que slot ele preenche), não substância (o que tem dentro).

**Leverage**
O que os chamadores ganham com profundidade. Mais capacidade por unidade de interface que precisam aprender. Uma implementação paga de volta em N call sites e M testes.

**Locality**
O que mantenedores ganham com profundidade. Mudança, bugs, conhecimento e verificação se concentram num lugar em vez de se espalharem pelos chamadores. Conserta uma vez, consertado em todo lugar.

## Princípios

- **Profundidade é uma propriedade da interface, não da implementação.** Um módulo profundo pode ser internamente composto de partes pequenas, mockáveis e trocáveis — elas só não fazem parte da interface. Um módulo pode ter **seams internos** (privados à sua implementação, usados pelos próprios testes dele) bem como o **seam externo** na sua interface.
- **O teste de deleção.** Imagine deletar o módulo. Se a complexidade some, o módulo não estava escondendo nada (era um pass-through). Se a complexidade reaparece em N chamadores, o módulo estava ganhando seu sustento.
- **A interface é a superfície de teste.** Chamadores e testes cruzam o mesmo seam. Se você quer testar *além* da interface, o módulo provavelmente está com a forma errada.
- **Um adapter significa um seam hipotético. Dois adapters significam um real.** Não introduza um seam a menos que algo de fato varie por ele.

## Relações

- Um **Module** tem exatamente uma **Interface** (a superfície que apresenta a chamadores e testes).
- **Depth** é uma propriedade de um **Module**, medida contra sua **Interface**.
- Um **Seam** é onde a **Interface** de um **Module** vive.
- Um **Adapter** fica num **Seam** e satisfaz a **Interface**.
- **Depth** produz **Leverage** para chamadores e **Locality** para mantenedores.

## Enquadramentos rejeitados

- **Profundidade como razão de linhas de implementação para linhas de interface** (Ousterhout): recompensa enchimento da implementação. Usamos profundidade-como-alavancagem em vez disso.
- **"Interface" como a palavra-chave `interface` do TypeScript ou os métodos públicos de uma classe**: estreito demais — interface aqui inclui cada fato que um chamador precisa saber.
- **"Boundary"**: sobrecarregado com bounded context do DDD. Diga **seam** ou **interface**.
