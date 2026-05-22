# Routing Model

The central rule is skill-first, then `/goal`.

Do not start a long autonomous loop from a loose chat summary. Route the work, bind it to spec-kit artifacts, generate `GOAL.md`, then execute.

## Spec Kit Consultation

Every non-trivial route starts with a short Spec Kit consultation. This is not a separate ceremony and it does not create new state files. It is the router's first pass over the current project state:

- Is `.specify/` initialized?
- Is there an active `specs/<feature>/` directory?
- Are `spec.md`, `plan.md`, and `tasks.md` present and current?
- Does `GOAL.md` already exist?
- What proof already exists: completed task checkboxes, test output, QA reports, browser screenshots, PRs, release notes?

The result is a simple decision: create, refresh, or reuse Spec Kit artifacts before selecting the next skill.

If the work is still ambiguous, use `brainstorming`, but keep Spec Kit as the target shape. Brainstorming should clarify the idea enough that the next step can produce or update `spec.md`, `plan.md`, and `tasks.md`.

## Standard Conveyor

```text
spec-kit consultation
  -> brainstorming or to-prd when useful
  -> speckit-cli/setup when needed
  -> speckit-constitution
  -> speckit-specify
  -> speckit-clarify
  -> speckit-plan
  -> speckit-tasks
  -> speckit-analyze / speckit-checklist when useful
  -> create-goal
  -> Codex /goal
  -> tdd / diagnose
  -> gstack-qa
  -> playwright-cli / playwright-skill
  -> gstack-ship
```

In that conveyor, `tdd` starts after `tasks.md` and `GOAL.md` exist. `speckit-tasks` creates the executable backlog; `tdd` is the vertical-slice implementation mode for a task or behavior, not an earlier planning phase.

Most work should skip some steps. The router chooses the smallest useful chain.

Installation and refresh requests are outside the spec-to-ship conveyor. Route Merlin pack installs to `install-merlin-skills`; route official Spec Kit CLI/project initialization to `speckit-cli`.

## Phase Rules

### Discovery

Use `brainstorming` when the work is ambiguous, creative, product-shaped, or UX-heavy. Use `to-prd` when conversation context needs to become a concrete product requirement. Use `zoom-out` when the codebase area is unfamiliar. In all three cases, first consult the existing Spec Kit artifacts so the discovery output can connect to the current feature directory or create a new one deliberately.

### Specification

Use Spec Kit as the source of truth. If `.specify/` is missing, use `speckit-cli` to initialize the official CLI and Codex integration. Then use the official generated skills:

- `speckit-constitution` for `.specify/memory/constitution.md`
- `speckit-specify` for `spec.md`
- `speckit-clarify` before planning when the spec has ambiguity
- `speckit-plan` for technical planning and optional design artifacts
- `speckit-tasks` for the executable task list
- `speckit-analyze` and `speckit-checklist` when artifact quality needs proof

The required feature artifacts before `create-goal` are:

- `spec.md`
- `plan.md`
- `tasks.md`

### Goal Creation

Use `create-goal` only after the spec artifacts exist. It generates `GOAL.md` and stops.

`speckit-implement` exists for users who explicitly want upstream Spec Kit's native implementation command. Merlin's default route remains `create-goal -> /goal`.

Progress remains in the Spec Kit artifacts: `tasks.md` checkboxes are the implementation task ledger, `GOAL.md` is the resume contract, and QA/browser proof stays next to the feature or in the repo's existing evidence location.

### Implementation

Use `tdd` for feature work and bug fixes where tests can drive the change. In Spec Kit work, start it from the current `tasks.md` implementation slice after `GOAL.md` exists; for small non-Spec-Kit fixes, a clear behavior target is enough. Use `diagnose` when there is a hard bug, unknown failure, or performance regression.

### Verification

Use `gstack-qa` after implementation or before ship. It should read the active spec/goal, run relevant tests, use `playwright-cli` or `playwright-skill` for browser proof, fix in-scope QA bugs, and leave evidence near the feature.

Use `playwright-cli` for token-efficient browser interaction and Playwright test work. Use `playwright-skill` when a custom script is faster or more repeatable.

### Shipping

Use `gstack-ship` only after implementation and QA evidence are ready. It should package, commit, push, tag, release, PR, merge, or deploy only when that side effect is requested or established by the repo's ship flow.

Use `speckit-taskstoissues` only when the user explicitly asks to create GitHub issues from `tasks.md`.
