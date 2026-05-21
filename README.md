# Merlin Skills

![Merlin Skills cover: a premium developer workflow workbench with spec, goal, QA, browser proof, and ship artifacts connected by routing lines](assets/merlin-skills-cover.png)

Merlin Skills is an open-source skill pack for long-running Codex web coding work. It combines a narrow set of proven upstream skills and the official GitHub Spec Kit Codex skills into one operating model:

`brainstorming -> speckit-* -> create-goal -> /goal -> tdd -> gstack-qa -> playwright proof -> gstack-ship`

The bias is simple: write the specification once, convert it into a durable goal contract, then let Codex work against that contract with the right specialist skill at each phase.

## What Is Included

| Source | Included | Why |
| --- | --- | --- |
| `github/spec-kit` | Full source snapshot archive plus official Codex `speckit-*` skills | Canonical `spec.md`, `plan.md`, `tasks.md`, constitution, `specify` CLI, and spec-driven workflow. |
| `ayoubben18/ab-method` | Only the create-goal idea, adapted into `skills/create-goal` | The useful part is the durable `GOAL.md` contract. The AB-specific structure is replaced with spec-kit artifacts. |
| `mattpocock/skills` | `tdd`, `to-prd`, `grill-with-docs`, `diagnose`, `zoom-out` | These fill planning, pressure-testing, debugging, and test-first gaps without becoming a second orchestration system. |
| `garrytan/gstack` | Only adapted `gstack-qa` and `gstack-ship` | The useful parts for this stack are final QA and shipping. Product strategy, browser daemon, GBrain, deploy, docs, and review-heavy gstack flows are intentionally excluded. |
| `microsoft/playwright-cli` | `playwright-cli` skill | Token-efficient browser control and Playwright test workflow for agents. |
| `lackeyjb/playwright-skill` | `playwright-skill` | General-purpose Playwright automation when scripted browser checks are better than CLI steps. |
| `obra/superpowers` | `brainstorming` only | Strong design-first entrypoint for ambiguous creative/product work. |

Most upstream skills are copied as upstream snapshots. The `speckit-*` skills are generated from the official GitHub Spec Kit Codex integration and kept close to upstream. The adapted skill sources are `skills/create-goal`, `skills/qa`, and `skills/ship`: goal creation is rewritten for spec-kit, while the retained gstack QA/ship flows are rewritten as standalone Merlin gates.

Repo-owned meta skills:

- `merlin-skills-routing`: chooses the smallest useful skill chain before `/goal`.
- `install-merlin-skills`: installs or refreshes this pack globally or into a project-local skill root.
- `speckit-cli`: installs, verifies, initializes, and manages the official Spec Kit `specify` CLI.

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

The installer copies all installable skills into the selected skill root. Retained gstack-derived skills are installed with the `gstack-` prefix: `gstack-qa` and `gstack-ship`. This release does not install or build a gstack runtime sidecar.

Install into a project-local Codex skill root:

```bash
PROJECT_ROOT=/path/to/project
SKILL_ROOT="$PROJECT_ROOT/.codex/skills" bash scripts/install-local.sh
```

After the pack is installed, use `install-merlin-skills` when you want an agent to choose between global Codex, global Claude, both global, project-local Codex, project-local Claude, or custom skill roots.

## Core Workflow

1. Run `merlin-skills-routing` first for any non-trivial project or `/goal`.
2. Use `speckit-cli` if the project still needs `.specify/`, the official `specify` CLI, or Codex `$speckit-*` integration.
3. Use the official `speckit-*` skills to create or refresh spec-kit artifacts: `speckit-constitution`, `speckit-specify`, `speckit-clarify`, `speckit-plan`, `speckit-tasks`, plus `speckit-analyze` or `speckit-checklist` when useful.
4. Run `create-goal` to generate `specs/<feature>/GOAL.md` from those artifacts.
5. Start Codex `/goal` with the generated `GOAL.md`.
6. Use implementation skills only when routed. Gstack is deliberately minimal in this stack: QA and ship only.
7. Keep proof attached to the spec and goal: task checkmarks, tests, screenshots, QA reports, PR links, and release notes.

## Routing Rule

The meta skill `skills/merlin-skills-routing/SKILL.md` is mandatory before goal execution. It decides the smallest useful skill chain and prevents process sprawl. It should never load every skill by default.

Typical routes:

| Situation | Route |
| --- | --- |
| Install or refresh Merlin Skills | `install-merlin-skills` |
| Initialize Spec Kit in a repo | `speckit-cli` |
| Ambiguous creative feature | `brainstorming -> speckit-specify -> speckit-plan -> speckit-tasks -> create-goal` |
| Existing docs but no goal | `create-goal` |
| Implementation from spec | `merlin-skills-routing -> create-goal -> /goal` |
| Hard bug | `diagnose -> tdd -> gstack-qa` |
| UI plan | `brainstorming -> speckit-specify -> speckit-plan -> playwright-cli` |
| Ready to land | `gstack-qa -> gstack-ship` |
| Browser proof needed | `playwright-cli` first, `playwright-skill` for custom scripts |

## Repo Layout

```text
skills/                    installable skills
skills/create-goal/        repo-owned spec-kit goal adapter
skills/install-merlin-skills/
skills/merlin-skills-routing/
skills/speckit-cli/        repo-owned official Specify CLI wrapper
skills/speckit-*/          upstream-generated GitHub Spec Kit Codex skills
vendor-snapshots/          provenance snapshots and source archives
third_party/licenses/      upstream license copies
docs/                      operating model and selection rationale
scripts/                   installer and validators
assets/                    README cover and workflow illustration
```

## Provenance

Every upstream source, commit SHA, license, and copied path is recorded in `vendor-snapshots/manifest.json` and summarized in `THIRD_PARTY_NOTICES.md`.

The full spec-kit source is preserved as `vendor-snapshots/archives/github-spec-kit-f16468f21f4e.tar.gz`. It is stored as an archive instead of an extracted runtime tree to avoid accidental recursive skill discovery from upstream nested `SKILL.md` files. Only the official Codex `speckit-*` skills are promoted into the live `skills/` surface.

## Validation

```bash
npm test
```

Validation checks:

- every installable skill lives directly under `skills/<name>/SKILL.md`;
- `merlin-skills-routing` mentions every install-facing skill name, including prefixed gstack names;
- no nested `SKILL.md` exists outside the allowed skill surface;
- upstream manifest paths exist;
- license files exist;
- the spec-kit archive hash matches the recorded manifest.

This release installs 23 skills. Retained gstack-derived skills are installed with the `gstack-` prefix: `gstack-qa` and `gstack-ship`.
