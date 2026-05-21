---
name: merlin-skills-routing
description: Mandatory meta-routing skill for Merlin Skills. Use before any non-trivial /goal or implementation task to choose the smallest skill-first chain, bind work to Spec Kit artifacts, and prevent loading unrelated skills.
---

# Merlin Skills Routing

Use this skill before non-trivial implementation work, and always before creating or executing a Codex `/goal`.

Your job is to identify the current development phase and load only the next useful skill. Keep routing short. Do not load every skill and do not turn routing into a separate planning ceremony when the next step is obvious.

## Spec Kit Consultation Pass

For every non-trivial request, do a short Spec Kit consultation before choosing the next skill.

Inspect whether the current work already has:

- `.specify/` project infrastructure;
- an active `specs/<feature>/` directory;
- current `spec.md`, `plan.md`, and `tasks.md`;
- an existing `GOAL.md`;
- completed task checkboxes, QA reports, browser proof, PRs, or release artifacts.

Then decide whether the next step should create, refresh, or reuse Spec Kit artifacts. This pass is mandatory even when the next visible skill is `brainstorming`, `to-prd`, `tdd`, `diagnose`, `gstack-qa`, or `gstack-ship`.

If the idea is ambiguous or product-shaped, route to `brainstorming`, but keep Spec Kit as the destination: the design output should be concrete enough to become `spec.md`, `plan.md`, and `tasks.md`.

## Inputs To Inspect

1. The user's newest request.
2. The current repository state and instruction files.
3. Existing Spec Kit infrastructure in `.specify/`.
4. Existing Spec Kit artifacts in `specs/<feature>/`.
5. Existing `GOAL.md`, test output, QA reports, browser screenshots, PRs, or release artifacts.

If there is a conflict, the user's newest request and current checkout win over old docs.

## Required Decision

Return a short routing decision before doing major work:

```text
Phase: <current phase>
Spec Kit consultation: create | refresh | reuse | not applicable, with one short reason
Next skill: <one skill or /goal>
Feature dir: <path or none>
Why: <one sentence>
Required proof: <what proves this phase is done>
```

Then continue with the next skill or task. Do not stop after routing unless a required artifact is missing or the user asked only for a plan.

## Default Route

For autonomous web coding:

```text
spec-kit consultation
  -> brainstorming or to-prd when useful
  -> speckit-cli/setup
  -> speckit-constitution
  -> speckit-specify
  -> speckit-clarify
  -> speckit-plan
  -> speckit-tasks
  -> speckit-analyze/checklist
  -> create-goal
  -> /goal
  -> tdd/diagnose
  -> gstack-qa
  -> playwright-cli/playwright-skill
  -> gstack-ship
```

Compact form:

```text
spec-kit consultation -> brainstorming or to-prd -> speckit-cli/setup -> speckit-constitution -> speckit-specify -> speckit-clarify -> speckit-plan -> speckit-tasks -> speckit-analyze/checklist -> create-goal -> /goal -> tdd/diagnose -> gstack-qa -> playwright-cli/playwright-skill -> gstack-ship
```

Most work skips some phases. If `.specify/`, `spec.md`, `plan.md`, `tasks.md`, or `GOAL.md` already exists and is current, route to the first missing or stale phase.
The durable progress layer remains Spec Kit-native: `tasks.md` checkboxes track task completion, `GOAL.md` defines the resume protocol, and QA/browser proof lives next to the feature or in the repo's existing evidence location.

## Phase Router

