# Base de Conhecimento Out-of-Scope

O diretório `.out-of-scope/` num repo armazena registros persistentes de pedidos de feature rejeitados. Ele serve a dois propósitos:

1. **Memória institucional** — por que uma feature foi rejeitada, para que o raciocínio não seja perdido quando a issue é fechada
2. **Deduplicação** — quando uma nova issue chega que combina com uma rejeição prévia, a skill pode trazer à tona a decisão anterior em vez de re-litigar

## Estrutura de diretório

```
.out-of-scope/
├── dark-mode.md
├── plugin-system.md
└── graphql-api.md
```

Um arquivo por **conceito**, não por issue. Múltiplas issues pedindo a mesma coisa são agrupadas sob um arquivo.

## Formato de arquivo

O arquivo deve ser escrito em estilo relaxado e legível — mais como um documento de design curto do que uma entrada de banco de dados. Use parágrafos, exemplos de código e exemplos para tornar o raciocínio claro e útil para alguém encontrando pela primeira vez.

```markdown
# Dark Mode

This project does not support dark mode or user-facing theming.

## Why this is out of scope

The rendering pipeline assumes a single color palette defined in
`ThemeConfig`. Supporting multiple themes would require:

- A theme context provider wrapping the entire component tree
- Per-component theme-aware style resolution
- A persistence layer for user theme preferences

This is a significant architectural change that doesn't align with the
project's focus on content authoring. Theming is a concern for downstream
consumers who embed or redistribute the output.

```ts
// The current ThemeConfig interface is not designed for runtime switching:
interface ThemeConfig {
  colors: ColorPalette; // single palette, resolved at build time
  fonts: FontStack;
}
```

## Prior requests

- #42 — "Add dark mode support"
- #87 — "Night theme for accessibility"
- #134 — "Dark theme option"
```

### Nomeando o arquivo

Use um nome curto e descritivo em kebab-case para o conceito: `dark-mode.md`, `plugin-system.md`, `graphql-api.md`. O nome deve ser reconhecível o bastante para que alguém navegando pelo diretório entenda o que foi rejeitado sem abrir o arquivo.

### Escrevendo a razão

A razão deve ser substantiva — não "não queremos isso" mas por quê. Boas razões referenciam:

- Escopo ou filosofia do projeto ("Este projeto foca em X; theming é uma preocupação a jusante")
- Restrições técnicas ("Suportar isso exigiria Y, que conflita com nossa arquitetura Z")
- Decisões estratégicas ("Escolhemos usar A em vez de B porque...")

A razão deve ser durável. Evite referenciar circunstâncias temporárias ("estamos ocupados demais agora") — essas não são rejeições reais, são adiamentos.

## Quando checar `.out-of-scope/`

Durante a triagem (Passo 1: Reúna contexto), leia todos os arquivos em `.out-of-scope/`. Ao avaliar uma nova issue:

- Cheque se o pedido combina com um conceito out-of-scope existente
- Matching é por similaridade de conceito, não keyword — "night theme" combina com `dark-mode.md`
- Se há um match, traga à tona para o mantenedor: "Isto é similar a `.out-of-scope/dark-mode.md` — rejeitamos isto antes porque [razão]. Você ainda sente o mesmo?"

O mantenedor pode:

- **Confirmar** — a nova issue é adicionada à lista "Prior requests" do arquivo existente, depois fechada
- **Reconsiderar** — o arquivo out-of-scope é deletado ou atualizado, e a issue prossegue pela triagem normal
- **Discordar** — as issues estão relacionadas mas são distintas, prossiga com triagem normal

## Quando escrever em `.out-of-scope/`

Apenas quando um **enhancement** (não um bug) é rejeitado como `wontfix`. O fluxo:

1. Mantenedor decide que um pedido de feature está fora de escopo
2. Cheque se um arquivo `.out-of-scope/` correspondente já existe
3. Se sim: anexe a nova issue à lista "Prior requests"
4. Se não: crie um novo arquivo com o nome do conceito, decisão, razão e primeiro pedido prévio
5. Poste um comentário na issue explicando a decisão e mencionando o arquivo `.out-of-scope/`
6. Feche a issue com a label `wontfix`

## Atualizando ou removendo arquivos out-of-scope

Se o mantenedor muda de ideia sobre um conceito previamente rejeitado:

- Delete o arquivo `.out-of-scope/`
- A skill não precisa reabrir issues antigas — elas são registros históricos
- A nova issue que disparou a reconsideração prossegue pela triagem normal
