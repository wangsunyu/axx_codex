# AGENTS.md

## Skills
A skill is a set of local instructions stored in a `SKILL.md` file. Available skills for this project:

- `openspec-apply-change`: Implement tasks from an OpenSpec change.
  File: `/Users/wsy/Desktop/code/iOS项目/安小信flutter-codex/.codex/skills/openspec-apply-change/SKILL.md`
- `openspec-archive-change`: Archive a completed OpenSpec change.
  File: `/Users/wsy/Desktop/code/iOS项目/安小信flutter-codex/.codex/skills/openspec-archive-change/SKILL.md`
- `openspec-explore`: Explore ideas, investigate problems, and clarify requirements.
  File: `/Users/wsy/Desktop/code/iOS项目/安小信flutter-codex/.codex/skills/openspec-explore/SKILL.md`
- `openspec-propose`: Propose a new OpenSpec change with artifacts generated in one step.
  File: `/Users/wsy/Desktop/code/iOS项目/安小信flutter-codex/.codex/skills/openspec-propose/SKILL.md`
- `openai-docs`: Use official OpenAI docs for up-to-date product and API guidance.
  File: `/Users/wsy/.codex/skills/.system/openai-docs/SKILL.md`
- `skill-creator`: Create or improve Codex skills.
  File: `/Users/wsy/.codex/skills/.system/skill-creator/SKILL.md`
- `skill-installer`: Install Codex skills from curated sources or repositories.
  File: `/Users/wsy/.codex/skills/.system/skill-installer/SKILL.md`

## How To Use Skills
- If a user explicitly names a skill, or the request clearly matches a skill description, use that skill for the turn.
- Read only enough of the target `SKILL.md` to follow the workflow.
- Resolve relative paths mentioned by a skill relative to that skill's directory first.
- Prefer reusing scripts, templates, and assets from the skill instead of recreating them.
- Keep context small and only open additional files when needed.
- If a skill cannot be used cleanly, state the issue briefly and continue with the best fallback.

## Coordination Rules
- Use the minimal set of skills that covers the task.
- If multiple skills apply, state the order you are using them in and why.
- If an obvious skill is not used, say why.

## Project Context
- Workspace root: `/Users/wsy/Desktop/code/iOS项目/安小信flutter-codex`
- Default shell: `zsh`
- Current timezone: `Asia/Shanghai`

## Interaction Rule
- All buttons in this project must apply a global debounce strategy to prevent repeated rapid taps.
- Button interactions must not allow consecutive fast clicks to trigger duplicate actions such as navigation, requests, submissions, or state updates.
- User-facing toast, snackbar, or transient feedback should use a unified custom style that matches the current page and product visual language, rather than default system appearance.
- Input fields and text editing menus should display Chinese actions globally, including labels such as copy, cut, paste, and select all.

## Change Approval Rule
- Before making any code changes or modifying project files, explain the intended changes first.
- Only proceed with edits after receiving explicit approval from the user.
