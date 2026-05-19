# Contributing

Merlin Skills is intentionally narrow. New skills should earn their place in the route.

## Rules

- Keep installable skills under `skills/<name>/SKILL.md`.
- Do not place nested `SKILL.md` files outside `skills/`.
- Do not rewrite copied upstream skills unless the change is an intentional repo-owned adaptation.
- Keep source provenance in `vendor-snapshots/manifest.json`.
- Copy third-party licenses into `third_party/licenses/`.
- Run `npm test` before opening a PR.

## Selection Bar

A skill belongs here when it improves the spec-first `/goal` loop:

```text
spec -> goal -> implementation -> review -> QA -> browser proof -> ship
```

Skills that introduce a separate project-management system, agent platform, or workflow philosophy should stay out unless they materially improve this loop.

