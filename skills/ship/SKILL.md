---
name: gstack-ship
version: 0.2.0-merlin
description: Merlin-adapted ship gate for spec-kit/create-goal work. Use when implementation and QA evidence are ready and the user asks to package, commit, push, release, or deploy.
---

# gstack-ship

Ship only after the spec/goal has proof. This skill is adapted from gstack ship, but it is standalone: do not call gstack runtime helpers, telemetry, review specialists, gbrain, or deploy automation unless the repo already owns that command.

## When To Use

Use when the user says the work is ready to ship, asks to create a PR, push changes, tag a release, or deploy.

Do not use when implementation is still incomplete. Route to `gstack-qa`, `tdd`, or `diagnose` first.

## Inputs

Inspect, in order:

1. User's newest ship instruction.
2. Current branch, git status, and git diff.
3. Active `specs/<feature>/GOAL.md`, `tasks.md`, `plan.md`, and `spec.md` when present.
4. Latest QA report or verification evidence.
5. Repo instructions in `AGENTS.md`, `README.md`, release docs, CI config, package scripts, and deploy docs.

## Ship Gate

Before mutating release state, verify:

1. The work matches the active spec/goal or the user explicitly scoped a diff-only ship.
2. Relevant tests and checks pass.
3. `gstack-qa` evidence exists or the user explicitly waived QA.
4. The diff contains no unrelated changes you would accidentally commit.
5. Version, changelog, release notes, and docs are updated when the repo's release policy requires them.
6. The user has allowed the requested side effect: commit, push, PR, tag, release, merge, or deploy.

If any gate fails, stop and report the blocker.

## Workflow

1. Summarize the exact diff that will ship.
2. Run the minimum relevant checks again if they are cheap.
3. Update release metadata only when appropriate for the repo.
4. Commit with explicit path selection. Never use `git add .`.
5. Push, tag, create PR, create GitHub Release, merge, or deploy only when requested or clearly part of the current repo's established ship flow.
6. Verify the remote state after pushing or releasing.

## Output

End with:

```text
Ship Result: shipped | ready-not-pushed | blocked
Commit: <sha or none>
Remote: <branch/tag/pr/release/deploy URL or none>
Verification: <commands and evidence>
Residual risk: <short list or none>
```
