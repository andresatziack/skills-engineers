# Limites rígidos no número de perguntas durante o grilling

A skill `/grill-me` (e as sessões de grilling dentro de outras skills) não impõe um número máximo de perguntas. Pedidos para adicionar um teto configurável ou um limite rígido estão fora do escopo.

## Por que isso está fora do escopo

O grilling é intencionalmente aberto. O ponto é continuar cavando até que cada ramo da árvore de decisão seja resolvido — alguns planos precisam de três perguntas, outros precisam de cinquenta. Um teto fixo cortaria exploração útil em problemas difíceis ou pareceria arbitrário em problemas fáceis.

Se uma sessão parece longa demais, as válvulas de escape certas já existem:

- O usuário pode parar a sessão a qualquer momento e aceitar o estado atual do plano.
- O usuário pode dizer ao modelo para concluir, resumir e seguir em frente — direção em linguagem natural é a superfície de controle pretendida, não um limite numérico.

Adicionar um teto rígido também confundiria dois modos de falha diferentes: um modelo que faz perguntas demais porque o plano está genuinamente subespecificado (funcionando como esperado) vs. um modelo que faz perguntas redundantes ou de baixo valor (um problema de qualidade do prompt, não de quantidade). O conserto para o segundo caso pertence ao prompt da skill, não a um contador.

## Pedidos anteriores

- #44 — "Codex just asked me 200 questions"
