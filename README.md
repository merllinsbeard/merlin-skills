# Merlin Skills

![Merlin Skills cover: a premium developer workflow workbench with spec, goal, QA, browser proof, and ship artifacts connected by routing lines](assets/merlin-skills-cover.png)

Merlin Skills is an open-source skill pack for long-running Codex web coding work. It combines a narrow set of proven upstream skills into one operating model:

`gstack-office-hours -> spec-kit -> create-goal -> /goal -> gstack-review -> gstack-qa -> playwright proof -> gstack-ship`

The bias is simple: write the specification once, convert it into a durable goal contract, then let Codex work against that contract with the right specialist skill at each phase.

## What Is Included

| Source | Included | Why |
| --- | --- | --- |
| `github/spec-kit` | Full source snapshot archive | Canonical `spec.md`, `plan.md`, `tasks.md`, constitution, and spec-driven implementation flow. |
| `ayoubben18/ab-method` | Only the create-goal idea, adapted into `skills/create-goal` | The useful part is the durable `GOAL.md` contract. The AB-specific structure is replaced with spec-kit artifacts. |
| `mattpocock/skills` | `tdd`, `to-prd`, `grill-with-docs`, `diagnose`, `zoom-out` | These fill planning, pressure-testing, debugging, and test-first gaps without becoming a second orchestration system. |
| `garrytan/gstack` | Full gstack skill distribution plus full curated runtime sidecar | Product shaping, browser dogfooding, review, QA, ship, deploy, docs, gbrain, safety, context, and OpenClaw-specific loops. The router still keeps the default workflow narrow. |
| `microsoft/playwright-cli` | `playwright-cli` skill | Token-efficient browser control and Playwright test workflow for agents. |
| `lackeyjb/playwright-skill` | `playwright-skill` | General-purpose Playwright automation when scripted browser checks are better than CLI steps. |
| `obra/superpowers` | `brainstorming` only | Strong design-first entrypoint for ambiguous creative/product work. |

All upstream skills are copied as upstream snapshots. This repo does not rewrite upstream source files. During install, gstack copies get namespaced `name:` frontmatter in the target skill root so the user-facing commands are `gstack-*`. The only adapted skill source is `skills/create-goal`, because it intentionally converts AB Method's goal creation idea into a spec-kit-native Codex goal contract.

Repo-owned meta skills:

- `merlin-skills-routing`: chooses the smallest useful skill chain before `/goal`.
- `install-merlin-skills`: installs or refreshes this pack globally or into a project-local skill root.

## Quick Start

```bash
git clone https://github.com/merllinsbeard/merlin-skills.git
cd merlin-skills
npm test
```

Install into Codex:

```bash
npm run install:codex
```

Install into Claude:

```bash
npm run install:claude
```

The installer copies all installable skills into the selected skill root. Gstack-derived user-facing skills are installed with the `gstack-` prefix, such as `gstack-review`, `gstack-qa`, and `gstack-office-hours`, while the runtime sidecar keeps upstream directories such as `review/`, `qa/`, and `office-hours/` under `~/.claude/skills/gstack`.

Install into a project-local Codex skill root:

```bash
PROJECT_ROOT=/path/to/project
SKILL_ROOT="$PROJECT_ROOT/.codex/skills" GSTACK_ROOT="$HOME/.claude/skills/gstack" bash scripts/install-local.sh
```

After the pack is installed, use `install-merlin-skills` when you want an agent to choose between global Codex, global Claude, both global, project-local Codex, project-local Claude, or custom skill roots.

## Core Workflow

1. Run `merlin-skills-routing` first for any non-trivial project or `/goal`.
2. Create or update spec-kit artifacts: `spec.md`, `plan.md`, `tasks.md`, plus optional `research.md`, `data-model.md`, `contracts/`, `quickstart.md`, and `checklists/`.
3. Run `create-goal` to generate `specs/<feature>/GOAL.md` from those artifacts.
4. Start Codex `/goal` with the generated `GOAL.md`.
5. Use implementation skills only when routed: the full gstack surface is available, but default work should still pick the smallest useful chain.
6. Keep proof attached to the spec and goal: task checkmarks, tests, screenshots, QA reports, PR links, and release notes.

## Routing Rule

The meta skill `skills/merlin-skills-routing/SKILL.md` is mandatory before goal execution. It decides the smallest useful skill chain and prevents process sprawl. It should never load every skill by default.

Typical routes:

| Situation | Route |
| --- | --- |
| Install or refresh Merlin Skills | `install-merlin-skills` |
| Product idea or "is this worth building?" | `gstack-office-hours -> gstack-plan-ceo-review -> spec-kit -> create-goal` |
| Ambiguous creative feature | `brainstorming -> spec-kit -> create-goal` |
| Existing docs but no goal | `create-goal` |
| Implementation from spec | `merlin-skills-routing -> tdd -> /goal` |
| Hard bug | `diagnose -> tdd -> gstack-qa` |
| UI plan | `gstack-plan-design-review -> gstack-design-shotgun/gstack-design-html -> playwright-cli` |
| Ready to land | `gstack-review -> gstack-qa -> gstack-ship` |
| Browser proof needed | `playwright-cli` first, `playwright-skill` for custom scripts |
| Browser dogfood or screenshots | `gstack-browse` or `gstack-open-gstack-browser` |
| Safety boundary needed | `gstack-careful`, `gstack-freeze`, `gstack-guard`, or `gstack-unfreeze` |
| Health, perf, or canary | `gstack-health`, `gstack-benchmark`, or `gstack-canary` |
| Context handoff | `gstack-context-save` or `gstack-context-restore` |
| Docs or release docs | `gstack-document-generate` or `gstack-document-release` |
| Deploy workflow | `gstack-setup-deploy -> gstack-land-and-deploy` |
| GBrain workflow | `gstack-setup-gbrain -> gstack-sync-gbrain -> gstack-learn` |
| PDF export | `gstack-make-pdf` |
| Scraping flow | `gstack-scrape -> gstack-skillify` |
| Outside model wrapper | `gstack-codex` or `gstack-claude` |
| OpenClaw-specific request | `gstack-openclaw-*` |

## Repo Layout

```text
skills/                    installable skills
skills/create-goal/        repo-owned spec-kit goal adapter
skills/install-merlin-skills/
skills/merlin-skills-routing/
vendor-snapshots/          provenance snapshots and source archives
gstack-runtime/            full curated runtime sidecar for upstream gstack skills
third_party/licenses/      upstream license copies
docs/                      operating model and selection rationale
scripts/                   installer and validators
assets/                    README cover and workflow illustration
```

## Provenance

Every upstream source, commit SHA, license, and copied path is recorded in `vendor-snapshots/manifest.json` and summarized in `THIRD_PARTY_NOTICES.md`.

The full spec-kit source is preserved as `vendor-snapshots/archives/github-spec-kit-51e6a140e291.tar.gz`. It is stored as an archive instead of an extracted runtime tree to avoid accidental recursive skill discovery from upstream nested `SKILL.md` files.

## Validation

```bash
npm test
```

Validation checks:

- every installable skill lives directly under `skills/<name>/SKILL.md`;
- `merlin-skills-routing` mentions every install-facing skill name, including prefixed gstack names;
- no nested `SKILL.md` exists outside the allowed runtime surface;
- upstream manifest paths exist;
- license files exist;
- the spec-kit archive hash matches the recorded manifest.
