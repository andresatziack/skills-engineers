<p>
  <a href="https://www.aihero.dev/s/skills-newsletter">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://res.cloudinary.com/total-typescript/image/upload/v1777382277/skills-repo-dark_2x.png">
      <source media="(prefers-color-scheme: light)" srcset="https://res.cloudinary.com/total-typescript/image/upload/v1777382277/skill-repo-light_2x.png">
      <img alt="Skills" src="https://res.cloudinary.com/total-typescript/image/upload/v1777382277/skill-repo-light_2x.png" width="369">
    </picture>
  </a>
</p>

# Skills para Engenheiros de Verdade

Minhas skills de agente que uso todo dia para fazer engenharia de verdade — não vibe coding.

Desenvolver aplicações reais é difícil. Abordagens como GSD, BMAD e Spec-Kit tentam ajudar tomando posse do processo. Mas, ao fazer isso, elas tiram o seu controle e tornam difícil resolver bugs no próprio processo.

Estas skills foram pensadas para serem pequenas, fáceis de adaptar e componíveis. Elas funcionam com qualquer modelo. Foram baseadas em décadas de experiência em engenharia. Brinque com elas. Faça delas as suas. Aproveite.

Se você quiser acompanhar mudanças nestas skills, e quaisquer novas que eu criar, pode entrar para a minha newsletter junto com cerca de 60.000 outras pessoas dev:

