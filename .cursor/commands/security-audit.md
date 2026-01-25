# /security-audit - Security Vulnerability Scan

Perform a security audit on the codebase.

## Usage

```
/security-audit [file path or scope]
```

## Process

### Step 1: Scan for Vulnerabilities

Check for common vulnerabilities:

**Authentication:**
- [ ] Secure password hashing
- [ ] JWT implementation
- [ ] Session management
- [ ] Account lockout

**Input Validation:**
- [ ] All inputs validated
- [ ] Schema validation
- [ ] File upload checks

**Injection:**
- [ ] SQL injection
- [ ] NoSQL injection
- [ ] Command injection
- [ ] XSS

**Data Protection:**
- [ ] No hardcoded secrets
- [ ] Encryption in transit
- [ ] Sensitive data handling

### Step 2: Assess Severity

| Level | Description | Action |
|-------|-------------|--------|
| CRITICAL | Data breach, RCE | Immediate fix |
| HIGH | SQL injection, XSS | Fix < 24h |
| MEDIUM | Missing rate limiting | Fix < 1 week |
| LOW | Minor issues | Next sprint |

### Step 3: Generate Report

```markdown
## Security Audit Report

### Executive Summary
[High-level findings]

### Critical Vulnerabilities 🔴
[Details and fixes]

### High Severity ⚠️
[Details and fixes]

### Recommendations
[Security improvements]
```

## Example

```
/security-audit src/api/
```

Output:
1. Vulnerability scan results
2. Severity assessment
3. Specific remediation steps
4. Recommendations for improvement
