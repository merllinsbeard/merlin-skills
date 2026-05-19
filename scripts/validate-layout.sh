#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

fail=0

gstack_skills="
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
  for skill in $gstack_skills; do
    if [ "$skill" = "$needle" ]; then
      return 0
    fi
  done
  return 1
}

install_skill_name() {
  local skill="$1"
  if is_gstack_skill "$skill"; then
    case "$skill" in
      gstack-*) printf '%s\n' "$skill" ;;
      *) printf 'gstack-%s\n' "$skill" ;;
    esac
    return 0
  fi
  printf '%s\n' "$skill"
}

while IFS= read -r skill_file; do
  dir="$(dirname "$skill_file")"
  parent="$(dirname "$dir")"
  if [ "$parent" != "./skills" ]; then
    echo "Unexpected nested SKILL.md outside skills/<name>: $skill_file" >&2
    fail=1
  fi
done <<EOF
$(find . -path './.git' -prune -o -name SKILL.md -print | sort)
EOF

required_skills="
autoplan
benchmark
benchmark-models
brainstorming
browse
canary
careful
claude
codex
context-restore
context-save
create-goal
cso
design-consultation
design-html
design-review
design-shotgun
devex-review
diagnose
document-generate
document-release
freeze
grill-with-docs
gstack
gstack-openclaw-ceo-review
gstack-openclaw-investigate
gstack-openclaw-office-hours
gstack-openclaw-retro
gstack-upgrade
guard
health
install-merlin-skills
investigate
land-and-deploy
landing-report
learn
make-pdf
merlin-skills-routing
office-hours
open-gstack-browser
pair-agent
plan-ceo-review
plan-design-review
plan-devex-review
plan-eng-review
plan-tune
playwright-cli
playwright-skill
qa
qa-only
retro
review
scrape
setup-browser-cookies
setup-deploy
setup-gbrain
ship
skillify
sync-gbrain
tdd
to-prd
unfreeze
zoom-out
"

for skill in $required_skills; do
  if [ ! -f "skills/$skill/SKILL.md" ]; then
    echo "Missing required skill: skills/$skill/SKILL.md" >&2
    fail=1
  fi
done

while IFS= read -r skill_file; do
  skill="$(basename "$(dirname "$skill_file")")"
  install_name="$(install_skill_name "$skill")"
  if ! grep -qF "\`$install_name\`" "skills/merlin-skills-routing/SKILL.md"; then
    echo "Routing skill does not mention installed skill: $install_name (source: $skill)" >&2
    fail=1
  fi
done <<EOF
$(find skills -mindepth 2 -maxdepth 2 -name SKILL.md -print | sort)
EOF

required_paths="
README.md
AGENTS.md
LICENSE
THIRD_PARTY_NOTICES.md
assets/merlin-skills-flow.svg
assets/merlin-skills-cover.png
vendor-snapshots/manifest.json
vendor-snapshots/archives/github-spec-kit-51e6a140e291.tar.gz
vendor-snapshots/ab-method/agents/ab-create-goal.SKILL.vendor.md
vendor-snapshots/ab-method/core/create-goal.md
third_party/licenses/github-spec-kit.LICENSE
third_party/licenses/ab-method.LICENSE
third_party/licenses/mattpocock-skills.LICENSE
third_party/licenses/gstack.LICENSE
third_party/licenses/playwright-cli.LICENSE
third_party/licenses/playwright-skill.LICENSE
third_party/licenses/superpowers.LICENSE
gstack-runtime/ETHOS.md
gstack-runtime/VERSION
gstack-runtime/bin/gstack-config
gstack-runtime/bin/gstack-global-discover.ts
gstack-runtime/bin/gstack-update-check
gstack-runtime/bin/gstack-repo-mode
gstack-runtime/bin/gstack-slug
gstack-runtime/bin/gstack-timeline-log
gstack-runtime/bin/gstack-question-preference
gstack-runtime/bin/gstack-review-log
gstack-runtime/bin/gstack-review-read
gstack-runtime/browse/bin/remote-slug
gstack-runtime/browse/src/cli.ts
gstack-runtime/browse/scripts/build-node-server.sh
gstack-runtime/design/src/cli.ts
gstack-runtime/design-html/vendor/pretext.js
gstack-runtime/make-pdf/src/cli.ts
gstack-runtime/plan-devex-review/dx-hall-of-fame.md
gstack-runtime/qa/templates/qa-report-template.md
gstack-runtime/qa/references/issue-taxonomy.md
gstack-runtime/review/checklist.md
gstack-runtime/review/specialists/security.md
gstack-runtime/careful/bin/check-careful.sh
gstack-runtime/freeze/bin/check-freeze.sh
gstack-runtime/gstack-upgrade/migrations/v1.40.0.0.sh
"

for path in $required_paths; do
  if [ ! -e "$path" ]; then
    echo "Missing required path: $path" >&2
    fail=1
  fi
done

if find vendor-snapshots gstack-runtime -name SKILL.md -print | grep -q .; then
  echo "vendor-snapshots and gstack-runtime must not contain live SKILL.md files in the repo tree" >&2
  find vendor-snapshots gstack-runtime -name SKILL.md -print >&2
  fail=1
fi

if [ "$fail" -ne 0 ]; then
  exit 1
fi

echo "layout ok"