[Inscreva-se na newsletter](https://www.aihero.dev/s/skills-newsletter)

## Como instalar no Kiro

1. Clone este repositório:

```bash
git clone https://github.com/andresatziack/skills-engineers.git
cd skills-engineers
```

2. Rode o script `link-skills.sh` para criar uma pasta plana com todas as skills não-deprecated no seu `$HOME`:

```bash
bash scripts/link-skills.sh
```

Por padrão, o destino é `$HOME/.local/share/skills-engineers/`. Você pode passar outro caminho como primeiro argumento se preferir (ex.: `bash scripts/link-skills.sh ~/skills`).

3. Para ativar uma skill em um workspace Kiro, copie o `SKILL.md` correspondente para `<workspace>/.kiro/steering/<slug>.md` e ajuste o front-matter para `inclusion: manual`. Exemplo com a skill `grill-me`:

```bash
cp ~/.local/share/skills-engineers/grill-me/SKILL.md <workspace>/.kiro/steering/grill-me.md
```

Depois edite o bloco YAML do topo do arquivo copiado para que ele fique assim (mantendo `name:` e `description:` originais e adicionando `inclusion: manual` no mesmo bloco):

```yaml
---
name: grill-me
description: ...
inclusion: manual
---
```

Se preferir, substitua o bloco inteiro por apenas `---\ninclusion: manual\n---`. Sem `inclusion:`, o Kiro trata o arquivo como `inclusion: always` por default e o injeta em toda interação. Para o racional completo desse passo, veja [`.kiro/MIGRATION-NOTES.md`](./.kiro/MIGRATION-NOTES.md).

4. Com `inclusion: manual`, a skill fica invocável por `#<slug>` em chat (ex.: `#grill-me`) ou como comando slash (ex.: `/grill-me`).

5. Para começar a usar de cara, copie a skill `setup-matt-pocock-skills` para `<workspace>/.kiro/steering/setup-matt-pocock-skills.md` (mesmo procedimento do passo 3) e rode `/setup-matt-pocock-skills`. Ela vai:
   - Perguntar qual issue tracker você quer usar (GitHub, GitLab ou markdown local)
   - Perguntar quais labels você aplica às issues quando faz triagem (`/triage` usa labels)
   - Perguntar onde você quer salvar quaisquer docs de domínio que criarmos

6. Opcional: este repositório traz um hook de exemplo em [`.kiro/hooks/git-guardrails.kiro.hook`](./.kiro/hooks/git-guardrails.kiro.hook) que bloqueia comandos git destrutivos antes que eles executem. Para habilitá-lo no seu workspace, siga as instruções da skill [`git-guardrails`](./skills/misc/git-guardrails/SKILL.md).

## Por Que Estas Skills Existem

Eu construí estas skills como uma forma de corrigir modos comuns de falha que vejo em agentes de código modernos.

### #1: O Agente Não Fez o Que Eu Queria

> "No-one knows exactly what they want"
>
> David Thomas & Andrew Hunt, [The Pragmatic Programmer](https://www.amazon.co.uk/Pragmatic-Programmer-Anniversary-Journey-Mastery/dp/B0833F1T3V)

**O Problema**. O modo de falha mais comum no desenvolvimento de software é o desalinhamento. Você acha que a pessoa dev sabe o que você quer. Aí você vê o que ela construiu — e percebe que ela não tinha entendido você.

Isso é exatamente igual na era da IA. Existe uma lacuna de comunicação entre você e o agente. A correção para isso é uma **sessão de grilling** — fazer o agente te interrogar com perguntas detalhadas sobre o que você está construindo.

**A Correção** é usar:

- [`/grill-me`](./skills/productivity/grill-me/SKILL.md) — para usos não relacionados a código
- [`/grill-with-docs`](./skills/engineering/grill-with-docs/SKILL.md) — igual a [`/grill-me`](./skills/productivity/grill-me/SKILL.md), mas com extras (veja abaixo)

Estas são minhas skills mais populares. Elas te ajudam a se alinhar com o agente antes de começar e a pensar profundamente sobre a mudança que você está fazendo. Use-as _toda_ vez que quiser fazer uma mudança.

### #2: O Agente Está Verboso Demais

> With a ubiquitous language, conversations among developers and expressions of the code are all derived from the same domain model.
>
> Eric Evans, [Domain-Driven-Design](https://www.amazon.co.uk/Domain-Driven-Design-Tackling-Complexity-Software/dp/0321125215)

**O Problema**: No início de um projeto, devs e as pessoas para quem estão construindo o software (os domain experts) costumam falar línguas diferentes.

Eu sentia a mesma tensão com meus agentes. Agentes geralmente são jogados em um projeto e precisam descobrir o jargão por conta própria. Aí usam 20 palavras quando 1 bastaria.

**A Correção** para isso é uma linguagem compartilhada. É um documento que ajuda os agentes a decodificar o jargão usado no projeto.

<details>
<summary>
Exemplo
</summary>

Aqui está um exemplo de [`CONTEXT.md`](https://github.com/mattpocock/course-video-manager/blob/076a5a7a182db0fe1e62971dd7a68bcadf010f1c/CONTEXT.md), do meu repo `course-video-manager`. Qual é mais fácil de ler?

- **ANTES**: "Tem um problema quando uma aula dentro de uma seção de um curso é tornada 'real' (isto é, ganha um lugar no sistema de arquivos)"
- **DEPOIS**: "Tem um problema com a materialization cascade"

Essa concisão paga dividendos sessão após sessão.

</details>

Isso está embutido em [`/grill-with-docs`](./skills/engineering/grill-with-docs/SKILL.md). É uma sessão de grilling, mas que te ajuda a construir uma linguagem compartilhada com a IA e a documentar decisões difíceis de explicar em ADRs.

É difícil descrever o quão poderoso isso é. Pode ser a técnica mais legal deste repositório. Tente e veja.

> [!TIP]
> Uma linguagem compartilhada tem muitos outros benefícios além de reduzir verbosidade:
>
> - **Variáveis, funções e arquivos são nomeados de forma consistente**, usando a linguagem compartilhada
> - Como resultado, a **codebase fica mais fácil de navegar** para o agente
> - O agente também **gasta menos tokens pensando**, porque tem acesso a uma linguagem mais concisa

### #3: O Código Não Funciona

> "Always take small, deliberate steps. The rate of feedback is your speed limit. Never take on a task that's too big."
>
> David Thomas & Andrew Hunt, [The Pragmatic Programmer](https://www.amazon.co.uk/Pragmatic-Programmer-Anniversary-Journey-Mastery/dp/B0833F1T3V)

**O Problema**: Digamos que você e o agente estejam alinhados sobre o que construir. O que acontece quando o agente _ainda assim_ produz porcaria?

É hora de olhar para os seus loops de feedback. Sem feedback sobre como o código que ele produz realmente roda, o agente vai estar voando às cegas.

**A Correção**: Você precisa do conjunto usual de loops de feedback: tipos estáticos, acesso ao browser e testes automatizados.

Para testes automatizados, um loop red-green-refactor é crítico. Aí o agente escreve um teste que falha primeiro e depois faz o teste passar. Isso dá ao agente um nível consistente de feedback que resulta em código muito melhor.

Eu construí uma **skill [`/tdd`](./skills/engineering/tdd/SKILL.md)** que você pode encaixar em qualquer projeto. Ela incentiva red-green-refactor e dá ao agente bastante orientação sobre o que torna um teste bom ou ruim.

Para debug, também construí uma skill **[`/diagnose`](./skills/engineering/diagnose/SKILL.md)** que envolve as melhores práticas de debug em um loop simples.

### #4: A Gente Construiu Uma Bola de Lama

> "Invest in the design of the system _every day_."
>
> Kent Beck, [Extreme Programming Explained](https://www.amazon.co.uk/Extreme-Programming-Explained-Embrace-Change/dp/0321278658)

> "The best modules are deep. They allow a lot of functionality to be accessed through a simple interface."
>
> John Ousterhout, [A Philosophy Of Software Design](https://www.amazon.co.uk/Philosophy-Software-Design-2nd/dp/173210221X)

**O Problema**: A maior parte dos apps construídos com agentes é complexa e difícil de mudar. Como agentes podem acelerar radicalmente a escrita de código, eles também aceleram a entropia do software. Codebases ficam mais complexas em um ritmo sem precedentes.

**A Correção** para isso é uma abordagem radicalmente nova para o desenvolvimento orientado a IA: se importar com o design do código.

Isso está embutido em todas as camadas destas skills:

- [`/to-prd`](./skills/engineering/to-prd/SKILL.md) te interroga sobre quais módulos você está mexendo antes de criar um PRD
- [`/zoom-out`](./skills/engineering/zoom-out/SKILL.md) diz ao agente para explicar código no contexto do sistema inteiro

E, crucialmente, [`/improve-codebase-architecture`](./skills/engineering/improve-codebase-architecture/SKILL.md) te ajuda a resgatar uma codebase que virou uma bola de lama. Recomendo rodá-la na sua codebase a cada poucos dias.

### Resumo

Os fundamentos de engenharia de software importam mais do que nunca. Estas skills são meu melhor esforço para condensar esses fundamentos em práticas repetíveis, para te ajudar a entregar os melhores apps da sua carreira. Aproveite.

## Referência

### Engenharia

Skills que uso diariamente para trabalho de código.

- **[diagnose](./skills/engineering/diagnose/SKILL.md)** — Loop disciplinado de diagnóstico para bugs difíceis e regressões de performance: reproduzir → minimizar → hipotetizar → instrumentar → corrigir → teste de regressão.
- **[grill-with-docs](./skills/engineering/grill-with-docs/SKILL.md)** — Sessão de grilling que confronta seu plano com o modelo de domínio existente, afia a terminologia e atualiza `CONTEXT.md` e ADRs no caminho.
- **[triage](./skills/engineering/triage/SKILL.md)** — Faz triagem de issues por meio de uma máquina de estados de papéis de triagem.
- **[improve-codebase-architecture](./skills/engineering/improve-codebase-architecture/SKILL.md)** — Encontra oportunidades de aprofundamento numa codebase, informada pela linguagem de domínio em `CONTEXT.md` e pelas decisões em `docs/adr/`.
- **[setup-matt-pocock-skills](./skills/engineering/setup-matt-pocock-skills/SKILL.md)** — Faz o scaffold da configuração por repositório (issue tracker, vocabulário de labels de triagem, layout dos docs de domínio) que as outras skills de engenharia consomem. Execute uma vez por repositório antes de usar `to-issues`, `to-prd`, `triage`, `diagnose`, `tdd`, `improve-codebase-architecture` ou `zoom-out`.
- **[tdd](./skills/engineering/tdd/SKILL.md)** — Desenvolvimento orientado a testes com um loop red-green-refactor. Constrói features ou corrige bugs uma fatia vertical por vez.
- **[to-issues](./skills/engineering/to-issues/SKILL.md)** — Quebra qualquer plano, spec ou PRD em issues do GitHub independentemente pegáveis usando fatias verticais.
- **[to-prd](./skills/engineering/to-prd/SKILL.md)** — Transforma o contexto da conversa atual em um PRD e o submete como uma issue no GitHub. Sem entrevista — só sintetiza o que você já discutiu.
- **[zoom-out](./skills/engineering/zoom-out/SKILL.md)** — Diga ao agente para dar zoom out e fornecer contexto mais amplo ou uma perspectiva de mais alto nível sobre uma seção desconhecida do código.
- **[prototype](./skills/engineering/prototype/SKILL.md)** — Construa um protótipo descartável para amadurecer um design — ou um app de terminal executável para perguntas de estado/lógica de negócio, ou várias variações radicalmente diferentes de UI alternáveis a partir de uma única rota.

### Produtividade

Ferramentas gerais de fluxo de trabalho, não específicas de código.

- **[caveman](./skills/productivity/caveman/SKILL.md)** — Modo de comunicação ultracomprimido. Reduz o uso de tokens em ~75% cortando enchimento e mantendo precisão técnica completa.
- **[grill-me](./skills/productivity/grill-me/SKILL.md)** — Seja entrevistado implacavelmente sobre um plano ou design até que cada ramo da árvore de decisão esteja resolvido.
- **[handoff](./skills/productivity/handoff/SKILL.md)** — Compacta a conversa atual em um documento de handoff para que outro agente possa continuar o trabalho.
- **[write-a-skill](./skills/productivity/write-a-skill/SKILL.md)** — Cria novas skills com estrutura adequada, divulgação progressiva e recursos empacotados.

### Diversos

Ferramentas que mantenho por perto, mas que uso raramente.

- **[git-guardrails](./skills/misc/git-guardrails/SKILL.md)** — Configura um hook do Kiro para bloquear comandos git perigosos (push, reset --hard, clean, etc.) antes que eles executem.
- **[migrate-to-shoehorn](./skills/misc/migrate-to-shoehorn/SKILL.md)** — Migra arquivos de teste de assertions de tipo `as` para @total-typescript/shoehorn.
- **[scaffold-exercises](./skills/misc/scaffold-exercises/SKILL.md)** — Cria estruturas de diretórios de exercícios com seções, problemas, soluções e explainers.
- **[setup-pre-commit](./skills/misc/setup-pre-commit/SKILL.md)** — Configura hooks de pre-commit do Husky com lint-staged, Prettier, type checking e testes.
