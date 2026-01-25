# /code-review - Code Quality Review

Perform a comprehensive code review on specified files or changes.

## Usage

```
/code-review [file path or description of changes]
```

## Process

### Step 1: Read Code

I will carefully read and understand the code:
- Logic flow
- Dependencies
- Integration points

### Step 2: Security Check

Check for security issues:
- [ ] No hardcoded secrets
- [ ] Input validation
- [ ] SQL injection prevention
- [ ] XSS prevention
- [ ] Proper authentication/authorization

### Step 3: Code Quality Check

Assess code quality:
- [ ] Functions < 50 lines
- [ ] Files < 800 lines
- [ ] No deep nesting
- [ ] Single responsibility
- [ ] Proper error handling

### Step 4: Best Practices

Verify best practices:
- [ ] Immutable patterns
- [ ] No `any` types
- [ ] Proper naming
- [ ] No console.log
- [ ] Tests included

### Step 5: Generate Report

```markdown
## Code Review: [File/Feature]

### Summary
[Overall assessment]

### Critical Issues 🔴
[Must fix before merge]

### Warnings ⚠️
[Should address]

### Suggestions 💡
[Nice to have improvements]

### Positive Highlights ✅
[Good practices observed]
```

## Example

```
/code-review src/services/userService.ts
```

Output:
1. Security assessment
2. Code quality assessment
3. Prioritized list of issues
4. Suggested improvements
