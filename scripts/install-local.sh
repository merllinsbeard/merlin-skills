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

is_gstack_skill() {
  local needle="$1"
  local skill
  for skill in $GSTACK_SKILLS; do
    if [ "$skill" = "$needle" ]; then
      return 0
    fi
  done
  return 1
}

gstack_install_name() {
  local skill="$1"
  case "$skill" in
    gstack-*) printf '%s\n' "$skill" ;;
    *) printf 'gstack-%s\n' "$skill" ;;
  esac
}

patch_skill_name() {
  local skill_file="$1"
  local install_name="$2"
  local tmp
  [ -f "$skill_file" ] || return 0
  tmp="$(mktemp "${skill_file}.XXXXXX")"
  awk -v install_name="$install_name" '
    BEGIN { in_frontmatter = 0; patched = 0 }
    NR == 1 && $0 == "---" { in_frontmatter = 1; print; next }
    in_frontmatter && $0 == "---" { in_frontmatter = 0; print; next }
    in_frontmatter && patched == 0 && $0 ~ /^name:[[:space:]]*/ {
      print "name: " install_name
      patched = 1
      next
    }
    { print }
  ' "$skill_file" > "$tmp"
  mv "$tmp" "$skill_file"
}

copy_skill_dir() {
  local src="$1"
  local dest="$2"
  local install_name="$3"
  mkdir -p "$dest"
  rsync -a --delete "$src/" "$dest/"
  patch_skill_name "$dest/SKILL.md" "$install_name"
}

remove_stale_unprefixed_gstack_skill() {
  local target="$1"
  [ -e "$target/SKILL.md" ] || return 0
  if grep -Eq '(AUTO-GENERATED from SKILL\.md\.tmpl|\(gstack\)|GSTACK_ROOT|gstack-config|\.gstack)' "$target/SKILL.md"; then
    rm -rf "$target"
  fi
}

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
  if [ "$skill" = "gstack" ]; then
    if same_path "$SKILL_ROOT/$skill" "$GSTACK_ROOT"; then
      cp "$skill_dir/SKILL.md" "$GSTACK_ROOT/SKILL.md"
    else
      copy_skill_dir "$skill_dir" "$SKILL_ROOT/$skill" "$skill"
    fi
    continue
  fi
  if is_gstack_skill "$skill"; then
    continue
  fi
  copy_skill_dir "$skill_dir" "$SKILL_ROOT/$skill" "$skill"
done

for skill in $GSTACK_SKILLS; do
  install_name="$(gstack_install_name "$skill")"
  remove_stale_unprefixed_gstack_skill "$SKILL_ROOT/$skill"
  copy_skill_dir "$REPO_ROOT/skills/$skill" "$GSTACK_ROOT/$skill" "$install_name"
  if same_path "$SKILL_ROOT/$install_name" "$GSTACK_ROOT/$skill"; then
    continue
  fi
  copy_skill_dir "$GSTACK_ROOT/$skill" "$SKILL_ROOT/$install_name" "$install_name"
done

cp "$REPO_ROOT/skills/gstack/SKILL.md" "$GSTACK_ROOT/SKILL.md"

if [ -f "$GSTACK_ROOT/SKILL.md" ]; then
  patch_skill_name "$GSTACK_ROOT/SKILL.md" "gstack"
fi

for skill in $GSTACK_SKILLS; do
  install_name="$(gstack_install_name "$skill")"
  if [ "$install_name" != "$skill" ]; then
    remove_stale_unprefixed_gstack_skill "$SKILL_ROOT/$skill"
  fi
done

find "$GSTACK_ROOT/bin" -maxdepth 1 -type f -exec chmod u+x {} + 2>/dev/null || true
find "$GSTACK_ROOT/browse/bin" -maxdepth 1 -type f -exec chmod u+x {} + 2>/dev/null || true
find "$GSTACK_ROOT/browse/scripts" -maxdepth 1 -type f -name '*.sh' -exec chmod u+x {} + 2>/dev/null || true
find "$GSTACK_ROOT/careful/bin" -maxdepth 1 -type f -exec chmod u+x {} + 2>/dev/null || true
find "$GSTACK_ROOT/freeze/bin" -maxdepth 1 -type f -exec chmod u+x {} + 2>/dev/null || true

if [ -x "$GSTACK_ROOT/bin/gstack-config" ]; then
  "$GSTACK_ROOT/bin/gstack-config" set skill_prefix true >/dev/null 2>&1 || true
fi

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
