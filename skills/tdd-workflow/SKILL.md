# Test-Driven Development Workflow

Use this skill when writing new features, fixing bugs, or refactoring code.

## When to Use

- Writing new features
- Fixing bugs
- Refactoring existing code
- Adding API endpoints
- Creating new components

## TDD Cycle

```
RED → GREEN → REFACTOR → REPEAT
```

### Step 1: Define Interfaces

```typescript
interface UserInput {
  email: string
  name: string
}

interface UserOutput {
  id: string
  email: string
  name: string
  createdAt: Date
}

function createUser(input: UserInput): Promise<UserOutput> {
  throw new Error('Not implemented')
}
```

### Step 2: Write Failing Tests (RED)

```typescript
describe('createUser', () => {
  it('creates user with valid input', async () => {
    const input = { email: 'test@example.com', name: 'Test User' }
    const result = await createUser(input)
    
    expect(result.id).toBeDefined()
    expect(result.email).toBe(input.email)
    expect(result.name).toBe(input.name)
  })

  it('throws error for invalid email', async () => {
    const input = { email: 'invalid', name: 'Test' }
    await expect(createUser(input)).rejects.toThrow('Invalid email')
  })

  it('throws error for empty name', async () => {
    const input = { email: 'test@example.com', name: '' }
    await expect(createUser(input)).rejects.toThrow('Name required')
  })
})
```

### Step 3: Run Tests - Verify FAIL

```bash
npm test
# Expected: Tests fail with "Not implemented"
```

### Step 4: Implement Minimal Code (GREEN)

```typescript
import { z } from 'zod'

const UserInputSchema = z.object({
  email: z.string().email('Invalid email'),
  name: z.string().min(1, 'Name required')
})

async function createUser(input: UserInput): Promise<UserOutput> {
  const validated = UserInputSchema.parse(input)
  
  const user = await db.users.create({
    data: {
      email: validated.email,
      name: validated.name
    }
  })
  
  return user
}
```

### Step 5: Run Tests - Verify PASS

```bash
npm test
# Expected: All tests pass
```

### Step 6: Refactor

Improve code while keeping tests green:
- Extract validation to separate function
- Add logging
- Improve error messages
- Optimize performance

### Step 7: Check Coverage

```bash
npm run test:coverage
# Target: 80%+ coverage
```

## Test Types

### Unit Tests
- Individual functions
- Pure logic
- Utilities

### Integration Tests
- API endpoints
- Database operations
- External services

### E2E Tests
- Critical user flows
- Complete workflows

## Best Practices

**DO:**
- Write tests FIRST
- Run tests after each change
- Test edge cases
- Keep tests independent

**DON'T:**
- Write code before tests
- Test implementation details
- Skip error scenarios
- Create test dependencies

## Coverage Requirements

- **80% minimum** overall
- **100%** for critical business logic
