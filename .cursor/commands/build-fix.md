# /build-fix - Fix Build Errors

Diagnose and fix build errors quickly.

## Usage

```
/build-fix [optional: paste error message]
```

## Process

### Step 1: Identify Error

I will read and categorize the error:

| Category | Examples |
|----------|----------|
| Type Error | TS2322, TS2339, TS2345 |
| Module Error | Cannot find module |
| Syntax Error | Unexpected token |
| Dependency | Peer dependency issues |
| Config | Invalid configuration |

### Step 2: Diagnose Root Cause

Analyze:
- Error message details
- File and line number
- Stack trace
- Related files

### Step 3: Apply Fix

Implement the appropriate fix:

**Type Errors:**
```typescript
// Fix type mismatches
// Add missing properties
// Correct function signatures
```

**Module Errors:**
```bash
# Install missing packages
npm install <package-name>

# Fix import paths
```

**Dependency Errors:**
```bash
# Clear and reinstall
rm -rf node_modules package-lock.json
npm install
```

### Step 4: Verify

```bash
npm run build
# Confirm error is resolved
```

## Example

```
/build-fix
Error: TS2339: Property 'user' does not exist on type 'Session'
```

Output:
1. Error analysis
2. Root cause explanation
3. Fix implementation
4. Verification step
