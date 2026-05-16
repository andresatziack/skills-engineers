# Formato do ADR

ADRs vivem em `docs/adr/` e usam numeração sequencial: `0001-slug.md`, `0002-slug.md`, etc.

Crie o diretório `docs/adr/` preguiçosamente — só quando o primeiro ADR for necessário.

## Template

```md
# {Título curto da decisão}

{1 a 3 frases: qual é o contexto, o que decidimos e por quê.}
```

É isso. Um ADR pode ser um único parágrafo. O valor está em registrar *que* uma decisão foi tomada e *por quê* — não em preencher seções.

## Seções opcionais

Inclua-as somente quando agregam valor genuíno. A maioria dos ADRs não vai precisar delas.

- **Status** no front-matter (`proposed | accepted | deprecated | superseded by ADR-NNNN`) — útil quando decisões são revisitadas
- **Considered Options** — só quando as alternativas rejeitadas valem a pena lembrar
- **Consequences** — só quando efeitos não-óbvios a jusante precisam ser destacados

## Numeração

Escaneie `docs/adr/` em busca do maior número existente e incremente em um.

## Quando oferecer um ADR

Todos os três precisam ser verdade:

1. **Difícil de reverter** — o custo de mudar de ideia depois é significativo
2. **Surpreendente sem contexto** — um leitor futuro vai olhar para o código e se perguntar "por que diabos fizeram desse jeito?"
3. **Resultado de um trade-off real** — havia alternativas genuínas e você escolheu uma por razões específicas

Se uma decisão é fácil de reverter, pule — você só vai revertê-la. Se não é surpreendente, ninguém vai se perguntar por quê. Se não havia alternativa real, não há nada a registrar além de "fizemos a coisa óbvia".

### O que se qualifica

- **Forma arquitetural.** "Estamos usando um monorepo." "O write model é event-sourced, o read model é projetado para o Postgres."
- **Padrões de integração entre contextos.** "Ordering e Billing se comunicam via eventos de domínio, não HTTP síncrono."
- **Escolhas de tecnologia que carregam lock-in.** Banco de dados, message bus, provedor de auth, alvo de deployment. Não toda biblioteca — apenas as que levariam um trimestre para trocar.
- **Decisões de fronteira e escopo.** "Dados de Customer são donos do contexto Customer; outros contextos referenciam por ID apenas." Os "não" explícitos são tão valiosos quanto os "sim".
- **Desvios deliberados do caminho óbvio.** "Estamos usando SQL manual em vez de um ORM porque X." Qualquer coisa em que um leitor razoável assumiria o oposto. Esses impedem o próximo engenheiro de "consertar" algo que era deliberado.
- **Restrições não visíveis no código.** "Não podemos usar AWS por causa de requisitos de compliance." "Tempos de resposta precisam ficar abaixo de 200ms por causa do contrato de API com o parceiro."
- **Alternativas rejeitadas quando a rejeição é não-óbvia.** Se você considerou GraphQL e escolheu REST por razões sutis, registre — caso contrário alguém vai sugerir GraphQL de novo em seis meses.
