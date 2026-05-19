#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILL_ROOT="${SKILL_ROOT:-$HOME/.codex/skills}"
GSTACK_ROOT="${GSTACK_ROOT:-$HOME/.claude/skills/gstack}"

GSTACK_SKILLS="
review
qa
qa-only
ship
office-hours
design-consultation
design-html
design-review
design-shotgun
plan-ceo-review
plan-design-review
plan-devex-review
plan-eng-review
plan-tune
"

mkdir -p "$SKILL_ROOT"

for skill_dir in "$REPO_ROOT"/skills/*; do
  [ -d "$skill_dir" ] || continue
  skill="$(basename "$skill_dir")"
  mkdir -p "$SKILL_ROOT/$skill"
  rsync -a --delete "$skill_dir/" "$SKILL_ROOT/$skill/"
done

mkdir -p "$GSTACK_ROOT"
rsync -a --delete "$REPO_ROOT/gstack-runtime/" "$GSTACK_ROOT/"

for skill in $GSTACK_SKILLS; do
  mkdir -p "$GSTACK_ROOT/$skill"
  rsync -a --delete "$REPO_ROOT/skills/$skill/" "$GSTACK_ROOT/$skill/"
done

for skill in office-hours document-release gstack-upgrade; do
  if [ -f "$GSTACK_ROOT/$skill/SKILL.runtime.md" ]; then
    cp "$GSTACK_ROOT/$skill/SKILL.runtime.md" "$GSTACK_ROOT/$skill/SKILL.md"
  fi
done

find "$GSTACK_ROOT/bin" -type f -maxdepth 1 -exec chmod u+x {} + 2>/dev/null || true
find "$GSTACK_ROOT/browse/bin" -type f -maxdepth 1 -exec chmod u+x {} + 2>/dev/null || true
find "$GSTACK_ROOT/browse/scripts" -type f -maxdepth 1 -name '*.sh' -exec chmod u+x {} + 2>/dev/null || true

build_gstack_runtime() {
  if [ "${MERLIN_SKIP_GSTACK_BUILD:-0}" = "1" ]; then
    echo "Skipped gstack browser/design binary build."
    return 0
  fi

  if ! command -v bun >/dev/null 2>&1; then
    echo "Warning: bun is not installed; gstack browse/design binaries were not built." >&2
    echo "Install bun or rerun with MERLIN_SKIP_GSTACK_BUILD=1 if you only need non-browser gstack flows." >&2
    return 0
  fi

  (
    cd "$GSTACK_ROOT"
    mkdir -p browse/dist design/dist
    bun install --no-progress
    bun build --compile browse/src/cli.ts --outfile browse/dist/browse
    bun build --compile browse/src/find-browse.ts --outfile browse/dist/find-browse
    bun build --compile design/src/cli.ts --outfile design/dist/design
    bash browse/scripts/build-node-server.sh
    chmod u+x browse/dist/browse browse/dist/find-browse design/dist/design
  )
}

if ! build_gstack_runtime; then
  if [ "${MERLIN_STRICT_GSTACK_BUILD:-0}" = "1" ]; then
    exit 1
  fi
  echo "Warning: gstack runtime build failed; installed skills, but browser/design gstack flows may need a manual build." >&2
fi

echo "Installed Merlin Skills into: $SKILL_ROOT"
echo "Installed gstack compatibility runtime into: $GSTACK_ROOT"
