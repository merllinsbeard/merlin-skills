# create-goal And spec-kit

`create-goal` converts a spec-kit feature into a durable Codex `/goal` contract.

## Input

Required:

```text
specs/<feature>/spec.md
specs/<feature>/plan.md
specs/<feature>/tasks.md
```

Optional:

```text
specs/<feature>/research.md
specs/<feature>/data-model.md
specs/<feature>/contracts/
specs/<feature>/quickstart.md
specs/<feature>/checklists/
.specify/memory/constitution.md
```

Use the official `speckit-*` skills to create or refresh these inputs:

- `speckit-constitution`
- `speckit-specify`
- `speckit-clarify`
- `speckit-plan`
- `speckit-tasks`
- `speckit-analyze`
- `speckit-checklist`

## Output

```text
specs/<feature>/GOAL.md
```

## Why This Replaces AB Method Structure

AB Method's create-goal flow is valuable because it forces a persistent goal, progress tracker, feedback loops, and stop condition.

Spec-kit already provides the better source-of-truth structure for web coding. So this package keeps the goal contract and binds it to:

- requirements from `spec.md`;
- technical plan from `plan.md`;
- executable checklist from `tasks.md`;
- gates from constitution/checklists.

## Refusal Is A Feature

The skill should refuse to write `GOAL.md` when the spec is unclear, tasks are not executable, or gates are unresolved. A weak goal causes long autonomous work to drift.
