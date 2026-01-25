# Backend Patterns

Best practices and patterns for backend development.

## When to Use

- Building API endpoints
- Database operations
- Authentication/authorization
- Service layer implementation
- Error handling

---

## API Design

### RESTful Endpoints

```typescript
// Standard REST patterns
GET    /api/users          // List all users
GET    /api/users/:id      // Get single user
POST   /api/users          // Create user
PUT    /api/users/:id      // Update user (full)
PATCH  /api/users/:id      // Update user (partial)
DELETE /api/users/:id      // Delete user
```

### Response Format

```typescript
// Success response
interface ApiResponse<T> {
  success: true
  data: T
  meta?: {
    page?: number
    limit?: number
    total?: number
  }
}

// Error response
interface ApiErrorResponse {
  success: false
  error: {
    code: string
    message: string
    details?: unknown
  }
}

// Usage
function successResponse<T>(data: T, meta?: Meta): ApiResponse<T> {
  return { success: true, data, meta }
}

function errorResponse(code: string, message: string): ApiErrorResponse {
  return { success: false, error: { code, message } }
}
```

### Input Validation

```typescript
import { z } from 'zod'

// Define schemas
const CreateUserSchema = z.object({
  email: z.string().email('Invalid email'),
  name: z.string().min(1, 'Name required').max(100),
  password: z.string().min(8, 'Password must be 8+ characters')
})

const UpdateUserSchema = CreateUserSchema.partial()

const PaginationSchema = z.object({
  page: z.coerce.number().int().min(1).default(1),
  limit: z.coerce.number().int().min(1).max(100).default(20)
})

// Validate in handler
async function createUser(req: Request) {
  const input = CreateUserSchema.parse(req.body)
  // input is now type-safe
}
```

---

## Repository Pattern

```typescript
// Generic repository interface
interface Repository<T, CreateInput, UpdateInput> {
  findById(id: string): Promise<T | null>
  findMany(filters?: Partial<T>): Promise<T[]>
  create(data: CreateInput): Promise<T>
  update(id: string, data: UpdateInput): Promise<T>
  delete(id: string): Promise<void>
}

// Implementation with Prisma
class UserRepository implements Repository<User, CreateUserInput, UpdateUserInput> {
  constructor(private prisma: PrismaClient) {}

  async findById(id: string): Promise<User | null> {
    return this.prisma.user.findUnique({ where: { id } })
  }

  async findMany(filters?: Partial<User>): Promise<User[]> {
    return this.prisma.user.findMany({ where: filters })
  }

  async create(data: CreateUserInput): Promise<User> {
    return this.prisma.user.create({ data })
  }

  async update(id: string, data: UpdateUserInput): Promise<User> {
    return this.prisma.user.update({ where: { id }, data })
  }

  async delete(id: string): Promise<void> {
    await this.prisma.user.delete({ where: { id } })
  }
}
```

---

## Service Layer

```typescript
// Business logic in services
class UserService {
  constructor(
    private userRepo: UserRepository,
    private emailService: EmailService
  ) {}

  async createUser(input: CreateUserInput): Promise<User> {
    // Validate business rules
    const existing = await this.userRepo.findByEmail(input.email)
    if (existing) {
      throw new ConflictError('Email already exists')
    }

    // Hash password
    const hashedPassword = await hashPassword(input.password)

    // Create user
    const user = await this.userRepo.create({
      ...input,
      password: hashedPassword
    })

    // Send welcome email
    await this.emailService.sendWelcome(user.email)

    return user
  }
}
```

---

## Error Handling

```typescript
// Custom error classes
class AppError extends Error {
  constructor(
    public code: string,
    message: string,
    public statusCode: number = 500
  ) {
    super(message)
  }
}

class NotFoundError extends AppError {
  constructor(resource: string) {
    super('NOT_FOUND', `${resource} not found`, 404)
  }
}

class ValidationError extends AppError {
  constructor(message: string) {
    super('VALIDATION_ERROR', message, 400)
  }
}

class UnauthorizedError extends AppError {
  constructor() {
    super('UNAUTHORIZED', 'Authentication required', 401)
  }
}

// Error handler middleware
function errorHandler(err: Error, req: Request, res: Response) {
  if (err instanceof AppError) {
    return res.status(err.statusCode).json(errorResponse(err.code, err.message))
  }

  // Log unexpected errors
  console.error('Unexpected error:', err)
  return res.status(500).json(errorResponse('INTERNAL_ERROR', 'An error occurred'))
}
```

---

## Database Patterns

### Query Optimization

```typescript
// BAD: N+1 problem
const users = await prisma.user.findMany()
for (const user of users) {
  const posts = await prisma.post.findMany({ where: { authorId: user.id } })
}

// GOOD: Include relations
const users = await prisma.user.findMany({
  include: { posts: true }
})

// GOOD: Select only needed fields
const users = await prisma.user.findMany({
  select: {
    id: true,
    name: true,
    email: true
  }
})
```

### Transactions

```typescript
// Atomic operations
async function transferFunds(fromId: string, toId: string, amount: number) {
  return prisma.$transaction(async (tx) => {
    const from = await tx.account.update({
      where: { id: fromId },
      data: { balance: { decrement: amount } }
    })

    if (from.balance < 0) {
      throw new Error('Insufficient funds')
    }

    await tx.account.update({
      where: { id: toId },
      data: { balance: { increment: amount } }
    })
  })
}
```

---

## Caching

```typescript
// Simple in-memory cache
const cache = new Map<string, { data: unknown; expiry: number }>()

async function getCached<T>(
  key: string,
  fetcher: () => Promise<T>,
  ttlSeconds: number = 60
): Promise<T> {
  const cached = cache.get(key)
  if (cached && cached.expiry > Date.now()) {
    return cached.data as T
  }

  const data = await fetcher()
  cache.set(key, { data, expiry: Date.now() + ttlSeconds * 1000 })
  return data
}

// Usage
const user = await getCached(
  `user:${id}`,
  () => userRepo.findById(id),
  300 // 5 minutes
)
```

---

## Authentication

```typescript
// JWT utilities
import jwt from 'jsonwebtoken'

const JWT_SECRET = process.env.JWT_SECRET!

interface TokenPayload {
  userId: string
  role: string
}

function signToken(payload: TokenPayload): string {
  return jwt.sign(payload, JWT_SECRET, { expiresIn: '7d' })
}

function verifyToken(token: string): TokenPayload {
  return jwt.verify(token, JWT_SECRET) as TokenPayload
}

// Auth middleware
async function authMiddleware(req: Request, res: Response, next: NextFunction) {
  const token = req.headers.authorization?.replace('Bearer ', '')
  
  if (!token) {
    throw new UnauthorizedError()
  }

  try {
    const payload = verifyToken(token)
    req.user = payload
    next()
  } catch {
    throw new UnauthorizedError()
  }
}
```

---

## Rate Limiting

```typescript
import rateLimit from 'express-rate-limit'

// General API rate limit
const apiLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // 100 requests per window
  message: { error: 'Too many requests' }
})

// Strict limit for auth endpoints
const authLimiter = rateLimit({
  windowMs: 60 * 60 * 1000, // 1 hour
  max: 5, // 5 attempts per hour
  message: { error: 'Too many login attempts' }
})
```
