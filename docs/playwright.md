# Playwright

Browser proof is part of the default stop condition for web work.

## playwright-cli

Use `playwright-cli` when the agent needs token-efficient interaction:

```bash
playwright-cli open
playwright-cli goto http://localhost:3000
playwright-cli snapshot
playwright-cli click <ref>
playwright-cli type "value"
```

It is good for inspecting pages, clicking through flows, and generating evidence without writing a custom script first.

## Playwright Test Runner

For project tests:

```bash
npx playwright install
PLAYWRIGHT_HTML_OPEN=never npx playwright test
npx playwright test --reporter=html
npx playwright show-report
```

Use `npx playwright codegen <url>` when generating a test skeleton is faster than hand-authoring the whole flow.

## playwright-skill

Use `playwright-skill` when the browser workflow needs custom logic, loops, screenshots, responsive checks, login setup, or repeated assertions.

