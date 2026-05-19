#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

fail=0

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
merlin-skills-routing
install-merlin-skills
create-goal
brainstorming
tdd
to-prd
grill-with-docs
diagnose
zoom-out
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
playwright-cli
playwright-skill
"

for skill in $required_skills; do
  if [ ! -f "skills/$skill/SKILL.md" ]; then
    echo "Missing required skill: skills/$skill/SKILL.md" >&2
    fail=1
  fi
done

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
gstack-runtime/office-hours/SKILL.runtime.md
gstack-runtime/document-release/SKILL.runtime.md
gstack-runtime/gstack-upgrade/SKILL.runtime.md
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
