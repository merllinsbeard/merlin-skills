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

gstack skills are useful, but many are not standalone markdown prompts. Their `SKILL.md` files call helper scripts under:

```text
~/.claude/skills/gstack/
```

`gstack-runtime/` packages the full curated helper surface the integrated gstack distribution needs: browser, design, PDF, gbrain, review, QA, safety, docs, and upgrade helpers. The repo tree intentionally contains no live `SKILL.md` files under `gstack-runtime`; the installer restores runtime `SKILL.md` files from `skills/<name>/SKILL.md`.

The public install surface is namespaced: gstack-derived skills install into the chosen skill root as `gstack-*` names such as `gstack-review` and `gstack-office-hours`. The runtime sidecar keeps upstream unprefixed directory names such as `review/` and `office-hours/`.

## Repo-Owned Skills

Merlin Skills owns only:

- `merlin-skills-routing`
- `install-merlin-skills`
- `create-goal`

Everything else is copied from upstream and should stay close to upstream unless a future release explicitly declares an adaptation.
