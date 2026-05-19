# Install

## Validate

```bash
npm test
```

## Install Into Codex

```bash
npm run install:codex
```

This copies `skills/*` into `~/.codex/skills`.

## Install Into Claude

```bash
npm run install:claude
```

This copies `skills/*` into `~/.claude/skills`.

## gstack Compatibility Runtime

Selected gstack skills expect helpers at:

```text
~/.claude/skills/gstack/
```

The installer always syncs `gstack-runtime/` there, even when installing into Codex. This preserves upstream gstack skill behavior without editing the copied gstack skills.

The installer attempts to build `browse/dist/browse` and `design/dist/design` if Bun is available. To skip that step:

```bash
MERLIN_SKIP_GSTACK_BUILD=1 npm run install:codex
```

## Temporary Install Test

```bash
SKILL_ROOT=/tmp/merlin-skills-root GSTACK_ROOT=/tmp/merlin-gstack-runtime MERLIN_SKIP_GSTACK_BUILD=1 bash scripts/install-local.sh
find /tmp/merlin-skills-root -maxdepth 2 -name SKILL.md | sort
```
