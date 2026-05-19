# Implementation Report

Date: 2026-05-19

## Built

Created a production-quality open-source repository for a narrow autonomous web-coding stack:

```text
spec-kit -> create-goal -> Codex /goal -> review -> qa -> Playwright proof -> ship
```

The repository includes:

- `README.md` with a generated bitmap cover image and an SVG architecture image asset.
- `assets/merlin-skills-cover.png`, generated with `imagegen` using `image-taste-frontend` art direction for the public README.
- `AGENTS.md` with the skill-first and `/goal`-first routing contract.
- `skills/merlin-skills-routing` as the mandatory meta-routing skill.
- `skills/create-goal` as the only adapted upstream workflow.
- Curated upstream skills copied as snapshots.
- `vendor-snapshots/manifest.json` with source SHAs and licenses.
- `THIRD_PARTY_NOTICES.md` and license copies.
- `scripts/install-local.sh` for Codex/Claude skill roots.
- `scripts/validate-layout.sh` and `scripts/validate-manifest.mjs`.
- GitHub Actions validation workflow.
- Minimal eval scaffold in `evals/evals.json`.

## Source Decisions

### github/spec-kit

Included completely as `vendor-snapshots/archives/github-spec-kit-51e6a140e291.tar.gz`.

Why included: it is the best source-of-truth layer for `spec.md`, `plan.md`, `tasks.md`, constitution, and spec-driven coding.

Why archived: the upstream repository contains nested skill files. Extracting it into the runtime tree would risk recursive skill discovery. The archive preserves the full repo while keeping runtime clean.

### ayoubben18/ab-method

Included only as provenance plus the adapted `create-goal` skill.

Why included: its durable `GOAL.md` idea maps directly to Codex `/goal` and long autonomous loops.

Why not fully included: AB Method duplicates parts of the chosen flow and has its own structure. In this stack, spec-kit is the source of truth, so only goal creation survives.

### mattpocock/skills

Included:

- `tdd`
- `to-prd`
- `grill-with-docs`
- `diagnose`
- `zoom-out`

Why included: these skills fill real gaps around test-first implementation, PRD synthesis, plan grilling, bug diagnosis, and codebase orientation.

Why not more: additional skills would broaden the pack without improving the spec-to-goal-to-ship conveyor.

### garrytan/gstack

Included as user-facing skills:

- `review`
- `qa`
- `qa-only`
- `ship`
- `design-consultation`
- `design-html`
- `design-review`
- `design-shotgun`
- `plan-ceo-review`
- `plan-design-review`
- `plan-devex-review`
- `plan-eng-review`
- `plan-tune`

Included as compatibility runtime:

- helper scripts under `gstack-runtime/bin`, `scripts`, and `lib`;
- `browse` and `design` build sources;
- runtime-only `office-hours`, `document-release`, and `gstack-upgrade` shims because selected gstack skills reference them.

Why included: gstack provides strong review, QA, design, and ship gates after Codex has implemented against a goal.

Why not fully included: full gstack is a wider product/runtime with browser, deploy, benchmark, setup, GBrain, and control-plane concerns. This repo keeps the parts that strengthen the web-coding conveyor.

### microsoft/playwright-cli

Included `playwright-cli`.

Why included: browser proof is a first-class stop condition for web coding, and the CLI is token-efficient for agents.

### lackeyjb/playwright-skill

Included `playwright-skill`.

Why included: custom Playwright scripts are better for repeatable flows, responsive checks, screenshots, and login/state-heavy browser automation.

### obra/superpowers

Included `brainstorming` only.

Why included: it is the useful design-before-build gate for ambiguous product/UI work.

Why not fully included: the rest of Superpowers would introduce a parallel methodology. This stack already has spec-kit and routing as the main process.

## Deliberately Not Primary

The following categories were kept out of the default route:

- Hermes/OpenClaw/control boards as the main runtime;
- full multi-agent worktree managers;
- low-code agent platforms;
- SaaS starter templates;
- scraping/stealth-browser stacks;
- memory systems as source of truth.

They can be useful side tools, but they are not the default answer to "write one spec and let Codex build it."

## Verification

Passed:

```bash
npm test
SKILL_ROOT=/tmp/merlin-skills-root GSTACK_ROOT=/tmp/merlin-gstack-runtime MERLIN_SKIP_GSTACK_BUILD=1 bash scripts/install-local.sh
```

The temp install produced 23 installable skills and restored the gstack runtime shims without touching the user's real global skill roots.
