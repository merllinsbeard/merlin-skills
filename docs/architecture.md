# Architecture

Merlin Skills is a curated skill distribution. It is not a new agent platform.

The package has three layers:

1. Runtime skills in `skills/`.
2. Compatibility/runtime helpers in `gstack-runtime/`.
3. Provenance snapshots in `vendor-snapshots/` and `third_party/`.

## Runtime Boundary

Only `skills/<name>/SKILL.md` is intended for normal skill discovery.

The full spec-kit repository is archived instead of extracted because upstream repositories can contain nested skill files. Keeping snapshots out of the runtime tree prevents accidental recursive discovery.

## Why gstack-runtime Exists

Selected gstack skills are useful, but they are not standalone markdown prompts. Their `SKILL.md` files call helper scripts under:

```text
~/.claude/skills/gstack/
```

`gstack-runtime/` packages the helper surface those selected skills need. The installer places it at that expected path and restores a few runtime-only `SKILL.md` files used by upstream gstack references.

## Repo-Owned Skills

Merlin Skills owns only:

- `merlin-skills-routing`
- `create-goal`

Everything else is copied from upstream and should stay close to upstream unless a future release explicitly declares an adaptation.

