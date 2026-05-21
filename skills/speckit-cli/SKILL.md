---
name: speckit-cli
description: Install, verify, initialize, and manage the official GitHub Spec Kit `specify` CLI. Use when setting up spec-kit project infrastructure, checking CLI version/features, installing Codex integration skills, or managing Spec Kit integrations, extensions, and presets.
---

# Spec Kit CLI

Use the official GitHub Spec Kit `specify` CLI to set up and maintain the `.specify/` project infrastructure that the `speckit-*` skills rely on.

This is a Merlin-owned wrapper around the official CLI. Do not reimplement Spec Kit commands here.

## When To Use

Use this skill when the user asks to:

- install or update GitHub Spec Kit;
- initialize a project for Spec Kit;
- add the Codex integration that installs `$speckit-*` skills;
- inspect `specify` version or feature support;
- manage Spec Kit integrations, extensions, presets, or workflows.

Do not use this for writing specs once the project is initialized. Route to `speckit-constitution`, `speckit-specify`, `speckit-clarify`, `speckit-plan`, or `speckit-tasks`.

## Official Install

Spec Kit is installed from GitHub, not from PyPI.

```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git@v0.8.12
specify version
```

For one-off use without persistent install:

```bash
uvx --from git+https://github.com/github/spec-kit.git@v0.8.12 specify version
```

If a local `specify` behaves like an older version, prefer checking first:

```bash
specify version --features --json
specify self check
```

## Initialize A Project

Codex uses Spec Kit's skills-based integration.

```bash
specify init --here --integration codex --script sh
```

For an existing non-empty repo:

```bash
specify init --here --force --integration codex --script sh
```

For a read-only or planning dry run, inspect the intended target first and avoid mutating the repo until the user asks for setup.

## What Init Creates

Expected Codex setup:

```text
.agents/skills/speckit-*/SKILL.md
.specify/memory/constitution.md
.specify/scripts/bash/
.specify/templates/
.specify/workflows/
AGENTS.md managed Spec Kit section
```

The user-facing skills are invoked as `$speckit-*`.

## Integration Management

Useful commands:

```bash
specify integration list
specify integration install codex
specify integration use codex
specify check
```

Install additional integrations only when requested. Codex is multi-install safe because it uses `.agents/skills` and `AGENTS.md`.

## Extensions And Presets

Extensions add capabilities. Presets customize templates or terminology.

```bash
specify extension search
specify extension add <extension-name>
specify preset search
specify preset add <preset-name>
```

Do not install `speckit-git-*` behavior implicitly. Git branch, issue, commit, and remote side effects should stay explicit and remain compatible with the repo's own git rules and `gstack-ship`.

## Merlin Default

After CLI setup, the Merlin route is:

```text
speckit-constitution -> speckit-specify -> speckit-clarify -> speckit-plan -> speckit-tasks -> speckit-analyze/checklist -> create-goal -> /goal
```

Use `speckit-implement` only when the user explicitly wants native upstream Spec Kit implementation instead of the Merlin `/goal` path.
