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

## Install Into Both Global Roots

```bash
SKILL_ROOT="$HOME/.codex/skills" GSTACK_ROOT="$HOME/.claude/skills/gstack" bash scripts/install-local.sh
SKILL_ROOT="$HOME/.claude/skills" GSTACK_ROOT="$HOME/.claude/skills/gstack" bash scripts/install-local.sh
```

This is the default route used by `install-merlin-skills` when the user asks for a global install without naming Codex or Claude.

## Install Into A Project

Project-local Codex:

```bash
PROJECT_ROOT=/path/to/project
SKILL_ROOT="$PROJECT_ROOT/.codex/skills" GSTACK_ROOT="$HOME/.claude/skills/gstack" bash scripts/install-local.sh
```

Project-local Claude:

```bash
PROJECT_ROOT=/path/to/project
SKILL_ROOT="$PROJECT_ROOT/.claude/skills" GSTACK_ROOT="$HOME/.claude/skills/gstack" bash scripts/install-local.sh
```

Project-local installs should also add a compact `## Merlin Skills` block to the project's `AGENTS.md` for Codex or `CLAUDE.md` for Claude. The `install-merlin-skills` meta skill owns that instruction-file update.

## gstack Runtime Sidecar

gstack skills expect helpers at:

```text
~/.claude/skills/gstack/
```

The installer always syncs `gstack-runtime/` there, even when installing into Codex. This preserves upstream gstack skill behavior without editing copied gstack skills. Runtime `SKILL.md` files are not committed under `gstack-runtime`; the installer restores them by overlaying the top-level `skills/<name>/SKILL.md` files into the sidecar.

The installer attempts to build `browse/dist/browse`, `browse/dist/find-browse`, `design/dist/design`, `make-pdf/dist/pdf`, and `bin/gstack-global-discover` if Bun is available. To skip that step:

```bash
MERLIN_SKIP_GSTACK_BUILD=1 npm run install:codex
```

## Temporary Install Test

```bash
SKILL_ROOT=/tmp/merlin-skills-root GSTACK_ROOT=/tmp/merlin-gstack-runtime MERLIN_SKIP_GSTACK_BUILD=1 bash scripts/install-local.sh
find /tmp/merlin-skills-root -maxdepth 2 -name SKILL.md | sort
```

This release should produce 63 installable `SKILL.md` files in the selected skill root.
