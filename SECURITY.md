# Security

Report security issues privately to the repository maintainer.

## Scope

This repository packages agent skills and helper scripts. Treat all upstream runtime helpers as code that can run commands on the user's machine after installation.

Before installing:

```bash
npm test
```

Before running gstack-derived workflows, read the selected skill and understand that the upstream skills may write to `~/.gstack/`, run tests, open browsers, create commits, or create PRs depending on the invoked workflow.

