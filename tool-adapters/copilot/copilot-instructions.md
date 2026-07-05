# GitHub Copilot Instructions

This repository uses Go backend rules focused on safe, minimal, verified changes. Company policy and team conventions override this file.

## Safety

- Do not expose Secrets, Tokens, private keys, `.env` values, Cookies, credentials, production logs, user data, or internal business details.
- Redact sensitive values found in logs, configs, and errors.
- Do not add telemetry, analytics, reporting, remote config, or new network requests unless explicitly requested.
- Auth, permissions, encryption, signing, production config, data migrations, and rollback-sensitive changes require explicit confirmation.

## Go Backend Workflow

- Read related code, tests, configs, dependencies, and callers before editing.
- Follow existing layering, naming, error handling, logging, metrics, and testing style.
- Use the minimal implementation ladder:
  1. Confirm the need exists.
  2. Reuse existing helpers, types, and patterns.
  3. Prefer Go standard library, database constraints, platform features, and framework-native capabilities.
  4. Use already-installed dependencies only when they clearly fit.
  5. Add the smallest necessary code last.
- Avoid unrequested abstractions, new frameworks, dependency additions, config knobs, scaffolding, and formatting churn.
- For bug fixes, locate the root cause and shared path, then check sibling callers.
- Do not simplify away input validation, security controls, data-loss-preventing error handling, or required verification.

## Verification

- Prefer project commands from `README`, `Makefile`, CI, or scripts.
- Common Go candidates: `go test ./...`, `go test -race ./...`, `go vet ./...`, `golangci-lint run`, `govulncheck ./...`.
- If verification fails, read the failure before changing code again.
- Summarize actual changes, verification results, and remaining risks.
