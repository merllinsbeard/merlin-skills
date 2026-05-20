---
name: gstack-qa
version: 0.2.0-merlin
description: Merlin-adapted QA gate for spec-kit/create-goal web coding. Use after implementation or before ship to verify behavior, run tests, collect browser proof, and fix in-scope bugs.
---

# gstack-qa

Run the smallest rigorous QA loop for the active spec/goal. This skill is adapted from gstack QA, but it is standalone: do not call gstack runtime helpers, telemetry, browser daemons, review specialists, or gbrain.

## When To Use

Use after implementation, before `gstack-ship`, or when the user asks whether the web app works.

Do not use as a replacement for `tdd` during implementation. If there is no implemented surface yet, route back to `tdd` or `create-goal`.

## Inputs

Inspect, in order:

1. User's newest request and stated QA scope.
2. `specs/<feature>/GOAL.md`, then `tasks.md`, `plan.md`, and `spec.md` when present.
3. Existing test commands in `package.json`, `Makefile`, CI config, README, `AGENTS.md`, or repo-local docs.
4. Current git diff and recently changed files.
5. Existing QA reports, screenshots, Playwright traces, or release notes.

If the spec or goal is missing but the user wants autonomous QA for a feature, ask to run `create-goal` first unless the user explicitly says to QA the current diff only.

## QA Loop

1. Define the acceptance checklist from the spec/goal. Keep it short and concrete.
2. Run the repo's relevant automated checks. Prefer existing scripts over inventing new commands.
3. For web behavior, use `playwright-cli` first. Use `playwright-skill` only when a reusable script is more appropriate.
4. Classify each finding as blocker, functional bug, regression risk, visual issue, or test gap.
5. Fix only in-scope bugs when the user asked for QA-and-fix. Keep fixes small and rerun the failing check after each fix.
6. Do not expand product scope during QA. If the spec is wrong or incomplete, report the spec gap instead of silently changing behavior.
7. Stop when all acceptance checks pass or when a blocker requires external input.

## Evidence

Write or update a compact QA note next to the active feature when there is a spec directory:

```text
specs/<feature>/qa-report.md
```

If there is no spec directory, report inline or use the repo's existing QA/report location.

The report should include:

- scope tested;
- commands run;
- browser flows checked;
- bugs found and fixed;
- remaining risks or missing coverage;
- final ship recommendation.

## Output

End with:

```text
QA Result: pass | pass-with-risks | blocked | fail
Evidence: <tests/browser/report paths>
Ship readiness: yes | no | needs user decision
```
