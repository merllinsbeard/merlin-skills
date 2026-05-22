# Architecture

Merlin Skills is a curated skill distribution. It is not a new agent platform.

The package has two runtime-facing layers:

1. Runtime skills in `skills/`.
2. Provenance snapshots in `vendor-snapshots/` and `third_party/`.

## Runtime Boundary

Only `skills/<name>/SKILL.md` is intended for normal skill discovery.

The full spec-kit repository is archived instead of extracted because upstream repositories can contain nested skill files. Keeping snapshots out of the runtime tree prevents accidental recursive discovery.

GitHub Spec Kit is the exception to the earlier archive-only rule: its official Codex integration now generates first-class `speckit-*` skills. Merlin Skills promotes those generated skills into `skills/` while keeping the full upstream source as an archive. Do not extract the whole Spec Kit repository into the runtime tree.

The repo-owned `speckit-cli` skill is a wrapper for installing and operating the official `specify` CLI. It is not copied from upstream.

## Minimal gstack Boundary

This release intentionally removes the full gstack runtime sidecar and keeps only two adapted gstack-derived skills:

- `gstack-qa`
- `gstack-ship`

They are standalone Merlin skills. They do not require `~/.claude/skills/gstack`, gstack browser daemons, telemetry, GBrain, deploy helpers, or gstack review specialists.

## Repo-Owned Adaptations

Merlin Skills owns:

- `merlin-skills-routing`
- `install-merlin-skills`
- `speckit-cli`
- `create-goal`
- `tdd` placement note
- `gstack-qa`
- `gstack-ship`

Everything else is copied or generated from upstream and should stay close to upstream unless a future release explicitly declares an adaptation. The `tdd` method remains upstream-shaped; Merlin only owns the short Spec Kit placement note. In particular, `speckit-*` skills should stay aligned with GitHub Spec Kit's Codex integration output.
