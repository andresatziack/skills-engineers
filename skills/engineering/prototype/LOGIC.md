# Logic Prototype

Um pequeno app interativo de terminal que deixa o usuário dirigir um modelo de estado na mão. Use isto quando a pergunta é sobre **lógica de negócio, transições de estado ou forma dos dados** — o tipo de coisa que parece razoável no papel mas só sente errado uma vez que você empurra por casos reais.

## Quando esta é a forma certa

- "Não tenho certeza se esta state machine cobre o caso de borda em que X depois Y."
- "Este modelo de dados de fato me deixa representar o caso em que..."
- "Quero sentir como a API deveria parecer antes de escrever."
- Qualquer coisa em que o usuário queira **apertar botões e ver o estado mudar**.

Se a pergunta é "como isso deveria parecer" — ramo errado. Use [UI.md](UI.md).

## Processo

### 1. Declare a pergunta

Antes de escrever código, anote qual modelo de estado e qual pergunta você está prototipando. Um parágrafo, no README do protótipo ou num comentário no topo do arquivo. Um logic prototype que responde à pergunta errada é puro desperdício — torne a pergunta explícita para que possa ser checada depois, quer o usuário esteja olhando agora ou voltando AFK.

### 2. Escolha a linguagem

Use o que o projeto host usa. Se o projeto não tem runtime óbvio (ex.: um repo de docs), pergunte.

Combine com as convenções de tooling existentes do projeto — não adicione um novo package manager ou runtime só para o protótipo.

### 3. Isole a lógica num módulo portável

Coloque a lógica de fato — a parte que está respondendo à pergunta — atrás de uma interface pequena e pura que poderia ser levantada e droppada na codebase real depois. A TUI ao redor é descartável; o módulo de lógica não deveria ser.

A forma certa depende da pergunta:

- **Um reducer puro** — `(state, action) => state`. Bom quando ações são eventos discretos e o estado é um único valor.
- **Uma state machine** — estados e transições explícitos. Bom quando "quais ações são sequer legais agora" é parte da pergunta.
- **Um pequeno conjunto de funções puras** sobre um tipo de dado simples. Bom quando não há estado atual implícito — só transformações.
- **Uma classe ou módulo com uma superfície de método clara** quando a lógica genuinamente possui estado interno contínuo.

Escolha qualquer forma que melhor se ajuste à pergunta sendo feita, *não* qualquer que seja mais fácil de conectar a uma TUI. Mantenha-a pura: sem I/O, sem código de terminal, sem `console.log` para controle de fluxo. A TUI a importa e chama nela; nada flui na outra direção.

Isto é o que torna o protótipo útil além de seu próprio tempo de vida. Quando a pergunta foi respondida, o reducer / machine / conjunto de funções validado pode ser levantado para dentro do módulo real — a TUI shell é deletada.

### 4. Construa a menor TUI que expõe o estado

Construa-a como uma **TUI leve** — em cada tick, limpe a tela (`console.clear()` / `print("\033[2J\033[H")` / equivalente) e re-renderize o frame inteiro. O usuário deve sempre ver uma view estável, não um scrollback que sempre cresce.

Cada frame tem duas partes, nesta ordem:

1. **Estado atual**, pretty-printed e diff-friendly (um campo por linha, ou JSON formatado). Use **negrito** para nomes de campos ou cabeçalhos de seção e **dim** para contexto menos importante (timestamps, IDs, valores derivados). Códigos de escape ANSI nativos estão bem — `\x1b[1m` negrito, `\x1b[2m` dim, `\x1b[0m` reset. Não há necessidade de puxar uma biblioteca de styling a menos que uma já esteja no projeto.
2. **Atalhos de teclado**, listados embaixo: `[a] add user  [d] delete user  [t] tick clock  [q] quit`. Negrito na tecla, dim na descrição, ou vice-versa — o que ler de forma limpa.

Comportamento:

1. **Inicialize o estado** — um único objeto/struct em memória. Renderize o primeiro frame ao iniciar.
2. **Leia uma tecla (ou uma linha) por vez**, despache para um handler que muta o estado.
3. **Re-renderize** o frame inteiro depois de cada ação — não anexe, substitua.
4. **Loop até quit.**

O frame inteiro deve caber numa tela.

### 5. Torne-o executável em um comando

Adicione um script ao task runner existente do projeto (`package.json` scripts, `Makefile`, `justfile`, `pyproject.toml`). O usuário deve rodar `pnpm run <prototype-name>` ou equivalente — nunca precisar lembrar um path.

Se o projeto host não tem task runner, só coloque o comando no topo do README do protótipo.

### 6. Entregue

Dê ao usuário o comando de rodar. Eles vão dirigir; os momentos interessantes são quando dizem "espera, isso não deveria ser possível" ou "hum, eu assumi que X seria diferente" — esses são os bugs na _ideia_, que é o ponto inteiro. Se eles querem ações novas adicionadas, adicione. Protótipos evoluem.

### 7. Capture a resposta

Quando o protótipo cumpriu seu trabalho, a resposta à pergunta é a única coisa que vale guardar. Se o usuário está por perto, pergunte o que ele aprendeu. Se não, deixe um `NOTES.md` ao lado do protótipo para que a resposta possa ser preenchida (ou preenchida por você, se você assistiu a sessão) antes que o protótipo seja deletado.

## Anti-padrões

- **Não adicione testes.** Um protótipo que precisa de testes não é mais um protótipo.
- **Não conecte ao banco de dados real.** Use um store em memória a menos que a pergunta seja especificamente sobre persistência.
- **Não generalize.** Sem "e se quisermos suportar X depois". O protótipo responde a uma pergunta.
- **Não embaralhe a lógica e a TUI.** Se o reducer / state machine referencia `console.log`, prompts ou códigos de escape de terminal, não é mais portável. Mantenha a TUI como uma casca fina sobre um módulo puro.
- **Não envie a TUI shell para produção.** A shell é otimizada para ser dirigida na mão a partir de um terminal. O módulo de lógica atrás dela é a parte que vale guardar.
