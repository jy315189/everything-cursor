# Testing Requirements

## Minimum Coverage: 80%

Test Types (ALL required):
1. **Unit Tests** - Individual functions, utilities, components
2. **Integration Tests** - API endpoints, database operations
3. **E2E Tests** - Critical user flows (Playwright)

## Test-Driven Development (TDD)

MANDATORY workflow:

```
RED → GREEN → REFACTOR → REPEAT

RED:      Write a failing test
GREEN:    Write minimal code to pass
REFACTOR: Improve code, keep tests passing
REPEAT:   Next feature/scenario
```

### Step-by-Step:
1. Define interfaces/types first
2. Write test (it should FAIL)
3. Implement minimal code (to PASS)
4. Refactor while tests stay green
5. Verify coverage (80%+)

## Test File Organization

```
src/
├── components/
│   ├── Button/
│   │   ├── Button.tsx
│   │   └── Button.test.tsx      # Unit tests
├── app/
│   └── api/
│       └── users/
│           ├── route.ts
│           └── route.test.ts     # Integration tests
└── e2e/
    ├── auth.spec.ts              # E2E tests
    └── checkout.spec.ts
```

## Testing Patterns

### Unit Test (Jest/Vitest)
```typescript
import { render, screen, fireEvent } from '@testing-library/react'
import { Button } from './Button'

describe('Button', () => {
  it('renders with text', () => {
    render(<Button>Click me</Button>)
    expect(screen.getByText('Click me')).toBeInTheDocument()
  })

  it('calls onClick when clicked', () => {
    const handleClick = jest.fn()
    render(<Button onClick={handleClick}>Click</Button>)
    fireEvent.click(screen.getByRole('button'))
    expect(handleClick).toHaveBeenCalledTimes(1)
  })
})
```

### Integration Test
```typescript
import { GET } from './route'

describe('GET /api/users', () => {
  it('returns users successfully', async () => {
    const response = await GET(new Request('http://localhost/api/users'))
    const data = await response.json()

    expect(response.status).toBe(200)
    expect(data.success).toBe(true)
  })
})
```

### E2E Test (Playwright)
```typescript
import { test, expect } from '@playwright/test'

test('user can login', async ({ page }) => {
  await page.goto('/login')
  await page.fill('input[name="email"]', 'test@example.com')
  await page.fill('input[name="password"]', 'password123')
  await page.click('button[type="submit"]')
  
  await expect(page).toHaveURL('/dashboard')
})
```

## Best Practices

**DO:**
- Write tests FIRST
- Test behavior, not implementation
- Keep tests independent
- Use descriptive test names
- Mock external dependencies

**DON'T:**
- Write implementation before tests
- Test implementation details
- Create test dependencies
- Skip edge cases
- Mock everything

## Coverage Requirements

- **80% minimum** for all code
- **100% required** for:
  - Financial calculations
  - Authentication logic
  - Security-critical code
  - Core business logic

## Running Tests

```bash
# Run all tests
npm test

# Run with coverage
npm run test:coverage

# Run E2E tests
npm run test:e2e

# Watch mode
npm test -- --watch
```
