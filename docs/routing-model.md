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
  -> gstack-review
  -> gstack-qa / gstack-qa-only
  -> playwright-cli / playwright-skill
  -> gstack-ship
```

Most work should skip some steps. The router chooses the smallest useful chain.

Installation and refresh requests are outside the spec-to-ship conveyor. Route those to `install-merlin-skills`.

## Phase Rules

### Discovery

Use `gstack-office-hours` when the user is shaping a product idea, testing whether something is worth building, or choosing a wedge. Use `brainstorming` when the work is creative or UX-heavy but not primarily a viability question. Use `zoom-out` when the codebase area is unfamiliar.

Use `gstack-plan-ceo-review` after a concrete plan exists and needs founder/scope pressure.

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

Use `gstack-review` for code review, `gstack-qa` for test-fix-verify, and `gstack-qa-only` when the user asked for a report without fixes.

Use `playwright-cli` for token-efficient browser interaction and Playwright test work. Use `playwright-skill` when a custom script is faster or more repeatable.

Use gstack browser/runtime skills when their specific loop is the shortest path: `gstack-browse` or `gstack-open-gstack-browser` for dogfooding, `gstack-health`/`gstack-benchmark`/`gstack-canary` for quality checks, `gstack-careful`/`gstack-freeze`/`gstack-guard` for safety boundaries, `gstack-context-save`/`gstack-context-restore` for handoff, `gstack-document-generate`/`gstack-document-release` for docs, `gstack-setup-deploy`/`gstack-land-and-deploy` for deploy, `gstack-setup-gbrain`/`gstack-sync-gbrain`/`gstack-learn` for gbrain, `gstack-make-pdf` for PDFs, `gstack-scrape`/`gstack-skillify` for browser extraction, and `gstack-codex`/`gstack-claude` for outside model review.

### Shipping

Use `gstack-ship` only after implementation and verification evidence are ready.
