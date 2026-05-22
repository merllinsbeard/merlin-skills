# Changelog

## Unreleased

## 0.2.0 - 2026-05-22

- Refreshed `github/spec-kit` provenance to official release `v0.8.12`.
- Added official Codex `speckit-*` runtime skills generated from GitHub Spec Kit.
- Added repo-owned `speckit-cli` wrapper for installing, verifying, initializing, and managing the official `specify` CLI.
- Rewrote routing around simple goal-driven development phases instead of package taxonomy.
- Updated routing to require a short Spec Kit consultation before every non-trivial skill decision.
- Documented `tasks.md`, `GOAL.md`, and QA/browser proof as the existing progress and evidence layer instead of adding separate status files.
- Added eval coverage for consultation-first routing and reuse of `tasks.md` as the progress ledger.
- Clarified that `tdd` starts after `tasks.md` and `GOAL.md` exist in the Spec Kit route, and does not replace `speckit-tasks`.
- Updated installer validation, docs, manifest, notices, and evals for 23 installable skills.

## 0.1.5 - 2026-05-20

- Removed full gstack integration and deleted the `gstack-runtime` sidecar.
- Kept only adapted `gstack-qa` and `gstack-ship` as standalone Merlin workflow gates.
- Updated installer cleanup, routing, validation, docs, manifest, notices, and release notes for 13 installable skills.

## 0.1.4 - 2026-05-20

- Namespaced all gstack-derived user-facing skills on install with the `gstack-` prefix.
- Kept `$GSTACK_ROOT` runtime directories unprefixed for upstream compatibility.
- Updated `install-merlin-skills`, `merlin-skills-routing`, docs, validation, and smoke-test expectations for prefixed install names.

## 0.1.3 - 2026-05-20

- Integrated the full gstack skill distribution, including browser, safety, docs, deploy, GBrain, context, PDF, model-wrapper, and OpenClaw-specific skills.
- Expanded `gstack-runtime` into a full curated sidecar while keeping live runtime `SKILL.md` files out of the repo tree.
- Updated installer, routing, validation, docs, manifest, notices, and release notes for 63 installable skills.

## 0.1.2 - 2026-05-19

- Added repo-owned `install-merlin-skills` meta skill for global Codex/Claude and project-local installs.
- Updated routing and docs so install/setup/refresh requests route to `install-merlin-skills`.
- Updated validation and release notes for 25 installable skills.

## 0.1.1 - 2026-05-19

- Promoted gstack `office-hours` to a top-level installable skill.
- Updated routing so early product ideas go through `office-hours`, while `plan-ceo-review` remains the founder/scope review for concrete plans.
- Updated installer, validation, docs, manifest, and release notes for 24 installable skills.

## 0.1.0 - 2026-05-19

- Created the initial Merlin Skills open-source package.
- Added full spec-kit source archive.
- Added spec-kit-native `create-goal` skill adapted from AB Method's goal concept.
- Added mandatory `merlin-skills-routing` meta skill.
- Added selected Matt Pocock, gstack, Playwright, and Superpowers skills.
- Added gstack compatibility runtime, installer, validation scripts, provenance manifest, and third-party notices.
