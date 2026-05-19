---
name: merlin-skills-routing
description: Mandatory meta-routing skill for Merlin Skills. Use before any non-trivial /goal or implementation task to choose the smallest skill-first chain, bind work to spec-kit artifacts, and prevent loading unrelated skills.
---

# Merlin Skills Routing

Use this skill before starting a non-trivial task, and always before creating or executing a Codex `/goal`.

Your job is to route the work to the smallest useful skill chain. Do not load every skill. Do not turn routing into a separate planning ceremony when the next skill is obvious.

## Inputs To Inspect

1. The user's newest request.
2. The current repository state and instruction files.
3. Existing spec-kit artifacts in `specs/<feature>/`.
4. Existing `GOAL.md`, test output, QA reports, browser screenshots, PRs, or release artifacts.

If there is a conflict, the user's newest request and current checkout win over old docs.

## Required Decision

Return a short routing decision before doing major work:

```text
Route: <skill -> skill -> skill>
Feature dir: <path or none>
Reason: <one sentence>
Stop condition: <what proves the route is done>
```

Then continue with the next skill or task. Do not stop after routing unless a required artifact is missing or the user asked only for a plan.

## Default Route

For new autonomous web coding:

```text
brainstorming or spec-kit -> create-goal -> /goal -> tdd -> review -> qa -> playwright-cli -> ship
```

Use `brainstorming` only when the idea is still ambiguous or creative. If the spec is already clear, skip it.

## Routing Matrix

| Signal | Route |
| --- | --- |
| "What should we build?", unclear product shape, new UI idea | `brainstorming` first |
| Existing chat context needs a PRD | `to-prd` |
| Plan needs pressure against docs, terms, ADRs | `grill-with-docs` |
| Need to understand an unfamiliar code area | `zoom-out` |
| Need a durable autonomous work contract | `create-goal` |
| Building feature or fixing bug with tests | `tdd` |
| Broken behavior, flaky tests, performance regression | `diagnose` then `tdd` |
| UI/design plan before code | `plan-design-review` |
| System/architecture plan before code | `plan-eng-review` |
| Scope, ambition, founder judgment | `plan-ceo-review` |
| Developer-facing API/CLI/docs workflow | `plan-devex-review` |
| Implemented diff needs critique | `review` |
| Web app needs bug hunt and fixes | `qa` |
| Web app needs report only | `qa-only` |
| Need live browser proof or Playwright tests | `playwright-cli` |
| Need custom browser automation script | `playwright-skill` |
| Ready to package, PR, release | `ship` |

## `/goal` Gate

Before `/goal`, require:

1. A spec-kit feature directory or explicit user approval to create one.
2. No unresolved `[NEEDS CLARIFICATION]` markers in `spec.md`.
3. `plan.md` names the technical approach and checks.
4. `tasks.md` is executable by an agent.
5. `create-goal` has produced or refreshed `GOAL.md`.

If these are not true, route to the missing step instead of launching `/goal`.

## Skill-First Rules

- Load only the next required skill file.
- Prefer spec-kit artifacts over chat memory for feature truth.
- Prefer tests, browser proof, and QA reports over confidence.
- Keep generated proof next to the feature or in the repo's existing evidence location.
- Do not rewrite upstream skills copied into this repo.
- The only repo-owned adaptation of an upstream process is `create-goal`.

