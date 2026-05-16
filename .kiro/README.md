# .kiro

Configuração do Kiro IDE para este repositório.

- `steering/` contém convenções temáticas do projeto que o Kiro injeta no contexto do agente. Comece por `skill-organization.md` para o layout dos buckets e regras de autoria; `skill-authoring-rules.md` é carregado automaticamente ao editar qualquer `SKILL.md`; `published-skills.md` é o inventário de inclusão manual das skills enviadas aos usuários finais.
- `hooks/` contém os hooks do Kiro (arquivos JSON `*.kiro.hook`). O `git-guardrails.kiro.hook` empacotado executa `hooks/scripts/block-dangerous-git.sh` antes de qualquer chamada de ferramenta shell, para bloquear operações destrutivas do git.
- `settings/mcp.json` é a configuração do Model Context Protocol. Vem vazio por padrão; adicione servidores MCP em `mcpServers` conforme necessário.