| Phase | User situation | Use this skill | Requires | Produces | Stop or skip condition |
| --- | --- | --- | --- | --- | --- |
| Pack install | Install, update, refresh, or project-local setup for Merlin Skills | `install-merlin-skills` | Target root or reasonable default | Installed pack and optional instruction block | Skip for normal feature work |
| Spec Kit setup | Need `.specify/`, `specify` CLI, Codex `$speckit-*` skills, integrations, extensions, or presets | `speckit-cli` | Repo target and permission to initialize | `.specify/`, `.agents/skills/speckit-*`, managed context | Skip when `.specify/` and needed skills already exist |
| Product shaping | Ambiguous product idea, early UX concept, or "is this worth building?" | `brainstorming` | User intent and repo context | Approved design direction | Skip when the requested behavior is already concrete |
| PRD synthesis | Existing conversation needs to become a PRD or issue | `to-prd` | Enough conversation/repo context | PRD-style requirements | Skip when Spec Kit `spec.md` already covers the requirement |
| Context map | Unfamiliar code area needs a broader map | `zoom-out` | Code area or topic | Module/context map | Skip when the implementer already knows the area |
| Constitution | Project principles are missing or stale | `speckit-constitution` | `.specify/` initialized | `.specify/memory/constitution.md` | Skip when current principles are good enough |
| Feature spec | Need to create or update requirements from natural language | `speckit-specify` | `.specify/` initialized and feature description | `specs/<feature>/spec.md` | Skip when `spec.md` is current |
| Spec clarification | Spec has ambiguity, `[NEEDS CLARIFICATION]`, or high-risk assumptions | `speckit-clarify` | Active `spec.md` | Clarifications written into the spec | Skip only for explicit spikes or trivial changes |
| Technical plan | Need implementation approach, research, data model, contracts, or quickstart | `speckit-plan` | Active clarified `spec.md` | `plan.md` plus optional design artifacts | Skip when `plan.md` is current |
| Plan pressure | Need to challenge terminology, ADRs, docs, or domain assumptions | `grill-with-docs` | Draft plan and project docs | Sharpened decisions/docs | Skip when the plan is routine and grounded |
| Tasks | Need executable implementation checklist | `speckit-tasks` | `spec.md` and `plan.md` | `tasks.md` | Skip when `tasks.md` is current and agent-runnable |
| Requirements checks | Need requirement-quality checklist | `speckit-checklist` | Active feature artifacts | Checklist under feature artifacts | Optional; skip for small low-risk changes |
| Artifact audit | Need cross-artifact consistency before goal or implementation | `speckit-analyze` | `spec.md`, `plan.md`, `tasks.md` | Non-destructive consistency report | Skip when artifacts are tiny and obviously aligned |
| GitHub issues | User explicitly wants tasks converted to GitHub issues | `speckit-taskstoissues` | GitHub auth/MCP and `tasks.md` | GitHub issues | Never default; it has external side effects |
| Goal contract | Need durable Codex `/goal` contract | `create-goal` | Clear `spec.md`, `plan.md`, `tasks.md` | `specs/<feature>/GOAL.md` | Required before long `/goal` work |
| Native upstream implementation | User explicitly wants Spec Kit native implementation instead of Merlin `/goal` | `speckit-implement` | Complete Spec Kit artifacts and approval to execute | Implementation driven by upstream tasks | Non-default; prefer `create-goal -> /goal` |
| Autonomous execution | Goal exists and user wants Codex to work until done | `/goal` | Current `GOAL.md` | Implemented tasks and verification | Do not launch from loose chat summary |
| Test-first build | Building a feature or normal bug fix with tests | `tdd` | Goal/tasks or clear requirement | Tested implementation | Skip for read-only review/analysis |
| Hard diagnosis | Broken behavior, flaky test, unknown failure, performance regression | `diagnose` | Repro target or failing signal | Root cause, fix, regression test | Route back to `tdd` for implementation if needed |
| QA gate | Implementation exists and needs proof or fixes before ship | `gstack-qa` | Active spec/goal and runnable app/checks | QA report, tests, browser evidence, in-scope fixes | Required before ship for web work |
| Browser proof | Need live browser interaction, screenshots, or Playwright tests | `playwright-cli` | URL/dev server or browser target | Browser proof and optional generated tests | Use before ship when UI/user flow changed |
| Custom browser automation | Browser workflow needs loops, login setup, screenshots, or reusable logic | `playwright-skill` | URL/dev server and scenario | Custom Playwright script/evidence | Use only when CLI steps are not enough |
| Ship | Ready to commit, push, PR, tag, release, merge, or deploy | `gstack-ship` | QA evidence and explicit ship intent | Shipped artifact/PR/release/deploy | Do not use before implementation and QA evidence |

## `/goal` Gate

Before `/goal`, require:

1. A Spec Kit feature directory or explicit user approval to create one.
2. No unresolved `[NEEDS CLARIFICATION]` markers in `spec.md`.
3. `plan.md` names the technical approach and checks.
4. `tasks.md` is executable by an agent.
5. `create-goal` has produced or refreshed `GOAL.md`.

If these are not true, route to the missing step instead of launching `/goal`.

## Skill Cards

### `merlin-skills-routing`

Use before non-trivial implementation work and always before `/goal`. Requires the newest user request and current repo state. Produces the next phase decision. Do not use as a long planning ceremony.

### `install-merlin-skills`

