# /doc-sync - Documentation Synchronization

Update documentation to match code changes.

## Usage

```
/doc-sync [file or feature that changed]
```

## Process

### Step 1: Identify Changes

I will identify what changed:
- Function signatures
- API endpoints
- Component props
- Configuration options

### Step 2: Find Related Docs

Locate documentation that needs updating:
- README.md
- JSDoc/TSDoc comments
- API documentation
- CHANGELOG.md

### Step 3: Update Documentation

**JSDoc Updates:**
```typescript
/**
 * Updated description
 * @param newParam - New parameter description
 * @returns Updated return description
 */
```

**README Updates:**
```markdown
## Updated Section
- New feature description
- Updated usage example
```

**CHANGELOG Updates:**
```markdown
## [Version] - Date

### Added
- New feature

### Changed
- Updated behavior
```

### Step 4: Verify

- [ ] Examples still work
- [ ] Links are valid
- [ ] Formatting is correct

## Example

```
/doc-sync src/api/users.ts
```

Output:
1. List of documentation updates needed
2. Updated documentation files
3. Verification checklist
