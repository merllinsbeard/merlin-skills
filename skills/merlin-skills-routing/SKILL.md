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

For autonomous web coding:

```text
brainstorming or to-prd -> spec-kit -> create-goal -> /goal -> tdd -> gstack-qa -> playwright-cli -> gstack-ship
```

Use `brainstorming` for ambiguous product/UI shaping. Use `to-prd` when a conversation needs to become a product requirement. If the spec is already clear, skip both.

## Coverage Contract

This router must cover every installed skill and every source pack. If a skill exists under `skills/<name>/SKILL.md`, its install-facing skill name must appear in the Complete Skill Inventory below and have a routing home in the matrix or fallback rules.

Install-name rule: retained gstack-derived skills are installed with a `gstack-` prefix. This release intentionally keeps only `gstack-qa` and `gstack-ship`; the rest of gstack is out of the default stack.

Source packs:

- `github/spec-kit`: spec source of truth, not a runtime skill.
- `ayoubben18/ab-method`: adapted only as `create-goal`.
- `mattpocock/skills`: `tdd`, `to-prd`, `grill-with-docs`, `diagnose`, `zoom-out`.
- `garrytan/gstack`: only adapted `gstack-qa` and `gstack-ship`.
- `microsoft/playwright-cli`: `playwright-cli`.
- `lackeyjb/playwright-skill`: `playwright-skill`.
- `obra/superpowers`: `brainstorming`.
- Merlin-owned meta skills: `merlin-skills-routing`, `install-merlin-skills`, `create-goal`.

Complete Skill Inventory:

- Core/meta/spec: `merlin-skills-routing`, `install-merlin-skills`, `create-goal`.
- Product/spec planning: `brainstorming`, `to-prd`, `grill-with-docs`, `zoom-out`.
- Build/debug/test: `tdd`, `diagnose`, `gstack-qa`.
- Browser proof: `playwright-cli`, `playwright-skill`.
- Ship/release: `gstack-ship`.

## Routing Matrix

| Signal | Route |
| --- | --- |
| Install, update, refresh, or project-local setup for Merlin Skills | `install-merlin-skills` |
| General "which skill should I use?" or routing request | `merlin-skills-routing` |
| Ambiguous creative feature or new UI idea | `brainstorming` first |
| Existing chat context needs a PRD | `to-prd` |
| Plan needs pressure against docs, terms, ADRs | `grill-with-docs` |
| Need to understand an unfamiliar code area | `zoom-out` |
| Need a durable autonomous work contract | `create-goal` |
| Building feature or fixing bug with tests | `tdd` |
| Broken behavior, flaky tests, performance regression | `diagnose` then `tdd` |
| Web app or feature needs QA and evidence | `gstack-qa` |
| Need live browser proof or Playwright tests | `playwright-cli` |
| Need custom browser automation script | `playwright-skill` |
| Ready to package, commit, push, PR, tag, release, or deploy | `gstack-ship` |

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
- Do not reintroduce gstack skills outside `gstack-qa` and `gstack-ship` unless the source-selection policy is intentionally changed.
- The repo-owned adaptations are `create-goal`, `gstack-qa`, and `gstack-ship`.
