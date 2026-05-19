---
name: install-merlin-skills
description: Install or refresh Merlin Skills globally for Codex/Claude or project-locally under .codex/skills or .claude/skills. Use when the user asks to set up, install, update, or vendor this skill pack into a machine or repo.
---

# Install Merlin Skills

Install or refresh this skill pack into a global skill root or a project-local skill root.

This is a repo-owned meta skill. It routes installation; it does not duplicate `scripts/install-local.sh`.

## When To Use

Use when the user asks to:

- install Merlin Skills globally;
- install Merlin Skills into Codex or Claude;
- install this pack into the current project;
- refresh or update an existing Merlin Skills installation;
- make a repo use `merlin-skills-routing` and the skill-first `/goal` workflow.

Do not use this for normal feature routing. Use `merlin-skills-routing` for implementation work.

## Required Decision

Pick exactly one target mode from the user's request:

| User intent | Mode | `SKILL_ROOT` |
| --- | --- | --- |
| "global", no runtime specified | both global | run Codex and Claude installs |
| Codex global | global Codex | `$HOME/.codex/skills` |
| Claude global | global Claude | `$HOME/.claude/skills` |
| current project for Codex | project Codex | `<project>/.codex/skills` |
| current project for Claude | project Claude | `<project>/.claude/skills` |
| custom path | custom | user-provided `SKILL_ROOT` |

Default to both global only when the user says "global" without naming a runtime.

For all normal modes, keep:

```bash
GSTACK_ROOT="$HOME/.claude/skills/gstack"
```

Only use project-local or custom `GSTACK_ROOT` when the user explicitly asks. Full gstack skills call helpers from the global gstack runtime path, and vendoring that runtime inside projects should not be the default.

## Locate The Merlin Skills Repo

Find the source checkout in this order:

1. Current working directory or an ancestor containing both `skills/merlin-skills-routing/SKILL.md` and `scripts/install-local.sh`.
2. Environment variable `MERLIN_SKILLS_REPO`.
3. A local checkout at `$HOME/.local/share/merlin-skills`.

If none exists, clone it:

```bash
mkdir -p "$HOME/.local/share"
git clone https://github.com/merllinsbeard/merlin-skills.git "$HOME/.local/share/merlin-skills"
```

If the directory exists but is not this repo, stop and report the path conflict.

Set `MERLIN_SKILLS_REPO` to the resolved absolute checkout path before running commands:

```bash
MERLIN_SKILLS_REPO="<resolved-merlin-skills-checkout>"
```

Before installing, verify the source checkout:

```bash
cd "$MERLIN_SKILLS_REPO"
npm test
```

If `npm test` fails, stop unless the user explicitly asked to install an unverified checkout.

## Install Commands

Run commands from the source checkout.

Global Codex:

```bash
SKILL_ROOT="$HOME/.codex/skills" GSTACK_ROOT="$HOME/.claude/skills/gstack" bash scripts/install-local.sh
```

Global Claude:

```bash
SKILL_ROOT="$HOME/.claude/skills" GSTACK_ROOT="$HOME/.claude/skills/gstack" bash scripts/install-local.sh
```

Both global:

```bash
SKILL_ROOT="$HOME/.codex/skills" GSTACK_ROOT="$HOME/.claude/skills/gstack" bash scripts/install-local.sh
SKILL_ROOT="$HOME/.claude/skills" GSTACK_ROOT="$HOME/.claude/skills/gstack" bash scripts/install-local.sh
```

Project Codex:

```bash
PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
SKILL_ROOT="$PROJECT_ROOT/.codex/skills" GSTACK_ROOT="$HOME/.claude/skills/gstack" bash "$MERLIN_SKILLS_REPO/scripts/install-local.sh"
```

Project Claude:

```bash
PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
SKILL_ROOT="$PROJECT_ROOT/.claude/skills" GSTACK_ROOT="$HOME/.claude/skills/gstack" bash "$MERLIN_SKILLS_REPO/scripts/install-local.sh"
```

Custom:

```bash
SKILL_ROOT="<absolute-skill-root>" GSTACK_ROOT="${GSTACK_ROOT:-$HOME/.claude/skills/gstack}" bash "$MERLIN_SKILLS_REPO/scripts/install-local.sh"
```

## Project Instruction Block

For project-local installs, update the target project's instruction file after the install:

- Codex project install: update `AGENTS.md`.
- Claude project install: update `CLAUDE.md`.
- If installing for both project runtimes, update both files.

If the file has an existing `## Merlin Skills` block, replace only that block. Otherwise append this block:

```markdown
## Merlin Skills

Use `merlin-skills-routing` before non-trivial implementation work and always before long-running `/goal` work.

Default route: `office-hours` or `brainstorming` -> spec-kit -> `create-goal` -> `/goal` -> `review` -> `qa` -> browser proof -> `ship`.

Create or refresh `GOAL.md` from spec-kit artifacts before autonomous implementation. Use `install-merlin-skills` to refresh this project's local skill installation.
```

Do not copy the global adapter into a project. Add only this project-specific block.

## Verification

After install, verify:

```bash
find "$SKILL_ROOT" -maxdepth 2 -name SKILL.md | wc -l
test -f "$SKILL_ROOT/install-merlin-skills/SKILL.md"
test -f "$GSTACK_ROOT/office-hours/SKILL.md"
```

Expected installable skill count for this release: `63`.

For project-local installs, also verify the instruction file contains exactly one `## Merlin Skills` block.

## Report

Report:

- source checkout path;
- target mode;
- final `SKILL_ROOT`;
- final `GSTACK_ROOT`;
- whether `npm test` passed before install;
- installable skill count;
- instruction file updated, if project-local.
