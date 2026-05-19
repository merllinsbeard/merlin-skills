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
office-hours or brainstorming or spec-kit -> create-goal -> /goal -> tdd -> review -> qa -> playwright-cli -> ship
```

Use `office-hours` when the user is testing a product idea, wedge, or whether something is worth building. Use `brainstorming` when the idea is creative/UX-heavy but not a founder/product viability question. If the spec is already clear, skip both.

## Coverage Contract

This router must cover every installed skill and every source pack. If a skill exists under `skills/<name>/SKILL.md`, it must appear in the Complete Skill Inventory below and have a routing home in the matrix or fallback rules.

Source packs:

- `github/spec-kit`: spec source of truth, not a runtime skill.
- `ayoubben18/ab-method`: adapted only as `create-goal`.
- `mattpocock/skills`: `tdd`, `to-prd`, `grill-with-docs`, `diagnose`, `zoom-out`.
- `garrytan/gstack`: full integrated gstack distribution and runtime sidecar.
- `microsoft/playwright-cli`: `playwright-cli`.
- `lackeyjb/playwright-skill`: `playwright-skill`.
- `obra/superpowers`: `brainstorming`.
- Merlin-owned meta skills: `merlin-skills-routing`, `install-merlin-skills`, `create-goal`.

Complete Skill Inventory:

- Core/meta/spec: `merlin-skills-routing`, `install-merlin-skills`, `create-goal`.
- Product/spec planning: `office-hours`, `brainstorming`, `to-prd`, `grill-with-docs`, `zoom-out`, `plan-ceo-review`, `plan-design-review`, `plan-devex-review`, `plan-eng-review`, `plan-tune`, `autoplan`.
- Build/debug/test: `tdd`, `diagnose`, `investigate`, `health`, `review`, `qa`, `qa-only`.
- Browser/proof/scrape: `playwright-cli`, `playwright-skill`, `browse`, `gstack`, `open-gstack-browser`, `setup-browser-cookies`, `scrape`, `skillify`.
- Design/UI: `design-consultation`, `design-html`, `design-review`, `design-shotgun`.
- Safety/control: `careful`, `freeze`, `guard`, `unfreeze`.
- Ship/deploy/release: `ship`, `setup-deploy`, `land-and-deploy`, `canary`, `benchmark`, `landing-report`, `document-generate`, `document-release`.
- Context/memory/runtime: `context-save`, `context-restore`, `setup-gbrain`, `sync-gbrain`, `learn`, `retro`, `make-pdf`, `pair-agent`, `gstack-upgrade`.
- Outside model wrappers: `codex`, `claude`, `benchmark-models`, `cso`.
- OpenClaw-specific gstack: `gstack-openclaw-ceo-review`, `gstack-openclaw-investigate`, `gstack-openclaw-office-hours`, `gstack-openclaw-retro`.

## Routing Matrix

| Signal | Route |
| --- | --- |
| Install, update, refresh, or project-local setup for Merlin Skills | `install-merlin-skills` |
| General "which skill should I use?" or routing request | `merlin-skills-routing` |
| Product idea, early concept, "is this worth building?" | `office-hours` first |
| Concrete product plan needs founder/scope pressure | `plan-ceo-review` |
| Run all plan reviews automatically | `autoplan` |
| Ambiguous creative feature or new UI idea | `brainstorming` first |
| Existing chat context needs a PRD | `to-prd` |
| Plan needs pressure against docs, terms, ADRs | `grill-with-docs` |
| Need to understand an unfamiliar code area | `zoom-out` |
| Need a durable autonomous work contract | `create-goal` |
| Building feature or fixing bug with tests | `tdd` |
| Broken behavior, flaky tests, performance regression | `diagnose` then `tdd` |
| Root-cause investigation with gstack workflow | `investigate` |
| Code health dashboard | `health` |
| UI/design plan before code | `plan-design-review` |
| Design system or product design consultation | `design-consultation` |
| Generate or finalize HTML design artifact | `design-html` |
| Visual/UI QA and design critique | `design-review` |
| Multiple design variants or comparison board | `design-shotgun` |
| System/architecture plan before code | `plan-eng-review` |
| Scope, ambition, founder judgment after plan exists | `plan-ceo-review` |
| Developer-facing API/CLI/docs workflow | `plan-devex-review` |
| Live developer-experience audit | `devex-review` |
| Tune gstack question sensitivity | `plan-tune` |
| Implemented diff needs critique | `review` |
| Web app needs bug hunt and fixes | `qa` |
| Web app needs report only | `qa-only` |
| Need live browser proof or Playwright tests | `playwright-cli` |
| Need custom browser automation script | `playwright-skill` |
| Browser dogfooding, screenshots, or page interaction | `browse`, `gstack`, or `open-gstack-browser` |
| Browser needs real user cookies | `setup-browser-cookies` |
| Safety guardrails or edit boundary | `careful`, `freeze`, `guard`, or `unfreeze` |
| Health, performance, benchmark, or post-deploy canary | `health`, `benchmark`, or `canary` |
| Compare model behavior or benchmark prompts | `benchmark-models` |
| Save or restore work context | `context-save` or `context-restore` |
| Generate or sync documentation | `document-generate` or `document-release` |
| Deploy configuration or land-and-deploy flow | `setup-deploy` then `land-and-deploy` |
| Landing queue or release slot report | `landing-report` |
| GBrain setup, repo sync, or learnings | `setup-gbrain`, `sync-gbrain`, or `learn` |
| Weekly or periodic engineering retro | `retro` |
| Publication-quality PDF export | `make-pdf` |
| Browser scraping or permanent scrape skill | `scrape` then `skillify` |
| Pair a remote agent with the browser | `pair-agent` |
| Upgrade gstack runtime itself | `gstack-upgrade` |
| Outside model review or challenge | `codex` or `claude` |
| Security audit or CSO-mode review | `cso` |
| OpenClaw CEO review | `gstack-openclaw-ceo-review` |
| OpenClaw investigation | `gstack-openclaw-investigate` |
| OpenClaw office hours | `gstack-openclaw-office-hours` |
| OpenClaw retro | `gstack-openclaw-retro` |
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
