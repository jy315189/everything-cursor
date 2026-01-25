# Everything Cursor

**Complete collection of Cursor AI rules, skills, agents, commands, hooks, and MCP configurations for professional development.**

Production-ready configurations evolved from [everything-claude-code](https://github.com/affaan-m/everything-claude-code) - adapted for Cursor IDE.

---

## What's Inside

```
everything-cursor/
├── .cursor/
│   ├── agents/               # Specialized subagents for delegation
│   │   ├── planner.md           # Feature implementation planning
│   │   ├── architect.md         # System design decisions
│   │   ├── tdd-guide.md         # Test-driven development guide
│   │   ├── code-reviewer.md     # Quality and security review
│   │   ├── security-reviewer.md # Vulnerability analysis
│   │   ├── build-error-resolver.md
│   │   ├── e2e-runner.md        # Playwright E2E testing
│   │   ├── refactor-cleaner.md  # Dead code cleanup
│   │   └── doc-updater.md       # Documentation sync
│   │
│   ├── skills/               # Workflow definitions and domain knowledge
│   │   ├── tdd-workflow/        # TDD methodology
│   │   ├── coding-standards/    # Code quality standards
│   │   ├── security-review/     # Security checklist
│   │   ├── backend-patterns/    # API, database, caching patterns
│   │   └── frontend-patterns/   # React, Next.js patterns
│   │
│   ├── commands/             # Slash commands for quick execution
│   │   ├── tdd.md               # /tdd - Test-driven development
│   │   ├── plan.md              # /plan - Implementation planning
│   │   ├── e2e.md               # /e2e - E2E test generation
│   │   ├── code-review.md       # /code-review - Quality review
│   │   ├── build-fix.md         # /build-fix - Fix build errors
│   │   ├── refactor-clean.md    # /refactor-clean - Dead code removal
│   │   ├── security-audit.md    # /security-audit - Security scan
│   │   └── doc-sync.md          # /doc-sync - Documentation sync
│   │
│   ├── rules/                # Always-follow guidelines (.mdc format)
│   │   ├── security.mdc         # Security checklist
│   │   ├── coding-style.mdc     # Code style and immutability
│   │   ├── testing.mdc          # TDD workflow and coverage
│   │   ├── git-workflow.mdc     # Commit format and PR process
│   │   ├── patterns.mdc         # Common design patterns
│   │   ├── performance.mdc      # Optimization guidelines
│   │   └── workflow.mdc         # Development workflow
│   │
│   ├── hooks/                # Trigger-based automations
│   │   ├── hooks.json           # Hook configurations
│   │   └── README.md            # Hook documentation
│   │
│   ├── mcp-configs/          # MCP server configurations
│   │   ├── full-stack.json      # Full-stack development setup
│   │   └── minimal.json         # Minimal essential setup
│   │
│   ├── mcp.json              # Default MCP configuration
│   │
│   └── examples/             # Example configurations
│       ├── project-rules.md
│       └── mcp-config.md
│
└── README.md
```

---

## Installation

### Option 1: Copy to Project (Recommended)

Copy the `.cursor/` directory to your project:

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/everything-cursor.git

# Copy to your project
cp -r everything-cursor/.cursor your-project/.cursor
```

### Option 2: Global Installation

Copy to your user-level Cursor configuration:

```bash
# Windows
xcopy everything-cursor\.cursor %USERPROFILE%\.cursor /E /I

# macOS/Linux
cp -r everything-cursor/.cursor ~/.cursor
```

> **Note:** Rules must use `.mdc` extension (Markdown Cursor format) with YAML frontmatter to be recognized by Cursor.

---

## Core Features

### 1. Agents (Subagents)

Specialized agents for delegation:

| Agent | Purpose |
|-------|---------|
| `planner` | Feature planning and task breakdown |
| `architect` | System design and tech decisions |
| `code-reviewer` | Quality and security review |
| `security-reviewer` | Vulnerability analysis |
| `build-error-resolver` | Fix build errors |
| `e2e-runner` | E2E test generation |
| `refactor-cleaner` | Dead code removal |
| `doc-updater` | Documentation sync |
| `tdd-guide` | TDD workflow guidance |

### 2. Skills (Domain Knowledge)

| Skill | Purpose |
|-------|---------|
| `tdd-workflow` | Test-driven development methodology |
| `coding-standards` | Code quality and consistency |
| `security-review` | Security audit checklist |
| `backend-patterns` | API, database, caching patterns |
| `frontend-patterns` | React, Next.js best practices |

### 3. Commands (Slash Commands)

| Command | Purpose |
|---------|---------|
| `/tdd` | Execute TDD workflow: RED → GREEN → REFACTOR |
| `/plan` | Create implementation plan |
| `/e2e` | Generate E2E tests |
| `/code-review` | Perform code quality review |
| `/build-fix` | Diagnose and fix build errors |
| `/refactor-clean` | Remove dead code |
| `/security-audit` | Security vulnerability scan |
| `/doc-sync` | Sync documentation with code |

### 4. Rules (Core Guidelines)

| Rule | Purpose |
|------|---------|
| `security.mdc` | No hardcoded secrets, input validation |
| `coding-style.mdc` | Immutability, file limits, naming |
| `testing.mdc` | TDD, 80% coverage requirement |
| `git-workflow.mdc` | Conventional commits, PR process |
| `patterns.mdc` | API response, repository pattern |
| `performance.mdc` | Optimization, caching |
| `workflow.mdc` | Development workflow |

### 5. MCP Configurations

Pre-configured MCP servers:

| Server | Purpose |
|--------|---------|
| `github` | PR, issues, repo operations |
| `memory` | Persistent memory |
| `context7` | Live documentation lookup |
| `supabase` | Database operations |
| `vercel` | Deployment management |
| `playwright` | Browser automation |

### 6. Hooks (Automations)

| Hook | Trigger | Purpose |
|------|---------|---------|
| `no-console-log` | Pre-commit | Warn about console.log |
| `no-hardcoded-secrets` | Pre-commit | Detect secrets |
| `lint-check` | Post-edit | Auto-fix linting |
| `format-check` | Post-edit | Auto-format |
| `type-check` | Post-generate | TypeScript check |

---

## Key Standards

### Code Quality
- Immutability enforcement
- File size limits (800 lines max)
- Function size limits (50 lines max)
- Explicit TypeScript types
- No `any` types

### Security
- No hardcoded secrets
- Input validation with Zod
- SQL injection prevention
- XSS/CSRF protection

### Testing
- TDD methodology (RED → GREEN → REFACTOR)
- 80% minimum coverage
- Unit, integration, and E2E tests

### Git Workflow
- Conventional commits
- PR templates
- Code review checklist

---

## Customization

These configurations are starting points. Customize for your needs:

1. **Coverage threshold** - Adjust in `testing.mdc`
2. **File size limits** - Change in `coding-style.mdc`
3. **Commit types** - Add custom types in `git-workflow.mdc`
4. **MCP servers** - Enable/disable in `mcp.json`
5. **Hooks** - Add custom checks in `hooks/hooks.json`

---

## Context Window Management

**Important:** Don't enable all MCPs at once. Too many tools can reduce your context window.

Rule of thumb:
- Keep under 10 MCPs enabled per project
- Disable unused servers
- Use `disabledMcpServers` in project config

---

## Credits

Based on [everything-claude-code](https://github.com/affaan-m/everything-claude-code) by [@affaanmustafa](https://x.com/affaanmustafa) - Anthropic hackathon winner.

---

## Contributing

Contributions are welcome! Ideas:
- Language-specific rules (Python, Go, Rust)
- Framework-specific skills (Django, Rails, Laravel)
- Additional design patterns
- DevOps configurations

---

## License

MIT - Use freely, modify as needed, contribute back if you can.

---

**Star this repo if it helps. Build something great with Cursor!**
