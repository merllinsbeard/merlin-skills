#!/usr/bin/env node
import { createHash } from "node:crypto";
import { existsSync, readdirSync, readFileSync, statSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const manifestPath = path.join(root, "vendor-snapshots", "manifest.json");
const manifest = JSON.parse(readFileSync(manifestPath, "utf8"));
let failed = false;

function fail(message) {
  console.error(message);
  failed = true;
}

function requirePath(relPath) {
  const fullPath = path.join(root, relPath);
  if (!existsSync(fullPath)) {
    fail(`Missing manifest path: ${relPath}`);
    return;
  }
  const stat = statSync(fullPath);
  if (stat.isDirectory() && readdirSync(fullPath).length === 0) {
    fail(`Manifest path is empty directory: ${relPath}`);
  }
}

const upstreamNames = new Set();

for (const upstream of manifest.upstreams ?? []) {
  if (upstreamNames.has(upstream.name)) {
    fail(`Duplicate upstream in manifest: ${upstream.name}`);
  }
  upstreamNames.add(upstream.name);

  if (!upstream.commit || !/^[0-9a-f]{40}$/.test(upstream.commit)) {
    fail(`Invalid commit for ${upstream.name}: ${upstream.commit}`);
  }

  requirePath(upstream.license_file);

  for (const relPath of upstream.copied_paths ?? []) {
    requirePath(relPath);
  }

  if (upstream.archive_path) {
    requirePath(upstream.archive_path);
    const archive = readFileSync(path.join(root, upstream.archive_path));
    const actual = createHash("sha256").update(archive).digest("hex");
    if (actual !== upstream.archive_sha256) {
      fail(`Archive sha256 mismatch for ${upstream.archive_path}: ${actual}`);
    }
  }
}

const skillRoot = path.join(root, "skills");
const skillNames = new Set();

for (const dirent of readdirSync(skillRoot, { withFileTypes: true })) {
  if (!dirent.isDirectory()) continue;

  const skillPath = path.join(skillRoot, dirent.name, "SKILL.md");
  if (!existsSync(skillPath)) {
    fail(`Missing SKILL.md for skills/${dirent.name}`);
    continue;
  }

  const skillText = readFileSync(skillPath, "utf8");
  const nameMatch = skillText.match(/^name:\s*("?)([^"\n]+)\1\s*$/m);
  if (!nameMatch) {
    fail(`Missing frontmatter name in skills/${dirent.name}/SKILL.md`);
    continue;
  }

  const skillName = nameMatch[2].trim();
  if (skillNames.has(skillName)) {
    fail(`Duplicate skill name: ${skillName}`);
  }
  skillNames.add(skillName);
}

if (failed) {
  process.exit(1);
}

console.log(`manifest ok: ${manifest.upstreams.length} upstreams, ${skillNames.size} skills`);