Use when installing, updating, or vendoring this pack into Codex, Claude, or a project-local skill root. Requires a target root or clear default. Produces installed skills and optional `AGENTS.md`/`CLAUDE.md` block. Do not use for feature work.

### `speckit-cli`

Use when installing or running the official `specify` CLI, initializing `.specify/`, or managing Spec Kit integrations/extensions/presets. Requires permission to mutate project setup. Produces the Spec Kit project infrastructure. Do not use for writing an already-initialized feature spec.

### `brainstorming`

Use when the product direction, UX, or feature shape is still ambiguous. Requires user intent and repo context. Produces an approved design direction. Do not use when the requested behavior is already concrete.

### `to-prd`

Use when existing conversation context should become product requirements or an issue. Requires enough context to synthesize without interviewing. Produces a PRD-style requirement. Do not use when `speckit-specify` is the better source-of-truth path.

### `zoom-out`

Use when the code area is unfamiliar and the agent needs a map before edits. Requires a topic or area. Produces module/context orientation. Do not use as a substitute for implementation.

### `speckit-constitution`

Use to create or refresh `.specify/memory/constitution.md`. Requires initialized Spec Kit infrastructure. Produces project principles for later specs and plans.

### `speckit-specify`

Use to create or update `specs/<feature>/spec.md` from natural-language requirements. Requires `.specify/` and a feature description. Produces the feature spec.

### `speckit-clarify`

Use before planning when requirements are underspecified. Requires a feature spec. Produces recorded clarifications. Do not skip if `[NEEDS CLARIFICATION]` remains.

### `speckit-plan`

Use to create the technical plan and optional design artifacts. Requires a clarified spec. Produces `plan.md`, plus optional `research.md`, `data-model.md`, `contracts/`, and `quickstart.md`.

### `grill-with-docs`

Use to pressure-test a plan against project docs, domain language, and ADRs. Requires a draft plan and docs. Produces sharper decisions. Do not use when no meaningful decision is open.

### `speckit-tasks`

Use to convert spec and plan into executable work. Requires current `spec.md` and `plan.md`. Produces `tasks.md`.

### `speckit-checklist`

Use to generate requirement-quality checklists. Requires active feature artifacts. Produces checklist files. Optional for small changes.

### `speckit-analyze`

Use after tasks to check consistency across spec, plan, and tasks. Requires all three artifacts. Produces a non-destructive analysis. Prefer it before `create-goal` on non-trivial work.

### `speckit-taskstoissues`

Use only when the user explicitly wants GitHub issues from `tasks.md`. Requires GitHub capability and approval for external side effects. Produces issues.

### `create-goal`

Use to generate `GOAL.md` from Spec Kit artifacts. Requires clear `spec.md`, `plan.md`, and `tasks.md`. Produces a durable `/goal` contract. Do not start implementation from this skill.

### `speckit-implement`

Use only when the user explicitly wants upstream Spec Kit native implementation. Requires complete artifacts and approval to execute. Produces implementation directly from `tasks.md`. Merlin's default is `create-goal -> /goal` instead.

### `tdd`

Use for feature work and normal bug fixes where tests can drive the change. Requires a behavior target. Produces tested code.

### `diagnose`

Use for hard bugs, unknown failures, flaky tests, or performance regressions. Requires a repro or failing signal. Produces root cause, fix direction, and regression coverage.

### `gstack-qa`

Use after implementation or before ship. Requires active spec/goal and runnable checks. Produces QA evidence and in-scope fixes.

### `playwright-cli`

Use for token-efficient browser interaction, screenshots, and Playwright test workflow. Requires a URL or browser target. Produces browser proof.

### `playwright-skill`

Use when browser proof needs custom scripting or repeatable automation. Requires a scenario. Produces a Playwright script and evidence.

### `gstack-ship`

Use when implementation and QA evidence are ready and the user asks to package, commit, push, PR, tag, release, merge, or deploy. Requires explicit ship intent.

## Skill-First Rules

- Load only the next required skill file.
- Prefer Spec Kit artifacts over chat memory for feature truth.
- Prefer tests, browser proof, and QA reports over confidence.
- Keep generated proof next to the feature or in the repo's existing evidence location.
- Keep gstack limited to `gstack-qa` and `gstack-ship` unless the source-selection policy is intentionally changed.
- Keep upstream-generated `speckit-*` skills close to GitHub Spec Kit. Merlin-owned adaptations are `speckit-cli`, `create-goal`, `gstack-qa`, and `gstack-ship`.
