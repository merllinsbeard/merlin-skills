---
name: create-goal
description: Create a spec-kit-native Codex GOAL.md from an existing spec-kit feature directory. Adapted from AB Method's create-goal concept, but uses spec.md, plan.md, tasks.md, and constitution/checklist artifacts as the source of truth.
---

# Create Goal

Create a durable Codex `/goal` contract from spec-kit artifacts.

This skill is the only adapted upstream workflow in Merlin Skills. It keeps AB Method's useful idea of a persistent `GOAL.md`, but replaces AB Method project structure with spec-kit feature directories.

## When To Use

Use when:

- the user wants to run Codex `/goal`;
- a feature has `spec.md`, `plan.md`, and `tasks.md`;
- autonomous implementation needs a stop condition, verification loop, and stable source-of-truth list.

Do not use when the idea has no spec yet. Route to spec-kit or `brainstorming` first.

## Locate The Feature Directory

Find the active feature directory in this order:

1. `.specify/feature.json` field `feature_directory`;
2. environment variable `SPECIFY_FEATURE_DIRECTORY`;
3. the only or newest `specs/<feature>/` directory;
4. a branch-matching `specs/<number>-<slug>/` directory.

If multiple plausible directories exist, choose the one most clearly referenced by the user or current branch. Ask only if choosing would materially risk writing the wrong goal.

## Required Inputs

The feature directory must contain:

- `spec.md`
- `plan.md`
- `tasks.md`

Read these if present:

- `research.md`
- `data-model.md`
- `contracts/`
- `quickstart.md`
- `checklists/`
- `memory/constitution.md`
- `.specify/memory/constitution.md`

## Refusal Conditions

Do not write `GOAL.md` if:

- no feature directory can be found;
- any required input is missing;
- `spec.md` contains unresolved `[NEEDS CLARIFICATION]`;
- `plan.md` lacks a concrete technical approach or verification plan;
- `tasks.md` is not executable as a checklist;
- constitution or checklist gates are unresolved.

Report the blocking files and exact fixes needed.

## Output Path

Write or update:

```text
specs/<feature>/GOAL.md
```

Do not write a separate `docs/goals/` tree for spec-kit projects.

## GOAL.md Contract

The goal must include:

1. Title and short objective.
2. Source-of-truth artifact list with relative paths.
3. Success criteria tied to `spec.md`.
4. Execution rules tied to `tasks.md`.
5. Implementation plan summary tied to `plan.md`.
6. Verification loop: tests, quickstart, Playwright/browser proof, QA, review.
7. Progress protocol: mark tasks in `tasks.md`, keep evidence current.
8. Safety boundaries: do not change unrelated scope, preserve user-story independence, follow constitution.
9. Stop condition: all tasks complete, checks pass, acceptance scenarios satisfied, no unresolved gates.
10. Resume note: if interrupted, re-read this `GOAL.md`, `tasks.md`, and latest proof before continuing.

Use `templates/GOAL.md` as the shape. Keep it concise enough to paste into Codex `/goal`.

## Process

1. Inspect the feature directory and required artifacts.
2. Validate refusal conditions.
3. Extract objective, acceptance scenarios, constraints, tasks, and verification commands.
4. Write `GOAL.md`.
5. Stop and report the output path plus any unresolved risks.

Do not start implementation from this skill. The next step is Codex `/goal`.

