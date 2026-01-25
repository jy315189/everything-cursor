# /e2e - End-to-End Test Generation

Generate Playwright E2E tests for user flows.

## Usage

```
/e2e [user flow description]
```

## Process

### Step 1: Analyze Flow

I will identify:
- Starting point (page/state)
- User actions sequence
- Expected outcomes
- Edge cases

### Step 2: Generate Tests

Create comprehensive E2E tests:

```typescript
import { test, expect } from '@playwright/test'

test.describe('User Flow: [Name]', () => {
  test.beforeEach(async ({ page }) => {
    // Setup
  })

  test('completes happy path', async ({ page }) => {
    // Step-by-step actions
    // Assertions at each step
  })

  test('handles error scenarios', async ({ page }) => {
    // Error handling tests
  })
})
```

### Step 3: Add Page Objects (if complex)

For complex flows, create reusable page objects:

```typescript
class LoginPage {
  constructor(private page: Page) {}
  
  async login(email: string, password: string) {
    await this.page.fill('[data-testid="email"]', email)
    await this.page.fill('[data-testid="password"]', password)
    await this.page.click('[data-testid="submit"]')
  }
}
```

## Example

```
/e2e User can login, view dashboard, and logout
```

Output:
1. Test file with complete flow
2. Assertions for each step
3. Error scenario coverage
4. Page objects if needed
