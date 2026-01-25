# /refactor-clean - Dead Code Cleanup

Identify and remove dead code, unused imports, and optimize structure.

## Usage

```
/refactor-clean [file path or directory]
```

## Process

### Step 1: Scan for Dead Code

I will identify:
- Unused imports
- Unused exports
- Unreachable code
- Commented code blocks
- Unused variables

### Step 2: Verify Safety

Before removing, I verify:
- [ ] Not dynamically imported
- [ ] Not used in tests
- [ ] Not a public API
- [ ] No external references

### Step 3: Clean Code

Remove identified dead code:

```typescript
// Before
import { unused, used } from 'module'
const unusedVar = 'never used'
function unusedFunction() {}

// After
import { used } from 'module'
```

### Step 4: Run Tests

```bash
npm test
# Ensure nothing broke
```

### Step 5: Generate Report

```markdown
## Cleanup Report

### Removed Items
- Unused imports: X
- Dead functions: Y
- Commented code: Z lines

### Impact
- Files modified: N
- Lines removed: M
- Bundle size reduction: ~X KB
```

## Example

```
/refactor-clean src/utils/
```

Output:
1. List of dead code found
2. Safe removal of identified code
3. Verification tests pass
4. Summary report
