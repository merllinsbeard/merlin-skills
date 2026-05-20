#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILL_ROOT="${SKILL_ROOT:-$HOME/.codex/skills}"
GSTACK_ROOT="${GSTACK_ROOT:-$HOME/.claude/skills/gstack}"

GSTACK_SKILLS="
qa
ship
"

REMOVED_GSTACK_SKILLS="
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
design-consultation
design-html
design-review
design-shotgun
devex-review
document-generate
document-release
freeze
gstack-openclaw-ceo-review
gstack-openclaw-investigate
gstack-openclaw-office-hours
gstack-openclaw-retro
gstack-upgrade
guard
health
investigate
land-and-deploy
landing-report
learn
make-pdf
office-hours
open-gstack-browser
pair-agent
plan-ceo-review
plan-design-review
plan-devex-review
plan-eng-review
plan-tune
qa-only
retro
review
scrape
setup-browser-cookies
setup-deploy
setup-gbrain
skillify
sync-gbrain
unfreeze
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

same_existing_path() {
  local left="$1"
  local right="$2"
  [ -e "$left" ] || return 1
  [ -e "$right" ] || return 1
  [ "$(cd "$left" && pwd -P)" = "$(cd "$right" && pwd -P)" ]
}

remove_if_gstack_managed() {
  local target="$1"
  [ -e "$target/SKILL.md" ] || return 0
  if grep -Eiq '(AUTO-GENERATED from SKILL\.md\.tmpl|\(gstack\)|^name:[[:space:]]*gstack-|GSTACK_ROOT|\.gstack|GStack)' "$target/SKILL.md"; then
    rm -rf "$target"
  fi
}

mkdir -p "$SKILL_ROOT"

for skill_dir in "$REPO_ROOT"/skills/*; do
  [ -d "$skill_dir" ] || continue
  skill="$(basename "$skill_dir")"
  if is_gstack_skill "$skill"; then
    continue
  fi
  copy_skill_dir "$skill_dir" "$SKILL_ROOT/$skill" "$skill"
done

for skill in $GSTACK_SKILLS; do
  install_name="$(gstack_install_name "$skill")"
  remove_if_gstack_managed "$SKILL_ROOT/$skill"
  copy_skill_dir "$REPO_ROOT/skills/$skill" "$SKILL_ROOT/$install_name" "$install_name"
done

for skill in $REMOVED_GSTACK_SKILLS; do
  install_name="$(gstack_install_name "$skill")"
  remove_if_gstack_managed "$SKILL_ROOT/$skill"
  remove_if_gstack_managed "$SKILL_ROOT/$install_name"
done

if ! same_existing_path "$SKILL_ROOT/gstack" "$GSTACK_ROOT"; then
  remove_if_gstack_managed "$SKILL_ROOT/gstack"
fi

echo "Installed Merlin Skills into: $SKILL_ROOT"
echo "Installed gstack-derived skills as: gstack-qa gstack-ship"
echo "No gstack runtime sidecar is installed by this release."
