# Cursor Hooks

Automated checks and actions that run at specific trigger points.

## Overview

Hooks help maintain code quality by automatically running checks and actions at key moments in your workflow.

## Hook Types

### Pre-Commit Hooks

Checks that run before code is committed:

| Hook | Description | Severity |
|------|-------------|----------|
| `no-console-log` | Warns about console.log statements | Warning |
| `no-hardcoded-secrets` | Detects hardcoded API keys/secrets | Error |
| `no-todo-fixme` | Warns about unresolved TODOs | Warning |

### Post-Edit Hooks

Actions that run after editing files:

| Hook | Description |
|------|-------------|
| `lint-check` | Runs ESLint with auto-fix |
| `format-check` | Runs Prettier formatting |

### Post-Generate Hooks

Actions that run after generating new code:

| Hook | Description |
|------|-------------|
| `type-check` | Runs TypeScript type checking |

## Usage with Git Hooks

To integrate with Git pre-commit hooks, you can use `husky`:

```bash
# Install husky
npm install -D husky lint-staged

# Initialize husky
npx husky init

# Add pre-commit hook
echo "npx lint-staged" > .husky/pre-commit
```

Add to `package.json`:

```json
{
  "lint-staged": {
    "*.{ts,tsx,js,jsx}": [
      "eslint --fix",
      "prettier --write"
    ],
    "*.{json,md}": [
      "prettier --write"
    ]
  }
}
```

## Manual Integration

If you prefer manual checks, run these commands before committing:

```bash
# Check for console.log
grep -rn "console.log" src/ --include="*.ts" --include="*.tsx"

# Check for hardcoded secrets
grep -rn "api_key\|apiKey\|secret\|password" src/ --include="*.ts"

# Run linter
npm run lint

# Run type check
npm run type-check

# Run tests
npm test
```

## Customization

Edit `hooks.json` to:
- Add new checks
- Modify severity levels
- Change file patterns
- Add custom commands
