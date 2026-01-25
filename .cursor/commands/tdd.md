# /tdd - Test-Driven Development

Execute the complete TDD workflow: RED → GREEN → REFACTOR

## Usage

```
/tdd [feature description]
```

## Process

### Step 1: Define Interface

First, I will define the types and interfaces for the feature:

```typescript
// Define clear interfaces before implementation
interface FeatureInput { }
interface FeatureOutput { }
```

### Step 2: Write Failing Tests (RED)

I will write comprehensive tests that initially fail:

```typescript
describe('Feature', () => {
  it('should handle happy path', () => {
    // Test expected behavior
  })

  it('should handle edge cases', () => {
    // Test edge cases
  })

  it('should handle errors', () => {
    // Test error scenarios
  })
})
```

### Step 3: Verify Tests Fail

Run tests to confirm they fail as expected:

```bash
npm test
```

### Step 4: Implement Minimal Code (GREEN)

Write the minimum code needed to make tests pass:

```typescript
function feature(input: FeatureInput): FeatureOutput {
  // Minimal implementation
}
```

### Step 5: Verify Tests Pass

Run tests to confirm they now pass:

```bash
npm test
```

### Step 6: Refactor (IMPROVE)

Improve code quality while keeping tests green:
- Extract helper functions
- Improve naming
- Add documentation
- Optimize if needed

### Step 7: Check Coverage

Ensure adequate test coverage:

```bash
npm run test:coverage
# Target: 80%+ coverage
```

## Example

```
/tdd Create a user registration function that validates email and password
```

Output:
1. Interface definitions for UserInput and User
2. Tests for valid input, invalid email, weak password
3. Minimal implementation
4. Refactored clean code
5. Coverage report
