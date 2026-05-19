# Merlin Skills

![Merlin Skills cover: a premium developer workflow workbench with spec, goal, QA, browser proof, and ship artifacts connected by routing lines](assets/merlin-skills-cover.png)

Merlin Skills is an open-source skill pack for long-running Codex web coding work. It combines a narrow set of proven upstream skills into one operating model:

`office-hours -> spec-kit -> create-goal -> /goal -> review -> qa -> playwright proof -> ship`

The bias is simple: write the specification once, convert it into a durable goal contract, then let Codex work against that contract with the right specialist skill at each phase.

## What Is Included

| Source | Included | Why |
| --- | --- | --- |
| `github/spec-kit` | Full source snapshot archive | Canonical `spec.md`, `plan.md`, `tasks.md`, constitution, and spec-driven implementation flow. |
| `ayoubben18/ab-method` | Only the create-goal idea, adapted into `skills/create-goal` | The useful part is the durable `GOAL.md` contract. The AB-specific structure is replaced with spec-kit artifacts. |
| `mattpocock/skills` | `tdd`, `to-prd`, `grill-with-docs`, `diagnose`, `zoom-out` | These fill planning, pressure-testing, debugging, and test-first gaps without becoming a second orchestration system. |
| `garrytan/gstack` | `office-hours`, `plan-ceo-review`, `review`, `qa`, `qa-only`, `ship`, selected plan and design skills | These are the best product shaping, post-implementation, UI, QA, and ship loops. |
| `microsoft/playwright-cli` | `playwright-cli` skill | Token-efficient browser control and Playwright test workflow for agents. |
| `lackeyjb/playwright-skill` | `playwright-skill` | General-purpose Playwright automation when scripted browser checks are better than CLI steps. |
| `obra/superpowers` | `brainstorming` only | Strong design-first entrypoint for ambiguous creative/product work. |

All upstream skills are copied as upstream snapshots. This repo does not rewrite upstream skills. The only adapted skill is `skills/create-goal`, because it intentionally converts AB Method's goal creation idea into a spec-kit-native Codex goal contract.

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

The installer copies all installable skills into the selected skill root. It also installs a gstack compatibility runtime at `~/.claude/skills/gstack`, because upstream gstack skill files intentionally call helper scripts from that path.

## Core Workflow

1. Run `merlin-skills-routing` first for any non-trivial project or `/goal`.
2. Create or update spec-kit artifacts: `spec.md`, `plan.md`, `tasks.md`, plus optional `research.md`, `data-model.md`, `contracts/`, `quickstart.md`, and `checklists/`.
3. Run `create-goal` to generate `specs/<feature>/GOAL.md` from those artifacts.
4. Start Codex `/goal` with the generated `GOAL.md`.
5. Use implementation skills only when routed: `office-hours`, `tdd`, `diagnose`, `review`, `qa`, `playwright-cli`, `ship`, or plan/design skills.
6. Keep proof attached to the spec and goal: task checkmarks, tests, screenshots, QA reports, PR links, and release notes.

## Routing Rule

The meta skill `skills/merlin-skills-routing/SKILL.md` is mandatory before goal execution. It decides the smallest useful skill chain and prevents process sprawl. It should never load every skill by default.

Typical routes:

| Situation | Route |
| --- | --- |
| Product idea or "is this worth building?" | `office-hours -> plan-ceo-review -> spec-kit -> create-goal` |
| Ambiguous creative feature | `brainstorming -> spec-kit -> create-goal` |
| Existing docs but no goal | `create-goal` |
| Implementation from spec | `merlin-skills-routing -> tdd -> /goal` |
| Hard bug | `diagnose -> tdd -> qa` |
| UI plan | `plan-design-review -> design-shotgun/design-html -> playwright-cli` |
| Ready to land | `review -> qa -> ship` |
| Browser proof needed | `playwright-cli` first, `playwright-skill` for custom scripts |

## Repo Layout

```text
skills/                    installable skills
skills/create-goal/        repo-owned spec-kit goal adapter
skills/merlin-skills-routing/
vendor-snapshots/          provenance snapshots and source archives
gstack-runtime/            compatibility runtime for upstream gstack skills
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
- no nested `SKILL.md` exists outside the allowed runtime surface;
- upstream manifest paths exist;
- license files exist;
- the spec-kit archive hash matches the recorded manifest.
