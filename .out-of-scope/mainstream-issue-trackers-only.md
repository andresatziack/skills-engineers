# Integrações com issue trackers limitadas a ferramentas mainstream

`setup-matt-pocock-skills` só oferece suporte de primeira classe a issue trackers **mainstream**. Pedidos para adicionar suporte a trackers de nicho, novos ou experimentais de um único fornecedor estão fora do escopo.

## Por que isso está fora do escopo

Cada backend de issue tracker fixa um formato de CLI dentro das skills (comandos, flags, parsing de saída). Cada novo backend é superfície permanente de manutenção — precisa continuar funcionando à medida que a CLI da ferramenta evolui, e precisa continuar sendo testado contra `/to-prd`, `/to-issues`, `/triage` e companhia. Esse custo só compensa para trackers que uma fração significativa dos usuários realmente tem.

"Mainstream" é uma decisão de bom senso, não uma régua numérica:

- GitHub, GitLab e Backlog.md são o tipo de ferramenta que consideraríamos mainstream — amplamente conhecidas, muito usadas e bem além da fase experimental.
- Uma ferramenta novinha focada em agentes com algumas centenas de stars no GitHub não é, por mais interessante que seja o design.

Stars, idade e contagens de download são sinais úteis ao tomar a decisão, mas nenhum deles é a regra. A regra é: um engenheiro típico reconheceria essa ferramenta e plausivelmente a teria escolhido para o time dele?

As válvulas de escape para trackers não-mainstream já existem:

- `local markdown` para rastreamento leve dentro do repositório.
- `other/custom` para usuários que querem cabear algo por conta própria.

Nenhuma das duas exige que as skills principais conheçam a ferramenta específica.

## Pedidos anteriores

- #99 — "Add dex as an issue tracker backend" (dex tinha cerca de 3 meses e ~300 stars na época do pedido)
