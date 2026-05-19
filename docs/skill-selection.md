# Skill Selection

This package is intentionally opinionated. The included skills serve one process:

```text
write spec once -> generate goal -> let Codex execute -> prove -> ship
```

## Included

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

Included:

- `review`
- `qa`
- `qa-only`
- `ship`
- `design-consultation`
- `design-html`
- `design-review`
- `design-shotgun`
- `plan-ceo-review`
- `plan-design-review`
- `plan-devex-review`
- `plan-eng-review`
- `plan-tune`

These are strong gates around planning, UI quality, QA, and shipping. They sit after spec/goal rather than replacing spec/goal.

Not included as primary user skills: broad gstack orchestration, deploy setup, canary, benchmarking, browser cookie setup, OpenClaw/GBrain setup, and unrelated maintenance skills. Those are useful in their own context, but they widen this package beyond the spec-to-ship loop.

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

