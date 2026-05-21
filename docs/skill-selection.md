# Skill Selection

This package is intentionally opinionated. The included skills serve one process:

```text
consult Spec Kit state -> write spec once -> generate goal -> let Codex execute -> prove -> ship
```

The consultation step is mandatory for non-trivial work. It checks whether the project already has `.specify/`, active feature artifacts, a generated `GOAL.md`, task progress, and proof. It does not add a separate project-management layer.

## Included

### Merlin-owned meta skills

Included:

- `merlin-skills-routing`: mandatory smallest-chain router before non-trivial `/goal` work.
- `install-merlin-skills`: installer router for global Codex/Claude roots and project-local `.codex/skills` or `.claude/skills` roots.
- `speckit-cli`: official GitHub Spec Kit `specify` CLI setup and maintenance wrapper.

These are repo-owned because they define how this distribution is selected and installed. They are not upstream snapshots.

`merlin-skills-routing` must always make the first Spec Kit decision: create, refresh, or reuse the current artifacts. If it routes to `brainstorming`, that is still a Spec Kit-bound discovery step, not an open-ended planning mode.

### github/spec-kit

Included completely as a source archive and as official generated Codex skills:

- `speckit-constitution`
- `speckit-specify`
- `speckit-clarify`
- `speckit-plan`
- `speckit-tasks`
- `speckit-analyze`
- `speckit-checklist`
- `speckit-taskstoissues`
- `speckit-implement`

These provide the canonical spec-driven structure and should remain the main planning substrate.

Default use:

- use `speckit-cli` to install or initialize the official CLI/integration;
- use `speckit-constitution`, `speckit-specify`, `speckit-clarify`, `speckit-plan`, and `speckit-tasks` to create the artifacts;
- use `speckit-analyze` and `speckit-checklist` as quality gates;
- use `create-goal` and Codex `/goal` for Merlin's default implementation path.

`speckit-implement` is included for upstream completeness but is not the default Merlin implementation path. `speckit-taskstoissues` is included but should only run when the user explicitly wants GitHub issues.

Not included by default: `speckit-git-*` extension skills. Git side effects should stay explicit and are already covered by repo git rules and `gstack-ship`.

### AB Method create-goal

Included only as an adapted idea. The original AB Method has its own structure and overlapping skills. Merlin Skills keeps the durable goal contract concept and rewrites it for spec-kit.

### Matt Pocock skills

Included:

- `tdd`: implementation should be testable through behavior.
- `to-prd`: useful when the conversation needs to become an issue/PRD.
- `grill-with-docs`: useful for pressure-testing plans against existing project language.
- `diagnose`: strong bug/performance regression loop.
- `zoom-out`: cheap way to force a higher-level codebase map.

Not included from the same repository when it duplicates the selected route or does not strengthen this specific conveyor.

### gstack

Included only as adapted minimal gates:

- `gstack-qa`
- `gstack-ship`

Why included: this stack needs a strong post-implementation QA gate and a final ship gate. The rest of gstack is too much process for the core Merlin loop.

Not included: office hours, CEO review, browser daemon, deploy helpers, GBrain, benchmark/canary, OpenClaw-specific workflows, model wrappers, PDF, scraping, context save/restore, and full review-army flows. Those are useful in standalone gstack, but they pull the package away from the `speckit-* -> create-goal -> /goal` center.

### Playwright

Included:

- `playwright-cli`: fast CLI-based browser control and test workflow.
- `playwright-skill`: custom Playwright script runner for repeatable browser automation.

Both are included because browser proof is a first-class stop condition for web work.

### Superpowers

Included:

- `brainstorming`

Not included: the rest of Superpowers. This package only needs the design-before-build gate, not a second full methodology.

## Excluded Categories

These were deliberately kept out of the primary package:

- full agent control boards;
- default `speckit-git-*` side-effect commands;
- low-code workflow platforms;
- alternate full-stack SaaS templates;
- stealth/browser scraping stacks;
- duplicate planning methodologies;
- memory systems as source of truth.

They can be useful optional tools, but they should not become the default web-coding loop.
