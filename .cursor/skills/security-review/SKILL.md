# Security Review

Use this skill when reviewing code for security vulnerabilities.

## Security Checklist

### Authentication
- [ ] Passwords hashed with bcrypt/argon2
- [ ] JWT tokens have expiration
- [ ] Session management secure
- [ ] Logout properly invalidates sessions

### Authorization
- [ ] Access controls on all routes
- [ ] Role-based permissions verified
- [ ] No privilege escalation possible
- [ ] Ownership checks present

### Input Validation
- [ ] All inputs validated server-side
- [ ] File uploads restricted
- [ ] URL parameters sanitized
- [ ] Request size limited

### Injection Prevention
- [ ] Parameterized SQL queries
- [ ] No eval() or dynamic code execution
- [ ] HTML properly escaped
- [ ] No command injection

### Data Protection
- [ ] No hardcoded secrets
- [ ] Sensitive data encrypted
- [ ] HTTPS enforced
- [ ] Error messages sanitized

## Common Vulnerabilities

### SQL Injection

```typescript
// VULNERABLE
const query = `SELECT * FROM users WHERE id = ${userId}`

// SECURE
const query = 'SELECT * FROM users WHERE id = $1'
await db.query(query, [userId])
```

### XSS (Cross-Site Scripting)

```typescript
// VULNERABLE
<div dangerouslySetInnerHTML={{ __html: userInput }} />

// SECURE
<div>{userInput}</div>

// If HTML needed, sanitize first
import DOMPurify from 'dompurify'
<div dangerouslySetInnerHTML={{ __html: DOMPurify.sanitize(userInput) }} />
```

### Hardcoded Secrets

```typescript
// VULNERABLE
const apiKey = 'sk-secret-key-12345'

// SECURE
const apiKey = process.env.API_KEY
if (!apiKey) throw new Error('API_KEY not configured')
```

### Missing Authentication

```typescript
// VULNERABLE
app.get('/admin/users', getUsers)

// SECURE
app.get('/admin/users', authMiddleware, adminOnly, getUsers)
```

### Insecure Direct Object Reference

```typescript
// VULNERABLE - User can access any order
app.get('/orders/:id', async (req, res) => {
  const order = await db.orders.findById(req.params.id)
  res.json(order)
})

// SECURE - Verify ownership
app.get('/orders/:id', async (req, res) => {
  const order = await db.orders.findById(req.params.id)
  if (order.userId !== req.user.id) {
    return res.status(403).json({ error: 'Forbidden' })
  }
  res.json(order)
})
```

## Severity Levels

| Level | Examples | Action |
|-------|----------|--------|
| CRITICAL | Auth bypass, RCE, data breach | Fix immediately |
| HIGH | SQL injection, XSS | Fix before deploy |
| MEDIUM | Missing rate limiting | Fix soon |
| LOW | Info disclosure | Fix when possible |

## Response Protocol

When vulnerability found:

1. **STOP** - Don't continue with other tasks
2. **ASSESS** - Determine severity
3. **FIX** - Address immediately if CRITICAL
4. **ROTATE** - Change exposed secrets
5. **REVIEW** - Check for similar issues
6. **DOCUMENT** - Log the vulnerability

## Security Headers

```typescript
// Recommended security headers
app.use((req, res, next) => {
  res.setHeader('X-Content-Type-Options', 'nosniff')
  res.setHeader('X-Frame-Options', 'DENY')
  res.setHeader('X-XSS-Protection', '1; mode=block')
  res.setHeader('Strict-Transport-Security', 'max-age=31536000')
  res.setHeader('Content-Security-Policy', "default-src 'self'")
  next()
})
```

## Rate Limiting

```typescript
import rateLimit from 'express-rate-limit'

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100 // limit each IP to 100 requests per window
})

app.use('/api/', limiter)

// Stricter for auth endpoints
const authLimiter = rateLimit({
  windowMs: 60 * 60 * 1000, // 1 hour
  max: 5 // 5 failed attempts per hour
})

app.use('/api/auth/login', authLimiter)
```
