# Everything Cursor

**Complete collection of Cursor AI rules, skills, and configurations for professional development.**

Production-ready rules and skills for consistent, high-quality code with Cursor AI assistant.

---

## What's Inside

```
everything-cursor/
├── rules/                    # Always-follow guidelines
│   ├── security.md           # Security checklist and guidelines
│   ├── coding-style.md       # Code style and immutability
│   ├── testing.md            # TDD workflow and coverage
│   ├── git-workflow.md       # Commit format and PR process
│   ├── patterns.md           # Common design patterns
│   ├── performance.md        # Optimization guidelines
│   └── workflow.md           # Development workflow
│
├── skills/                   # Workflow definitions
│   ├── tdd-workflow/         # Test-driven development
│   ├── coding-standards/     # Code quality review
│   └── security-review/      # Vulnerability analysis
│
├── examples/                 # Example configurations
│   ├── project-rules.md      # Example project-level rules
│   └── mcp-config.md         # MCP server configuration guide
│
└── README.md
```

---

## Installation

### Option 1: Copy to Project (Recommended)

Copy the `rules/` and `skills/` directories to your project's `.cursor/` folder:

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/everything-cursor.git

# Copy to your project
cp -r everything-cursor/rules your-project/.cursor/rules
cp -r everything-cursor/skills your-project/.cursor/skills
```

### Option 2: Global Installation

Copy to your user-level Cursor configuration:

```bash
# Windows
cp -r everything-cursor/rules %USERPROFILE%\.cursor\rules
cp -r everything-cursor/skills %USERPROFILE%\.cursor\skills

# macOS/Linux
cp -r everything-cursor/rules ~/.cursor/rules
cp -r everything-cursor/skills ~/.cursor/skills
```

---

## Rules Overview

Rules are automatically loaded by Cursor and apply to all conversations.

| Rule | Purpose |
|------|---------|
| `security.md` | Security checklist (no hardcoded secrets, input validation, etc.) |
| `coding-style.md` | Immutability, file organization, naming conventions |
| `testing.md` | TDD workflow, 80% coverage requirement |
| `git-workflow.md` | Conventional commits, PR process |
| `patterns.md` | API response format, repository pattern, hooks |
| `performance.md` | Optimization, caching, build troubleshooting |
| `workflow.md` | Feature implementation workflow |

---

## Skills Overview

Skills can be referenced when you need specialized workflows.

### TDD Workflow
Test-driven development with RED → GREEN → REFACTOR cycle.

**Reference:** `@skills/tdd-workflow`

### Coding Standards
Code quality review and consistency checks.

**Reference:** `@skills/coding-standards`

### Security Review
Vulnerability analysis and security audit.

**Reference:** `@skills/security-review`

---

## Key Features

### Code Quality
- Immutability enforcement
- File size limits (800 lines max)
- Function size limits (50 lines max)
- Explicit TypeScript types

### Security
- No hardcoded secrets
- Input validation with Zod
- SQL injection prevention
- XSS/CSRF protection

### Testing
- TDD methodology
- 80% minimum coverage
- Unit, integration, and E2E tests

### Git Workflow
- Conventional commits
- PR templates
- Code review checklist

---

## Customization

These configurations are starting points. Customize for your needs:

1. **Coverage threshold** - Adjust the 80% requirement in `testing.md`
2. **File size limits** - Change 800 line max in `coding-style.md`
3. **Commit types** - Add custom types in `git-workflow.md`
4. **Patterns** - Add your own patterns to `patterns.md`

---

## Quick Start Checklist

After installation, Cursor will automatically:

- [ ] Enforce immutable patterns
- [ ] Warn about console.log statements
- [ ] Guide TDD workflow
- [ ] Check for security issues
- [ ] Follow conventional commits
- [ ] Maintain code quality standards

---

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

Ideas for contributions:
- Language-specific rules (Python, Go, Rust)
- Framework-specific skills (Django, Rails, Laravel)
- Additional design patterns
- DevOps configurations

---

## License

MIT - Use freely, modify as needed, contribute back if you can.

---

**Star this repo if it helps. Build something great with Cursor!**
