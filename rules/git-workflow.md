# Git Workflow

## Commit Message Format

```
<type>: <description>

<optional body>
```

**Types:**
| Type | Use For |
|------|---------|
| `feat` | New feature |
| `fix` | Bug fix |
| `refactor` | Code refactoring |
| `docs` | Documentation |
| `test` | Tests |
| `chore` | Maintenance |
| `perf` | Performance |
| `ci` | CI/CD changes |

**Examples:**
```
feat: add user authentication with JWT
fix: resolve race condition in market updates
refactor: extract validation logic to separate module
docs: update API documentation
test: add unit tests for auth service
```

## Branch Naming

```
<type>/<description>

feat/user-authentication
fix/login-error
refactor/database-queries
```

## Pull Request Workflow

### Creating PRs
1. Ensure all tests pass
2. Update documentation if needed
3. Write comprehensive PR description
4. Include test plan

### PR Template
```markdown
## Summary
Brief description of changes

## Changes
- Change 1
- Change 2

## Test Plan
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed

## Screenshots (if UI changes)
```

## Code Review Checklist

Before approving:

**Security (CRITICAL):**
- [ ] No hardcoded credentials
- [ ] Input validation present
- [ ] No SQL injection risks

**Quality (HIGH):**
- [ ] Functions < 50 lines
- [ ] Files < 800 lines
- [ ] Error handling present

**Best Practices (MEDIUM):**
- [ ] Immutable patterns
- [ ] Tests included
- [ ] Documentation updated

## Feature Implementation Flow

```
1. Plan
   └── Requirements, phases, risks

2. Branch
   └── git checkout -b feat/feature-name

3. TDD
   └── Tests first → Implement → Refactor

4. Review
   └── Self-review → PR → Team review

5. Merge
   └── Squash or rebase → Delete branch
```

## Git Commands

```bash
# Create feature branch
git checkout -b feat/feature-name

# Stage changes
git add .

# Commit with message
git commit -m "feat: add new feature"

# Push branch
git push -u origin feat/feature-name

# Rebase on main
git fetch origin
git rebase origin/main

# Squash commits (interactive)
git rebase -i HEAD~3
```

## Branch Protection

Recommended settings for `main`:
- Require pull request reviews
- Require status checks to pass
- Require branches to be up to date
- No direct pushes
