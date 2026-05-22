#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

fail=0

gstack_skills="
qa
ship
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
    printf 'gstack-%s\n' "$skill"
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
brainstorming
create-goal
diagnose
grill-with-docs
install-merlin-skills
merlin-skills-routing
playwright-cli
playwright-skill
qa
ship
speckit-analyze
speckit-checklist
speckit-clarify
speckit-cli
speckit-constitution
speckit-implement
speckit-plan
speckit-specify
speckit-tasks
speckit-taskstoissues
tdd
to-prd
zoom-out
"

for skill in $required_skills; do
  if [ ! -f "skills/$skill/SKILL.md" ]; then
    echo "Missing required skill: skills/$skill/SKILL.md" >&2
    fail=1
  fi
done

actual_count="$(find skills -mindepth 2 -maxdepth 2 -name SKILL.md -print | wc -l | tr -d ' ')"
if [ "$actual_count" != "23" ]; then
  echo "Expected 23 installable skills, found $actual_count" >&2
  fail=1
fi

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

if ! grep -qF "speckit-tasks -> speckit-analyze/checklist -> create-goal -> /goal -> tdd/diagnose" "skills/merlin-skills-routing/SKILL.md"; then
  echo "Routing skill must keep tdd after tasks, create-goal, and /goal in the canonical route" >&2
  fail=1
fi

if ! grep -qF "Spec Kit work: \`GOAL.md\` plus \`tasks.md\`" "skills/merlin-skills-routing/SKILL.md"; then
  echo "Routing skill must require GOAL.md plus tasks.md before tdd for Spec Kit work" >&2
  fail=1
fi

if ! grep -qF "Do not use \`tdd\` to replace \`speckit-tasks\`" "skills/tdd/SKILL.md"; then
  echo "tdd skill must preserve the Merlin Spec Kit placement note" >&2
  fail=1
fi

package_version="$(node -p "JSON.parse(require('fs').readFileSync('package.json', 'utf8')).version")"
file_version="$(tr -d '[:space:]' < VERSION)"
if [ "$package_version" != "$file_version" ]; then
  echo "VERSION ($file_version) must match package.json version ($package_version)" >&2
  fail=1
fi

required_paths="
README.md
AGENTS.md
LICENSE
THIRD_PARTY_NOTICES.md
assets/merlin-skills-flow.svg
assets/merlin-skills-cover.png
vendor-snapshots/manifest.json
vendor-snapshots/archives/github-spec-kit-f16468f21f4e.tar.gz
vendor-snapshots/ab-method/agents/ab-create-goal.SKILL.vendor.md
vendor-snapshots/ab-method/core/create-goal.md
third_party/licenses/github-spec-kit.LICENSE
third_party/licenses/ab-method.LICENSE
third_party/licenses/mattpocock-skills.LICENSE
third_party/licenses/gstack.LICENSE
third_party/licenses/playwright-cli.LICENSE
third_party/licenses/playwright-skill.LICENSE
third_party/licenses/superpowers.LICENSE
"

for path in $required_paths; do
  if [ ! -e "$path" ]; then
    echo "Missing required path: $path" >&2
    fail=1
  fi
done

if [ -d gstack-runtime ]; then
  echo "gstack-runtime should not exist in the minimal gstack release" >&2
  fail=1
fi

if find vendor-snapshots -name SKILL.md -print | grep -q .; then
  echo "vendor-snapshots must not contain live SKILL.md files in the repo tree" >&2
  find vendor-snapshots -name SKILL.md -print >&2
  fail=1
fi

if [ "$fail" -ne 0 ]; then
  exit 1
fi

echo "layout ok"
