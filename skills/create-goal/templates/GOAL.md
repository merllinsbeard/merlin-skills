# Goal: <feature name>

## Objective

<One paragraph describing the target outcome from spec.md.>

## Source Of Truth

- `<feature>/spec.md`: user-facing requirements and acceptance scenarios.
- `<feature>/plan.md`: technical approach, constraints, and verification strategy.
- `<feature>/tasks.md`: executable task checklist.
- `<feature>/research.md`: <include if present>.
- `<feature>/data-model.md`: <include if present>.
- `<feature>/contracts/`: <include if present>.
- `<feature>/quickstart.md`: <include if present>.
- `<constitution path>`: project gates and non-negotiables.

## Success Criteria

- <Criterion tied to a user scenario or acceptance test.>
- <Criterion tied to implementation quality or compatibility.>
- <Criterion tied to verification evidence.>

## Execution Rules

- Follow `tasks.md` in order unless the current codebase proves a safer order.
- Mark completed tasks in `tasks.md` only after verification.
- Preserve independent user-story boundaries from the spec.
- Do not expand scope beyond the spec without explicit user approval.
- Follow the constitution and project instruction files.
- Keep changes small enough to review and verify.

## Work Loop

1. Re-read this `GOAL.md`, `plan.md`, and the next unchecked task.
2. Implement the smallest coherent task batch.
3. Run relevant tests or checks.
4. Use Playwright/browser proof for user-visible web behavior.
5. Update task checkboxes and evidence.
6. Run review/QA route before ship.
7. Continue until the stop condition is met or a blocker requires the user.

## Verification

- Unit/integration checks: `<commands>`.
- Browser checks: `<commands or quickstart flow>`.
- QA/review checks: `<review/qa route>`.
- Manual acceptance: `<quickstart or acceptance scenarios>`.

## Stop Condition

Stop only when:

- all required `tasks.md` items are complete;
- all acceptance scenarios in `spec.md` are satisfied;
- required tests and browser checks pass;
- review and QA findings are resolved or explicitly accepted;
- no constitution/checklist gates remain unresolved.

## Resume Protocol

If interrupted, re-read this file, `tasks.md`, the latest test output, and latest QA/browser evidence before continuing.

