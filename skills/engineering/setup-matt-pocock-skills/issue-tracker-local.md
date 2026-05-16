# Issue tracker: Markdown Local

Issues e PRDs deste repo vivem como arquivos markdown em `.scratch/`.

## Convenções

- Uma feature por diretório: `.scratch/<feature-slug>/`
- O PRD é `.scratch/<feature-slug>/PRD.md`
- Issues de implementação são `.scratch/<feature-slug>/issues/<NN>-<slug>.md`, numeradas a partir de `01`
- O estado de triagem é registrado como uma linha `Status:` perto do topo de cada arquivo de issue (veja `.kiro/steering/triage-labels.md` para as strings dos papéis)
- Comentários e histórico de conversa são acrescentados ao final do arquivo sob um cabeçalho `## Comments`

## Quando uma skill diz "publicar no issue tracker"

Crie um novo arquivo sob `.scratch/<feature-slug>/` (criando o diretório se necessário).

## Quando uma skill diz "buscar o ticket relevante"

Leia o arquivo no path referenciado. O usuário normalmente vai passar o path ou o número da issue diretamente.
