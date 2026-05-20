# Architecture

Merlin Skills is a curated skill distribution. It is not a new agent platform.

The package has two runtime-facing layers:

1. Runtime skills in `skills/`.
2. Provenance snapshots in `vendor-snapshots/` and `third_party/`.

## Runtime Boundary

Only `skills/<name>/SKILL.md` is intended for normal skill discovery.

The full spec-kit repository is archived instead of extracted because upstream repositories can contain nested skill files. Keeping snapshots out of the runtime tree prevents accidental recursive discovery.

## Minimal gstack Boundary

This release intentionally removes the full gstack runtime sidecar and keeps only two adapted gstack-derived skills:

- `gstack-qa`
- `gstack-ship`

They are standalone Merlin skills. They do not require `~/.claude/skills/gstack`, gstack browser daemons, telemetry, GBrain, deploy helpers, or gstack review specialists.

## Repo-Owned Adaptations

Merlin Skills owns:

- `merlin-skills-routing`
- `install-merlin-skills`
- `create-goal`
- `gstack-qa`
- `gstack-ship`

Everything else is copied from upstream and should stay close to upstream unless a future release explicitly declares an adaptation.
