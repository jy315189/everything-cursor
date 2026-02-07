# Everything Cursor

**Production-ready Cursor AI configurations — rules, skills, agents, commands, hooks, and MCP configs.**

A complete, reusable configuration template that brings professional software engineering practices into AI-assisted development with Cursor IDE.

Based on [everything-claude-code](https://github.com/affaan-m/everything-claude-code) — adapted, enhanced, and optimized for Cursor.

---

## Architecture

```
.cursor/
├── rules/         7 rules    Enforced constraints (security, style, testing, git)
├── agents/        9 agents   Specialized AI roles with CoT reasoning
├── skills/        5 skills   Deep domain knowledge injection
├── commands/      8 commands Lightweight slash command triggers
├── hooks/         4 checks   Quality gate definitions
├── mcp-configs/   2 presets  External tool integration
└── mcp.json                  Default MCP configuration
```

### Design Principles

1. **Layered Context Loading** — Only 4 rules are always-on. Testing, performance, and patterns rules activate based on file globs to save tokens.
2. **Separation of Concerns** — Agents = deep role-play with reasoning. Commands = lightweight trigger descriptions. Skills = domain knowledge. Rules = enforced constraints.
3. **Prompt Engineering Quality** — All agents include: identity, thinking process, constraints, output format, and exit conditions.
4. **Production Realism** — Hooks are documented with actual integration paths (husky + lint-staged), not just conceptual definitions.

---

## Quick Start

### Copy to Your Project

```bash
git clone https://github.com/YOUR_USERNAME/everything-cursor.git
cp -r everything-cursor/.cursor your-project/.cursor
```

### Or Copy Only What You Need

```bash
# Just the rules (always-on coding standards)
cp -r everything-cursor/.cursor/rules your-project/.cursor/rules

# Just the agents (specialized AI assistants)
cp -r everything-cursor/.cursor/agents your-project/.cursor/agents
```

---

## Module Reference

### Rules (`.cursor/rules/`)

Enforced constraints the AI must follow. Uses Cursor's `.mdc` format with YAML frontmatter.

| Rule | Loading Strategy | Purpose |
|------|-----------------|---------|
| `security.mdc` | **Always on** | No secrets, input validation, injection prevention |
| `coding-style.mdc` | **Always on** | Immutability, file limits, naming, no `any` |
| `git-workflow.mdc` | **Always on** | Conventional commits, PR process |
| `workflow.mdc` | **Always on** | Standard development process (plan → TDD → review → PR) |
| `testing.mdc` | **Glob: test files** | TDD workflow, coverage targets — only loads for `*.test.*`, `*.spec.*` |
| `performance.mdc` | **Glob: perf-sensitive** | Optimization rules — only loads for cache/query/loader files |
| `patterns.mdc` | **Glob: services/api** | Design patterns — only loads for service/API/repository files |

> **Token savings**: By glob-targeting 3 of 7 rules, context overhead is reduced by ~40% for non-test, non-API work.

### Agents (`.cursor/agents/`)

Specialized AI roles with structured prompt engineering: identity, thinking process (Chain-of-Thought), constraints, strict output format, and exit conditions.

| Agent | Role | Key Feature |
|-------|------|-------------|
| `planner` | Task decomposition & planning | Risk assessment, dependency mapping |
| `architect` | System design decisions | Multi-option comparison with trade-offs |
| `tdd-guide` | TDD cycle coaching | Step-by-step RED → GREEN → REFACTOR |
| `code-reviewer` | Code quality review | Severity-rated findings with fixes |
| `security-reviewer` | Vulnerability analysis | OWASP-based, CVSS severity ratings |
| `build-error-resolver` | Build error diagnosis | Systematic diagnosis, not guessing |
| `e2e-runner` | Playwright E2E tests | Anti-flakiness patterns built in |
| `refactor-cleaner` | Dead code removal | Safety verification before removal |
| `doc-updater` | Documentation sync | Keeps docs in sync with code changes |

### Skills (`.cursor/skills/`)

Deep domain knowledge that goes beyond what AI models know by default. Each skill provides decision frameworks, code patterns, and anti-patterns for a specific domain.

| Skill | Contents |
|-------|----------|
| `backend-patterns` | Layered architecture, API design, caching strategy, error hierarchy, RBAC, event-driven patterns |
| `coding-standards` | Immutability enforcement, naming conventions, TypeScript strictness, Result type, size limits |
| `frontend-patterns` | Server/Client component decisions, state management tree, TanStack Query, virtualization, forms |
| `security-review` | OWASP Top 10 checklist, input validation layers, password/JWT security, rate limiting, security headers |
| `tdd-workflow` | Full TDD cycle with examples, testing pyramid, mocking patterns, coverage strategy, anti-patterns |

### Commands (`.cursor/commands/`)

Lightweight slash commands that describe when to use each workflow and delegate to the appropriate agent.

| Command | Trigger | Delegates To |
|---------|---------|-------------|
| `/tdd` | Implement a feature with TDD | `@agents/tdd-guide` |
| `/plan` | Create implementation plan | `@agents/planner` |
| `/code-review` | Review code quality | `@agents/code-reviewer` |
| `/security-audit` | Security vulnerability scan | `@agents/security-reviewer` |
| `/build-fix` | Fix build errors | `@agents/build-error-resolver` |
| `/e2e` | Generate E2E tests | `@agents/e2e-runner` |
| `/refactor-clean` | Remove dead code | `@agents/refactor-cleaner` |
| `/doc-sync` | Update documentation | `@agents/doc-updater` |

### Hooks (`.cursor/hooks/`)

Quality check definitions with real integration path via husky + lint-staged.

| Check | Severity | Detects |
|-------|----------|---------|
| `no-console-log` | Warning | `console.log` in source files |
| `no-hardcoded-secrets` | Error | API keys, passwords, tokens in code |
| `no-ts-ignore` | Error | `@ts-ignore` that hides type errors |
| `no-any-type` | Warning | Explicit `any` type annotations |

> See `hooks/README.md` for husky + lint-staged setup instructions.

### MCP Configs (`.cursor/mcp-configs/`)

| Preset | Servers | Use Case |
|--------|---------|----------|
| `minimal.json` | GitHub, Context7 | Lightweight setup |
| `full-stack.json` | GitHub, Memory, Context7, Supabase, Vercel, Playwright, Filesystem | Full-stack development |

> **Tip**: Keep ≤10 MCP servers enabled. Too many reduces your context window.

---

## Customization

These configurations are starting points. Customize for your project:

| What to Change | Where | Example |
|---------------|-------|---------|
| Coverage threshold | `rules/testing.mdc` | Change `≥ 80%` to your target |
| File size limit | `rules/coding-style.mdc` | Change `≤ 800 lines` |
| Rule loading | Any `.mdc` frontmatter | Change `alwaysApply` / `globs` |
| Add commit types | `rules/git-workflow.mdc` | Add `perf:`, `i18n:` |
| MCP servers | `mcp.json` | Enable/disable servers |

---

## Credits

Based on [everything-claude-code](https://github.com/affaan-m/everything-claude-code) by [@affaanmustafa](https://x.com/affaanmustafa) — Anthropic hackathon winner, 25.9k+ GitHub Stars.

## License

MIT — Use freely, modify as needed, contribute back if you can.
