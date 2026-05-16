---
inclusion: fileMatch
fileMatchPattern: "skills/**/SKILL.md"
---

# Skill authoring rules

These rules apply when authoring or editing any `SKILL.md` under `skills/`.

## Front-matter

Every `SKILL.md` begins with a YAML front-matter block delimited by `---` lines. Required keys:

- `name`: the kebab-case slug of the skill. It MUST match the folder name that contains the `SKILL.md` (e.g. `skills/engineering/tdd/SKILL.md` has `name: tdd`).
- `description`: a one-paragraph trigger description. The phrasing should match how the user invokes the skill, because the agent uses this string to decide when the skill applies. Write it from the perspective of "use this skill when the user wants to ...".

Optional keys:

- `disable-model-invocation: true` — set this on setup-style skills that should only be invoked explicitly by the user, never auto-triggered by the agent based on the description.

## File layout

- The skill's main entry point is `SKILL.md` at the root of the skill folder.
- Sub-pages (e.g. `tdd/deep-modules.md`, `tdd/mocking.md`) live alongside `SKILL.md` in the same folder. They MUST be linked from `SKILL.md` so the agent can discover them.
- Bundled scripts live under `<skill>/scripts/` (e.g. `diagnose/scripts/hitl-loop.template.sh`). Reference them from `SKILL.md` with a relative path.

## Slug consistency

The folder name, the `name:` front-matter value, and any references to the skill in the top-level `README.md`, the bucket `README.md`, and `.kiro/steering/published-skills.md` MUST all use the same kebab-case slug.
