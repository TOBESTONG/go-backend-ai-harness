# Claude Code Instructions

## Priority

- Company security, compliance requirements, and team norms override this file.
- Current conversation instructions override this file.
- Project-level `CLAUDE.md`, `AGENTS.md`, or team instruction files override global preferences when they are more specific.
- Do not guess facts, APIs, versions, paths, field names, command arguments, or commit hashes. Read code, configs, docs, or tool output first.

## Safety

- Before company approval, do not send internal code, logs, configs, API docs, stack traces, user data, or business details to external models, external MCP servers, plugins, or personal-account connectors.
- Never write Secrets, Tokens, private keys, `.env` values, Cookies, session credentials, database passwords, or cloud keys into code, logs, commits, or replies.
- Redact sensitive information found in logs or configs before discussing it.
- Do not add telemetry, analytics, remote config, reporting, or new network requests unless the team explicitly asks for them.

## Work Style

- Use Simplified Chinese by default. Preserve code identifiers, commands, logs, error messages, and protocol fields in their original language.
- Start with the answer. Do not repeat the user request as an opening.
- Keep the tone professional, equal, restrained, and clear.
- Do not pretend certainty. Say `不确定`, `未验证`, or `当前上下文未提供` when facts are not confirmed.

## Go Backend Workflow

- Confirm goal, context, constraints, and completion criteria before non-trivial work.
- Read related code, tests, configs, dependencies, and callers before editing.
- Follow existing layering, naming, error handling, logging, metrics, and test style.
- Use the minimal implementation ladder: verify the need exists, reuse existing code, use the standard library or platform features, use installed dependencies only when appropriate, then add the smallest necessary code.
- Avoid unrelated refactors, formatting churn, dependency migrations, new abstractions, or speculative scaffolding.
- For bug fixes, find the root cause and shared path. Do not patch only the reported symptom when sibling callers remain broken.
- Do not simplify away trust-boundary validation, data-loss-preventing error handling, security measures, explicit requirements, or necessary checks.

## Verification

- Run verification commands matched to the risk, using project commands first.
- Common Go candidates: `gofmt` or `go fmt`, `go test ./...`, `go test -race ./...`, `go vet ./...`, `golangci-lint run`, `govulncheck ./...`.
- If verification fails, read the error before changing assumptions.
- End with actual changes, verification results, and remaining risks.
