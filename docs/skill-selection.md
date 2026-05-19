# Skill Selection

This package is intentionally opinionated. The included skills serve one process:

```text
write spec once -> generate goal -> let Codex execute -> prove -> ship
```

## Included

### Merlin-owned meta skills

Included:

- `merlin-skills-routing`: mandatory smallest-chain router before non-trivial `/goal` work.
- `install-merlin-skills`: installer router for global Codex/Claude roots and project-local `.codex/skills` or `.claude/skills` roots.

These are repo-owned because they define how this distribution is selected and installed. They are not upstream snapshots.

### github/spec-kit

Included completely as a source archive. It provides the canonical spec-driven structure and should remain the main planning substrate.

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

Included fully: generic gstack skills, `codex`/`claude` wrappers, the root `gstack` browser skill, OpenClaw-specific gstack skills, and the curated runtime sidecar those skills need.

`office-hours` is the product-shaping front door for new ideas and "is this worth building?" questions. `plan-ceo-review` then challenges scope and ambition once a concrete plan exists. The broader gstack surface covers browser dogfooding, review, QA, docs, deploy, benchmarking, canary, safety guards, context save/restore, PDF generation, scraping, GBrain setup/sync, and OpenClaw-specific review loops.

Full availability does not make every gstack skill primary. The router keeps the default spec-to-goal conveyor narrow and selects the extra gstack skills only when they are the smallest useful tool for the job.

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
- low-code workflow platforms;
- alternate full-stack SaaS templates;
- stealth/browser scraping stacks;
- duplicate planning methodologies;
- memory systems as source of truth.

They can be useful optional tools, but they should not become the default web-coding loop.
