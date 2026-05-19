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
gstack-office-hours or brainstorming or spec-kit -> create-goal -> /goal -> tdd -> gstack-review -> gstack-qa -> playwright-cli -> gstack-ship
```

Use `gstack-office-hours` when the user is testing a product idea, wedge, or whether something is worth building. Use `brainstorming` when the idea is creative/UX-heavy but not a founder/product viability question. If the spec is already clear, skip both.

## Coverage Contract

This router must cover every installed skill and every source pack. If a skill exists under `skills/<name>/SKILL.md`, its install-facing skill name must appear in the Complete Skill Inventory below and have a routing home in the matrix or fallback rules.

Install-name rule: every gstack-derived skill is installed with a `gstack-` prefix to avoid collisions with other packs. Source snapshot paths stay unprefixed where upstream uses them, and `$GSTACK_ROOT` keeps upstream runtime directories such as `review/`, `qa/`, and `office-hours/`.

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
- Product/spec planning: `gstack-office-hours`, `brainstorming`, `to-prd`, `grill-with-docs`, `zoom-out`, `gstack-plan-ceo-review`, `gstack-plan-design-review`, `gstack-plan-devex-review`, `gstack-plan-eng-review`, `gstack-plan-tune`, `gstack-autoplan`.
- Build/debug/test: `tdd`, `diagnose`, `gstack-investigate`, `gstack-health`, `gstack-review`, `gstack-qa`, `gstack-qa-only`.
- Browser/proof/scrape: `playwright-cli`, `playwright-skill`, `gstack-browse`, `gstack`, `gstack-open-gstack-browser`, `gstack-setup-browser-cookies`, `gstack-scrape`, `gstack-skillify`.
- Design/UI: `gstack-design-consultation`, `gstack-design-html`, `gstack-design-review`, `gstack-design-shotgun`.
- Safety/control: `gstack-careful`, `gstack-freeze`, `gstack-guard`, `gstack-unfreeze`.
- Ship/deploy/release: `gstack-ship`, `gstack-setup-deploy`, `gstack-land-and-deploy`, `gstack-canary`, `gstack-benchmark`, `gstack-landing-report`, `gstack-document-generate`, `gstack-document-release`.
- Context/memory/runtime: `gstack-context-save`, `gstack-context-restore`, `gstack-setup-gbrain`, `gstack-sync-gbrain`, `gstack-learn`, `gstack-retro`, `gstack-make-pdf`, `gstack-pair-agent`, `gstack-upgrade`.
- Outside model wrappers: `gstack-codex`, `gstack-claude`, `gstack-benchmark-models`, `gstack-cso`.
- OpenClaw-specific gstack: `gstack-openclaw-ceo-review`, `gstack-openclaw-investigate`, `gstack-openclaw-office-hours`, `gstack-openclaw-retro`.

## Routing Matrix

| Signal | Route |
| --- | --- |
| Install, update, refresh, or project-local setup for Merlin Skills | `install-merlin-skills` |
| General "which skill should I use?" or routing request | `merlin-skills-routing` |
| Product idea, early concept, "is this worth building?" | `gstack-office-hours` first |
| Concrete product plan needs founder/scope pressure | `gstack-plan-ceo-review` |
| Run all plan reviews automatically | `gstack-autoplan` |
| Ambiguous creative feature or new UI idea | `brainstorming` first |
| Existing chat context needs a PRD | `to-prd` |
| Plan needs pressure against docs, terms, ADRs | `grill-with-docs` |
| Need to understand an unfamiliar code area | `zoom-out` |
| Need a durable autonomous work contract | `create-goal` |
| Building feature or fixing bug with tests | `tdd` |
| Broken behavior, flaky tests, performance regression | `diagnose` then `tdd` |
| Root-cause investigation with gstack workflow | `gstack-investigate` |
| Code health dashboard | `gstack-health` |
| UI/design plan before code | `gstack-plan-design-review` |
| Design system or product design consultation | `gstack-design-consultation` |
| Generate or finalize HTML design artifact | `gstack-design-html` |
| Visual/UI QA and design critique | `gstack-design-review` |
| Multiple design variants or comparison board | `gstack-design-shotgun` |
| System/architecture plan before code | `gstack-plan-eng-review` |
| Scope, ambition, founder judgment after plan exists | `gstack-plan-ceo-review` |
| Developer-facing API/CLI/docs workflow | `gstack-plan-devex-review` |
| Live developer-experience audit | `gstack-devex-review` |
| Tune gstack question sensitivity | `gstack-plan-tune` |
| Implemented diff needs critique | `gstack-review` |
| Web app needs bug hunt and fixes | `gstack-qa` |
| Web app needs report only | `gstack-qa-only` |
| Need live browser proof or Playwright tests | `playwright-cli` |
| Need custom browser automation script | `playwright-skill` |
| Browser dogfooding, screenshots, or page interaction | `gstack-browse`, `gstack`, or `gstack-open-gstack-browser` |
| Browser needs real user cookies | `gstack-setup-browser-cookies` |
| Safety guardrails or edit boundary | `gstack-careful`, `gstack-freeze`, `gstack-guard`, or `gstack-unfreeze` |
| Health, performance, benchmark, or post-deploy canary | `gstack-health`, `gstack-benchmark`, or `gstack-canary` |
| Compare model behavior or benchmark prompts | `gstack-benchmark-models` |
| Save or restore work context | `gstack-context-save` or `gstack-context-restore` |
| Generate or sync documentation | `gstack-document-generate` or `gstack-document-release` |
| Deploy configuration or land-and-deploy flow | `gstack-setup-deploy` then `gstack-land-and-deploy` |
| Landing queue or release slot report | `gstack-landing-report` |
| GBrain setup, repo sync, or learnings | `gstack-setup-gbrain`, `gstack-sync-gbrain`, or `gstack-learn` |
| Weekly or periodic engineering retro | `gstack-retro` |
| Publication-quality PDF export | `gstack-make-pdf` |
| Browser scraping or permanent scrape skill | `gstack-scrape` then `gstack-skillify` |
| Pair a remote agent with the browser | `gstack-pair-agent` |
| Upgrade gstack runtime itself | `gstack-upgrade` |
| Outside model review or challenge | `gstack-codex` or `gstack-claude` |
| Security audit or CSO-mode review | `gstack-cso` |
| OpenClaw CEO review | `gstack-openclaw-ceo-review` |
| OpenClaw investigation | `gstack-openclaw-investigate` |
| OpenClaw office hours | `gstack-openclaw-office-hours` |
| OpenClaw retro | `gstack-openclaw-retro` |
| Ready to package, PR, release | `gstack-ship` |

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
