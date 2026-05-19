#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILL_ROOT="${SKILL_ROOT:-$HOME/.codex/skills}"
GSTACK_ROOT="${GSTACK_ROOT:-$HOME/.claude/skills/gstack}"

GSTACK_SKILLS="
autoplan
benchmark
benchmark-models
browse
canary
careful
claude
codex
context-restore
context-save
cso
devex-review
document-generate
document-release
freeze
guard
gstack-openclaw-ceo-review
gstack-openclaw-investigate
gstack-openclaw-office-hours
gstack-openclaw-retro
gstack-upgrade
health
investigate
land-and-deploy
landing-report
learn
make-pdf
open-gstack-browser
pair-agent
retro
scrape
setup-browser-cookies
setup-deploy
setup-gbrain
skillify
sync-gbrain
unfreeze
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
mkdir -p "$GSTACK_ROOT"
rsync -a --delete "$REPO_ROOT/gstack-runtime/" "$GSTACK_ROOT/"

same_path() {
  local left="$1"
  local right="$2"
  mkdir -p "$left" "$right"
  [ "$(cd "$left" && pwd -P)" = "$(cd "$right" && pwd -P)" ]
}

for skill_dir in "$REPO_ROOT"/skills/*; do
  [ -d "$skill_dir" ] || continue
  skill="$(basename "$skill_dir")"
  mkdir -p "$SKILL_ROOT/$skill"
  if [ "$skill" = "gstack" ] && same_path "$SKILL_ROOT/$skill" "$GSTACK_ROOT"; then
    cp "$skill_dir/SKILL.md" "$GSTACK_ROOT/SKILL.md"
    continue
  fi
  rsync -a --delete "$skill_dir/" "$SKILL_ROOT/$skill/"
done

for skill in $GSTACK_SKILLS; do
  mkdir -p "$GSTACK_ROOT/$skill"
  rsync -a --delete "$REPO_ROOT/skills/$skill/" "$GSTACK_ROOT/$skill/"
done

cp "$REPO_ROOT/skills/gstack/SKILL.md" "$GSTACK_ROOT/SKILL.md"

find "$GSTACK_ROOT/bin" -maxdepth 1 -type f -exec chmod u+x {} + 2>/dev/null || true
find "$GSTACK_ROOT/browse/bin" -maxdepth 1 -type f -exec chmod u+x {} + 2>/dev/null || true
find "$GSTACK_ROOT/browse/scripts" -maxdepth 1 -type f -name '*.sh' -exec chmod u+x {} + 2>/dev/null || true
find "$GSTACK_ROOT/careful/bin" -maxdepth 1 -type f -exec chmod u+x {} + 2>/dev/null || true
find "$GSTACK_ROOT/freeze/bin" -maxdepth 1 -type f -exec chmod u+x {} + 2>/dev/null || true

build_gstack_runtime() {
  if [ "${MERLIN_SKIP_GSTACK_BUILD:-0}" = "1" ]; then
    echo "Skipped gstack runtime binary build."
    return 0
  fi

  if ! command -v bun >/dev/null 2>&1; then
    echo "Warning: bun is not installed; gstack runtime binaries were not built." >&2
    echo "Install bun or rerun with MERLIN_SKIP_GSTACK_BUILD=1 if you only need non-browser gstack flows." >&2
    return 0
  fi

  (
    cd "$GSTACK_ROOT"
    mkdir -p browse/dist design/dist make-pdf/dist
    bun install --no-progress
    bun run vendor:xterm
    bun build --compile browse/src/cli.ts --outfile browse/dist/browse
    bun build --compile browse/src/find-browse.ts --outfile browse/dist/find-browse
    bun build --compile design/src/cli.ts --outfile design/dist/design
    bun build --compile make-pdf/src/cli.ts --outfile make-pdf/dist/pdf
    bun build --compile bin/gstack-global-discover.ts --outfile bin/gstack-global-discover
    bash browse/scripts/build-node-server.sh
    chmod u+x browse/dist/browse browse/dist/find-browse design/dist/design make-pdf/dist/pdf bin/gstack-global-discover
  )
}

if ! build_gstack_runtime; then
  if [ "${MERLIN_STRICT_GSTACK_BUILD:-0}" = "1" ]; then
    exit 1
  fi
  echo "Warning: gstack runtime build failed; installed skills, but binary-backed gstack flows may need a manual build." >&2
fi

echo "Installed Merlin Skills into: $SKILL_ROOT"
echo "Installed gstack runtime sidecar into: $GSTACK_ROOT"
