# Install

## Validate

```bash
npm test
```

## Install Into Codex

```bash
npm run install:codex
```

This copies installable skills into `~/.codex/skills`. Retained gstack-derived skills are installed as `gstack-qa` and `gstack-ship`; GitHub Spec Kit skills are installed as `speckit-*`.

## Install Into Claude

```bash
npm run install:claude
```

This copies installable skills into `~/.claude/skills`. This release does not install or build a gstack runtime sidecar.

## Install Into Both Global Roots

```bash
SKILL_ROOT="$HOME/.codex/skills" bash scripts/install-local.sh
SKILL_ROOT="$HOME/.claude/skills" bash scripts/install-local.sh
```

This is the default route used by `install-merlin-skills` when the user asks for a global install without naming Codex or Claude.

## Install Into A Project

Project-local Codex:

```bash
PROJECT_ROOT=/path/to/project
SKILL_ROOT="$PROJECT_ROOT/.codex/skills" bash scripts/install-local.sh
```

Project-local Claude:

```bash
PROJECT_ROOT=/path/to/project
SKILL_ROOT="$PROJECT_ROOT/.claude/skills" bash scripts/install-local.sh
```

Project-local installs should also add a compact `## Merlin Skills` block to the project's `AGENTS.md` for Codex or `CLAUDE.md` for Claude. The `install-merlin-skills` meta skill owns that instruction-file update.

## Legacy gstack Cleanup

The installer removes stale Merlin-managed gstack skills from the selected skill root when it can identify them, for example `gstack-review`, `gstack-office-hours`, or old unprefixed `review`.

It does not automatically delete `~/.claude/skills/gstack`, because that directory may belong to a standalone gstack install outside Merlin Skills.

## Temporary Install Test

```bash
rm -rf /tmp/merlin-skills-root
SKILL_ROOT=/tmp/merlin-skills-root bash scripts/install-local.sh
find /tmp/merlin-skills-root -maxdepth 2 -name SKILL.md | sort
test -f /tmp/merlin-skills-root/speckit-cli/SKILL.md
test -f /tmp/merlin-skills-root/speckit-specify/SKILL.md
test -f /tmp/merlin-skills-root/speckit-plan/SKILL.md
test -f /tmp/merlin-skills-root/speckit-tasks/SKILL.md
test -f /tmp/merlin-skills-root/gstack-qa/SKILL.md
test -f /tmp/merlin-skills-root/gstack-ship/SKILL.md
test ! -e /tmp/merlin-skills-root/gstack-review/SKILL.md
```

This release should produce 23 installable `SKILL.md` files in the selected skill root.
