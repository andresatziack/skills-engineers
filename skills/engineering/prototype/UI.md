# UI Prototype

Gere **várias variações radicalmente diferentes de UI** numa única rota, alternáveis a partir de uma barra inferior flutuante. O usuário troca entre as variantes no browser, escolhe uma (ou rouba pedaços de cada), e depois joga o resto fora.

Se a pergunta é sobre lógica/estado em vez de como algo se parece — ramo errado. Use [LOGIC.md](LOGIC.md).

## Quando esta é a forma certa

- "Como esta página deveria parecer?"
- "Quero ver algumas opções para este dashboard antes de me comprometer."
- "Tente um layout diferente para a tela de settings."
- Sempre que o usuário gastaria um dia escolhendo entre três mockups vagos na cabeça dele.

## Duas sub-formas — prefira fortemente a sub-forma A

Uma UI prototype é muito mais fácil de julgar quando ela está **encostando no resto do app** — header real, sidebar real, dados reais, densidade real. Uma rota descartável por si só é um vácuo: cada variante parece bem em isolamento. Default para a sub-forma A sempre que houver uma página existente plausível para hospedar as variantes. Só vá para a sub-forma B se o protótipo genuinamente não tiver nenhuma casa por perto.

### Sub-forma A — ajuste a uma página existente (preferida)

A rota já existe. As variantes são renderizadas **na mesma rota**, gateadas por um search param de URL `?variant=`. O fetching de dados, params e auth existentes ficam — só a renderização troca. Este é o default; escolha-o a menos que haja uma razão específica para não.

Se o protótipo é para algo que ainda não tem uma página mas *naturalmente viveria dentro de uma* (uma nova seção do dashboard, um novo card na tela de settings, um novo passo num fluxo existente) — isso ainda é sub-forma A. Monte as variantes dentro da página hospedeira.

### Sub-forma B — uma página nova (último recurso)

Use isto somente quando a coisa sendo prototipada genuinamente não tem nenhuma página existente para viver dentro — ex.: uma superfície de top-level inteiramente nova, ou um fluxo que não pode ser embutido em lugar nenhum sensato.

Crie uma **rota descartável** seguindo a convenção de roteamento que o projeto já usa — não invente uma nova estrutura de top-level. Nomeie-a de modo que fique óbvio que é um protótipo (ex.: inclua a palavra `prototype` no path ou no filename). Mesmo padrão `?variant=`.

Antes de se comprometer com a sub-forma B, faça uma sanity-check: realmente não há página existente em que isso poderia ser embutido? Uma rota vazia esconde problemas de design que uma populada exporia.

Em ambas as sub-formas a barra inferior flutuante é idêntica.

## Processo

### 1. Declare a pergunta e escolha N

Default para **3 variantes**. Mais de 5 deixa de ser radicalmente diferente e começa a virar ruído — pare ali.

Anote o plano em uma linha, na localização do protótipo ou num comentário no topo do arquivo:

> "Três variantes da página de settings, alternáveis via `?variant=`, na rota existente `/settings`."

Isso funciona quer o usuário esteja aqui para empurrar de volta ou não.

### 2. Gere variantes radicalmente diferentes

Rascunhe cada variante. Mantenha cada uma sob:

- O propósito da página e os dados a que ela tem acesso.
- A biblioteca de componentes / sistema de estilo do projeto (TailwindCSS, shadcn, MUI, CSS puro, o que for).
- Um nome de componente exportado claro, ex.: `VariantA`, `VariantB`, `VariantC`.

Variantes precisam ser **estruturalmente diferentes** — layout diferente, hierarquia de informação diferente, affordance primária diferente, não só cores diferentes. Três card grids levemente ajustadas não é uma UI prototype, é papel de parede. Se dois rascunhos saem parecidos demais, refaça um com orientação explícita "não use uma card grid".

### 3. Conecte tudo

Crie um único componente de switcher na rota:

```tsx
// pseudo-código — adapte para o framework do projeto
const variant = searchParams.get('variant') ?? 'A';
return (
  <>
    {variant === 'A' && <VariantA {...data} />}
    {variant === 'B' && <VariantB {...data} />}
    {variant === 'C' && <VariantC {...data} />}
    <PrototypeSwitcher variants={['A','B','C']} current={variant} />
  </>
);
```

Para sub-forma A (página existente): mantenha todo o data fetching existente acima do switcher; só a sub-árvore renderizada muda por variante.

Para sub-forma B (página nova): a rota descartável sob `/prototype/<name>` monta o mesmo switcher.

### 4. Construa o switcher flutuante

Uma barra pequena fixa no centro inferior da tela com três pedaços:

- **Seta esquerda** — cicla para a variante anterior (com wrap-around).
- **Label da variante** — mostra a chave da variante atual e, se a variante exporta um nome, esse nome também. Ex.: `B — Sidebar layout`.
- **Seta direita** — cicla para frente (com wrap-around).

Comportamento:

- Clicar uma seta atualiza o search param da URL (use o router do framework — `router.replace` no Next, `navigate` no React Router, etc) para que a variante seja compartilhável e estável a reload.
- Teclado: `←` e `→` também ciclam. Não intercepte teclas de seta quando um `<input>`, `<textarea>` ou `[contenteditable]` estiver focado.
- Visualmente distinta da página (ex.: pílula de alto contraste, sombra sutil) para que fique óbvio que não é parte do design sendo avaliado.
- Escondida em builds de produção — gateie em `process.env.NODE_ENV !== 'production'` ou um check equivalente, para que um merge perdido de protótipo não consiga enviar a barra para usuários.

Coloque o switcher num único componente compartilhado para que ambas as sub-formas possam reusá-lo. Localize-o onde quer que UI compartilhada viva no projeto.

### 5. Entregue

Traga à tona a URL (e as chaves `?variant=`). O usuário vai trocar entre elas quando puder. O feedback interessante geralmente é **"quero o header da B com a sidebar da C"** — esse é o design que ele realmente quer.

### 6. Capture a resposta e limpe

Uma vez que uma variante venceu, anote qual e por quê (mensagem de commit, ADR, issue, ou um `NOTES.md` ao lado do protótipo se rodando AFK e o usuário não respondeu ainda). Depois:

- **Sub-forma A** — delete as variantes perdedoras e o switcher; dobre a vencedora para dentro da página existente.
- **Sub-forma B** — promova a variante vencedora a uma rota real, delete a rota descartável e o switcher.

Não deixe componentes de variante ou o switcher por aí. Eles apodrecem rápido e confundem o próximo leitor.

## Anti-padrões

- **Variantes que diferem só em cor ou texto.** Isso é um ajuste, não um protótipo. Variantes reais discordam sobre estrutura.
- **Compartilhar código demais entre variantes.** Um `<Header>` compartilhado tudo bem; um `<Layout>` compartilhado anula o ponto. Cada variante deve estar livre para jogar fora o layout.
- **Conectar variantes a mutations reais.** Protótipos somente-leitura estão bem. Se uma variante precisa mutar, aponte para um stub — a pergunta é "como isso deveria parecer", não "o backend funciona".
- **Promover o protótipo direto para produção.** O código da variante foi escrito sob restrições de protótipo (sem testes, mínimo tratamento de erro). Reescreva direito quando for dobrar para dentro.
