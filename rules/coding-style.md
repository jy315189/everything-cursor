# Coding Style

## Immutability (CRITICAL)

ALWAYS create new objects, NEVER mutate:

```typescript
// WRONG: Mutation
function updateUser(user: User, name: string) {
  user.name = name  // MUTATION!
  return user
}

// CORRECT: Immutability
function updateUser(user: User, name: string): User {
  return { ...user, name }
}

// Array operations (immutable)
const newItems = [...items, newItem]           // Add
const filtered = items.filter(i => i.id !== id) // Remove
const updated = items.map(i => i.id === id ? {...i, ...changes} : i) // Update
```

## File Organization

MANY SMALL FILES > FEW LARGE FILES:
- High cohesion, low coupling
- 200-400 lines typical, **800 max**
- Extract utilities from large components
- Organize by feature/domain, not by type

```
src/
├── features/
│   ├── auth/
│   │   ├── components/
│   │   ├── hooks/
│   │   ├── services/
│   │   └── types.ts
│   └── markets/
│       ├── components/
│       ├── hooks/
│       └── types.ts
└── shared/
    ├── components/
    ├── hooks/
    └── utils/
```

## Function Design

- Single responsibility (one thing well)
- Keep functions **< 50 lines**
- Maximum 3-4 parameters
- Use object parameters for complex inputs

```typescript
// WRONG: Too many parameters
function createUser(name, email, age, role, department, manager) {}

// CORRECT: Object parameter
interface CreateUserInput {
  name: string
  email: string
  age: number
  role: Role
  department?: string
}

function createUser(input: CreateUserInput): User {}
```

## Error Handling

ALWAYS handle errors comprehensively:

```typescript
try {
  const result = await riskyOperation()
  return { success: true, data: result }
} catch (error) {
  console.error('Operation failed:', error)
  return { success: false, error: 'User-friendly message' }
}
```

## Input Validation

ALWAYS validate user input:

```typescript
import { z } from 'zod'

const schema = z.object({
  email: z.string().email(),
  age: z.number().int().min(0).max(150)
})

const validated = schema.parse(input)
```

## Naming Conventions

- **Variables/Functions**: camelCase
- **Classes/Types/Interfaces**: PascalCase
- **Constants**: SCREAMING_SNAKE_CASE
- **Files**: kebab-case.ts or PascalCase.tsx (React components)

## TypeScript Best Practices

### Use Explicit Types
```typescript
// WRONG: Implicit any
function process(data) { return data.value }

// CORRECT: Explicit types
function process(data: InputData): string {
  return data.value
}
```

### Prefer Interfaces for Objects
```typescript
// Use interface for object shapes
interface User {
  id: string
  name: string
  email: string
}

// Use type for unions, intersections
type Status = 'active' | 'inactive' | 'pending'
```

### Avoid `any`
```typescript
// WRONG
const data: any = fetchData()

// CORRECT
const data: UserData = fetchData()

// If truly unknown
const data: unknown = fetchData()
```

## Code Quality Checklist

Before marking work complete:
- [ ] Code is readable and well-named
- [ ] Functions are small (< 50 lines)
- [ ] Files are focused (< 800 lines)
- [ ] No deep nesting (> 4 levels)
- [ ] Proper error handling
- [ ] No console.log in production
- [ ] No hardcoded values
- [ ] Immutable patterns used
- [ ] TypeScript types are explicit
