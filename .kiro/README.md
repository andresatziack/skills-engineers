# .kiro

Kiro IDE configuration for this repository.

- `steering/` holds thematic project conventions that Kiro injects into the agent context. Start with `skill-organization.md` for the bucket layout and authoring rules; `skill-authoring-rules.md` is auto-loaded when editing any `SKILL.md`; `published-skills.md` is the manual-inclusion inventory of skills shipped to end users.
- `hooks/` holds Kiro hooks (`*.kiro.hook` JSON files). The bundled `git-guardrails.kiro.hook` runs `hooks/scripts/block-dangerous-git.sh` before any shell tool call to block destructive git operations.
- `settings/mcp.json` is the Model Context Protocol configuration. It is empty by default; add MCP servers under `mcpServers` as needed.
