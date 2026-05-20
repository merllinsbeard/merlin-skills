# Routing Model

The central rule is skill-first, then `/goal`.

Do not start a long autonomous loop from a loose chat summary. Route the work, bind it to spec-kit artifacts, generate `GOAL.md`, then execute.

## Standard Conveyor

```text
brainstorming or to-prd
  -> spec-kit artifacts
  -> create-goal
  -> Codex /goal
  -> tdd / diagnose
  -> gstack-qa
  -> playwright-cli / playwright-skill
  -> gstack-ship
```

Most work should skip some steps. The router chooses the smallest useful chain.

Installation and refresh requests are outside the spec-to-ship conveyor. Route those to `install-merlin-skills`.

## Phase Rules

### Discovery

Use `brainstorming` when the work is ambiguous, creative, product-shaped, or UX-heavy. Use `to-prd` when conversation context needs to become a concrete product requirement. Use `zoom-out` when the codebase area is unfamiliar.

### Specification

Use spec-kit as the source of truth. The required feature artifacts are:

- `spec.md`
- `plan.md`
- `tasks.md`

### Goal Creation

Use `create-goal` only after the spec artifacts exist. It generates `GOAL.md` and stops.

### Implementation

Use `tdd` for feature work and bug fixes where tests can drive the change. Use `diagnose` when there is a hard bug, unknown failure, or performance regression.

### Verification

Use `gstack-qa` after implementation or before ship. It should read the active spec/goal, run relevant tests, use `playwright-cli` or `playwright-skill` for browser proof, fix in-scope QA bugs, and leave evidence near the feature.

Use `playwright-cli` for token-efficient browser interaction and Playwright test work. Use `playwright-skill` when a custom script is faster or more repeatable.

### Shipping

Use `gstack-ship` only after implementation and QA evidence are ready. It should package, commit, push, tag, release, PR, merge, or deploy only when that side effect is requested or established by the repo's ship flow.
