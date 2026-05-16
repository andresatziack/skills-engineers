# Deepening

Como aprofundar um cluster de módulos rasos com segurança, dadas suas dependências. Pressupõe o vocabulário em [LANGUAGE.md](LANGUAGE.md) — **module**, **interface**, **seam**, **adapter**.

## Categorias de dependência

Quando avalia um candidato a aprofundamento, classifique suas dependências. A categoria determina como o módulo aprofundado é testado pelo seu seam.

### 1. In-process

Computação pura, estado em memória, sem I/O. Sempre pode ser aprofundado — funda os módulos e teste pela nova interface diretamente. Sem necessidade de adapter.

### 2. Local-substitutable

Dependências que têm stand-ins de teste locais (PGLite para Postgres, filesystem em memória). Pode ser aprofundado se o stand-in existe. O módulo aprofundado é testado com o stand-in rodando dentro da test suite. O seam é interno; nenhuma porta na interface externa do módulo.

### 3. Remote but owned (Ports & Adapters)

Seus próprios serviços através de uma fronteira de rede (microservices, APIs internas). Defina uma **porta** (interface) no seam. O módulo profundo possui a lógica; o transporte é injetado como um **adapter**. Testes usam um adapter em memória. Produção usa um adapter HTTP/gRPC/queue.

Forma de recomendação: *"Defina uma porta no seam, implemente um adapter HTTP para produção e um adapter em memória para teste, para que a lógica fique num único módulo profundo, ainda que ele seja deployado por uma fronteira de rede."*

### 4. True external (Mock)

Serviços de terceiros (Stripe, Twilio, etc.) que você não controla. O módulo aprofundado recebe a dependência externa como uma porta injetada; testes fornecem um mock adapter.

## Disciplina de seam

- **Um adapter significa um seam hipotético. Dois adapters significam um real.** Não introduza uma porta a menos que pelo menos dois adapters sejam justificados (tipicamente produção + teste). Um seam de adapter único é só indireção.
- **Seams internos vs seams externos.** Um módulo profundo pode ter seams internos (privados à sua implementação, usados pelos próprios testes dele) bem como o seam externo na sua interface. Não exponha seams internos pela interface só porque os testes os usam.

## Estratégia de testes: substitua, não acumule camadas

- Unit tests antigos sobre módulos rasos viram desperdício uma vez que existam testes na interface do módulo aprofundado — delete-os.
- Escreva novos testes na interface do módulo aprofundado. A **interface é a superfície de teste**.
- Testes assertam sobre resultados observáveis pela interface, não sobre estado interno.
- Testes devem sobreviver a refactors internos — descrevem comportamento, não implementação. Se um teste precisa mudar quando a implementação muda, ele está testando além da interface.
