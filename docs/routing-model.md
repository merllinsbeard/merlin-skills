# Routing Model

The central rule is skill-first, then `/goal`.

Do not start a long autonomous loop from a loose chat summary. Route the work, bind it to spec-kit artifacts, generate `GOAL.md`, then execute.

## Standard Conveyor

```text
brainstorming
  -> office-hours for product viability when needed
  -> spec-kit artifacts
  -> create-goal
  -> Codex /goal
  -> tdd / diagnose
  -> review
  -> qa / qa-only
  -> playwright-cli / playwright-skill
  -> ship
```

Most work should skip some steps. The router chooses the smallest useful chain.

Installation and refresh requests are outside the spec-to-ship conveyor. Route those to `install-merlin-skills`.

## Phase Rules

### Discovery

Use `office-hours` when the user is shaping a product idea, testing whether something is worth building, or choosing a wedge. Use `brainstorming` when the work is creative or UX-heavy but not primarily a viability question. Use `zoom-out` when the codebase area is unfamiliar.

Use `plan-ceo-review` after a concrete plan exists and needs founder/scope pressure.

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

Use `review` for code review, `qa` for test-fix-verify, and `qa-only` when the user asked for a report without fixes.

Use `playwright-cli` for token-efficient browser interaction and Playwright test work. Use `playwright-skill` when a custom script is faster or more repeatable.

### Shipping

Use `ship` only after implementation and verification evidence are ready.
