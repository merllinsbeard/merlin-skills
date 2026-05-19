# Implementation Report

Date: 2026-05-19

## Built

Created a production-quality open-source repository for a narrow autonomous web-coding stack:

```text
gstack-office-hours -> spec-kit -> create-goal -> Codex /goal -> gstack-review -> gstack-qa -> Playwright proof -> gstack-ship
```

The repository includes:

- `README.md` with a generated bitmap cover image and an SVG architecture image asset.
- `assets/merlin-skills-cover.png`, generated with `imagegen` using `image-taste-frontend` art direction for the public README.
- `AGENTS.md` with the skill-first and `/goal`-first routing contract.
- `skills/merlin-skills-routing` as the mandatory meta-routing skill.
- `skills/install-merlin-skills` as the global/project installation meta skill.
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

As of v0.1.3, included fully:

- all generic gstack skills;
- `gstack-codex` and `gstack-claude` wrappers on the install surface;
- root `gstack` browser skill;
- OpenClaw-specific gstack skills;
- full curated `gstack-runtime` sidecar for browser, design, PDF, QA, review, docs, safety, GBrain, deploy, and upgrade helpers.

Why included: gstack is the strongest adjacent runtime for browser dogfooding, review, QA, shipping, deployment, documentation, context handoff, safety guardrails, and memory/proof workflows around Codex.

Why still routed narrowly: full availability should not turn every task into full process. `merlin-skills-routing` keeps the default spec-to-goal conveyor small and only routes to extra gstack skills when they are the shortest useful loop.

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

As of v0.1.2, the temp install produces 25 installable skills and restores the gstack runtime shims without touching the user's real global skill roots.

## v0.1.2 Update

Added `install-merlin-skills`, a repo-owned setup meta skill modeled after Matt Pocock's setup pattern. It chooses global Codex, global Claude, both global, project Codex, project Claude, or custom roots, then delegates the actual copy/build work to `scripts/install-local.sh`.

Why included: installation is now part of the public operating model. The package can be installed globally for personal runtime use or project-locally when a repository should carry its own skill surface.

Why repo-owned: no upstream skill owns Merlin Skills distribution, gstack runtime compatibility, or the project instruction block policy.

For v0.1.2, the expected temp install count was 25 installable skills.

## v0.1.3 Update

Fully integrated gstack into Merlin Skills.

Added all generic gstack skills, `gstack-codex`/`gstack-claude` install-facing wrappers, root `gstack`, and OpenClaw-specific gstack skills. Expanded `gstack-runtime` from selected compatibility helpers into a full curated sidecar. Removed runtime-only `SKILL.runtime.md` shims; installer now restores runtime `SKILL.md` files by overlaying top-level `skills/<name>/SKILL.md`.

Why included: after `v0.1.2`, the package had a clean installer and meta-routing layer. Full gstack makes the public repo a complete skill distribution instead of a partial subset, while still letting the router keep normal `/goal` work narrow.

The expected temp install count is now 63 installable skills.

## v0.1.4 Update

Namespaced all gstack-derived user-facing skills during install.

The source snapshot directories stay close to upstream, but `scripts/install-local.sh` now installs gstack skills into the selected `SKILL_ROOT` with `gstack-` names such as `gstack-review`, `gstack-qa`, `gstack-office-hours`, `gstack-codex`, and `gstack-plan-ceo-review`. Already-prefixed upstream skills keep their names, and the root `gstack` skill remains the namespace entrypoint.

The runtime sidecar still uses upstream unprefixed directories under `$GSTACK_ROOT` (`review/`, `qa/`, `office-hours/`, etc.) because upstream gstack skill files and helper scripts depend on those paths. The installer patches installed `name:` frontmatter and sets `skill_prefix=true` so the routing layer and the installed skills agree.

Validation now checks `merlin-skills-routing` against install-facing skill names, not just source directory names.
