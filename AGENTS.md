# Merlin Skills Agent Guide

This repository is a skill-first, `/goal`-first operating system for autonomous web coding. Treat it as a curated workflow layer, not as a grab bag of prompts.

## Prime Directive

For any non-trivial task, load `skills/merlin-skills-routing/SKILL.md` before selecting implementation skills or creating a Codex `/goal`.

The default sequence is:

```text
route -> gstack-office-hours when useful -> spec -> create-goal -> /goal -> gstack-review -> gstack-qa -> browser proof -> gstack-ship
```

Use the smallest skill chain that covers the work. Do not load every skill by default.

## Source Of Truth

When a feature uses spec-kit, the active feature directory is the source of truth:

```text
specs/<feature>/
  spec.md
  plan.md
  tasks.md
  GOAL.md
```

Optional source files may include `research.md`, `data-model.md`, `contracts/`, `quickstart.md`, and `checklists/`.

Generated goal files must reference the exact spec-kit artifacts they are based on.

## Mandatory `/goal` Entry

Before starting Codex `/goal`:

1. Run `merlin-skills-routing`.
2. Confirm the feature has usable spec-kit artifacts.
3. Run `create-goal` to write `specs/<feature>/GOAL.md`.
4. Start `/goal` from that `GOAL.md`.

Do not start long autonomous work from a loose chat summary when a spec directory exists.

## Routing Table

| Need | Preferred skill route |
| --- | --- |
| Install or refresh Merlin Skills globally or for a project | `install-merlin-skills` |
| Product idea, early concept, or "is this worth building?" | `gstack-office-hours` |
| Ambiguous creative feature | `brainstorming` |
| Convert conversation to PRD | `to-prd` |
| Stress-test assumptions against docs | `grill-with-docs` |
| Understand a broad area | `zoom-out` |
| Build or fix with tests | `tdd` |
| Debug hard bug or regression | `diagnose` |
| Create durable Codex goal | `create-goal` |
| Review code before landing | `gstack-review` |
| QA and fix web app | `gstack-qa` |
| QA report only | `gstack-qa-only` |
| Browser proof or generated Playwright tests | `playwright-cli` |
| Custom Playwright automation | `playwright-skill` |
| Browser dogfooding or screenshots | `gstack-browse` or `gstack-open-gstack-browser` |
| Safety guardrails or edit boundary | `gstack-careful`, `gstack-freeze`, `gstack-guard`, `gstack-unfreeze` |
| Health, perf, benchmark, or canary | `gstack-health`, `gstack-benchmark`, `gstack-canary` |
| Context handoff | `gstack-context-save`, `gstack-context-restore` |
| Documentation generation or release docs | `gstack-document-generate`, `gstack-document-release` |
| Deploy setup or land-and-deploy | `gstack-setup-deploy`, `gstack-land-and-deploy` |
| GBrain setup, sync, or learnings | `gstack-setup-gbrain`, `gstack-sync-gbrain`, `gstack-learn` |
| PDF export | `gstack-make-pdf` |
| Scraping or scrape skill creation | `gstack-scrape`, `gstack-skillify` |
| Outside model review/challenge | `gstack-codex`, `gstack-claude` |
| OpenClaw-specific workflow | matching `gstack-openclaw-*` skill |
| UI/design plan review | `gstack-plan-design-review` |
| Engineering plan review | `gstack-plan-eng-review` |
| Founder/product scope review after a concrete plan exists | `gstack-plan-ceo-review` |
| Developer-experience review | `gstack-plan-devex-review` |
| Tune question sensitivity | `gstack-plan-tune` |
| Ship PR/release | `gstack-ship` |

## Upstream Boundaries

Copied upstream skill sources should stay verbatim. Do not rewrite them during normal maintenance. The installer may patch installed gstack `name:` frontmatter only to enforce the `gstack-` install namespace.

The only intentionally adapted upstream idea is `create-goal`, which is derived from AB Method's create-goal flow and rewritten to use spec-kit artifacts instead of AB Method's project structure.

The full spec-kit repository is archived under `vendor-snapshots/archives/` instead of extracted into the runtime skill tree. Keep it that way unless the installer and validators are updated to avoid recursive skill discovery.

## Verification

Before closing changes to this repo, run:

```bash
npm test
```

If installer behavior changes, also run it against a temporary skill root:

```bash
SKILL_ROOT=/tmp/merlin-skills-root bash scripts/install-local.sh
find /tmp/merlin-skills-root -maxdepth 2 -name SKILL.md | sort
```

Gstack-derived install names must stay prefixed in the skill root (`gstack-review`, `gstack-qa`, `gstack-office-hours`, etc.). The gstack runtime sidecar under `~/.claude/skills/gstack` keeps upstream unprefixed directories.

Do not claim the package is ready until validation passes.
