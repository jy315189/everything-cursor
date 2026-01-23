# Common Patterns

## API Response Format

```typescript
interface ApiResponse<T> {
  success: boolean
  data?: T
  error?: string
  meta?: {
    total: number
    page: number
    limit: number
  }
}

// Usage
return {
  success: true,
  data: results,
  meta: { total: 100, page: 1, limit: 20 }
}
```

## Error Handling Pattern

```typescript
try {
  const result = await operation()
  return { success: true, data: result }
} catch (error) {
  console.error('Operation failed:', error)
  return { success: false, error: 'User-friendly message' }
}
```

## Repository Pattern

```typescript
interface Repository<T> {
  findAll(filters?: Filters): Promise<T[]>
  findById(id: string): Promise<T | null>
  create(data: CreateDto): Promise<T>
  update(id: string, data: UpdateDto): Promise<T>
  delete(id: string): Promise<void>
}

class UserRepository implements Repository<User> {
  async findById(id: string): Promise<User | null> {
    return await db.user.findUnique({ where: { id } })
  }
  // ... other methods
}
```

## Service Layer Pattern

```typescript
class UserService {
  constructor(
    private userRepo: UserRepository,
    private cache: CacheService
  ) {}

  async getUser(id: string): Promise<User> {
    // Check cache
    const cached = await this.cache.get(`user:${id}`)
    if (cached) return cached

    // Fetch from database
    const user = await this.userRepo.findById(id)
    if (!user) throw new NotFoundError('User not found')

    // Cache and return
    await this.cache.set(`user:${id}`, user, 300)
    return user
  }
}
```

## Custom Hooks Pattern (React)

```typescript
function useDebounce<T>(value: T, delay: number): T {
  const [debouncedValue, setDebouncedValue] = useState(value)

  useEffect(() => {
    const timer = setTimeout(() => setDebouncedValue(value), delay)
    return () => clearTimeout(timer)
  }, [value, delay])

  return debouncedValue
}

// Usage
const debouncedSearch = useDebounce(searchTerm, 300)
```

## Data Fetching Hook

```typescript
function useUsers(filters?: UserFilters) {
  return useQuery({
    queryKey: ['users', filters],
    queryFn: () => fetchUsers(filters),
    staleTime: 60_000,
  })
}

// Usage
const { data, isLoading, error } = useUsers({ role: 'admin' })
```

## Container/Presenter Pattern

```typescript
// Container (logic)
function UserListContainer() {
  const { data, isLoading } = useUsers()
  return <UserList users={data} isLoading={isLoading} />
}

// Presenter (UI)
function UserList({ users, isLoading }: Props) {
  if (isLoading) return <Skeleton />
  return users.map(u => <UserCard key={u.id} user={u} />)
}
```

## Middleware Pattern

```typescript
const authMiddleware = async (req, res, next) => {
  const token = req.headers.authorization?.split(' ')[1]
  if (!token) return res.status(401).json({ error: 'Unauthorized' })

  try {
    const user = await verifyToken(token)
    req.user = user
    next()
  } catch {
    res.status(401).json({ error: 'Invalid token' })
  }
}
```

## Validation Middleware (Zod)

```typescript
const validateBody = <T>(schema: z.ZodSchema<T>) => {
  return (req, res, next) => {
    const result = schema.safeParse(req.body)
    if (!result.success) {
      return res.status(400).json({
        error: 'Validation failed',
        details: result.error.flatten()
      })
    }
    req.body = result.data
    next()
  }
}

// Usage
app.post('/users', validateBody(CreateUserSchema), createUser)
```

## Cache-Aside Pattern

```typescript
async function getData(key: string) {
  // 1. Check cache
  let data = await cache.get(key)
  if (data) return data

  // 2. Fetch from source
  data = await database.query(key)

  // 3. Update cache
  await cache.set(key, data, TTL)

  return data
}
```

## Factory Pattern

```typescript
interface Notification {
  send(message: string): Promise<void>
}

class NotificationFactory {
  static create(type: 'email' | 'sms' | 'push'): Notification {
    switch (type) {
      case 'email': return new EmailNotification()
      case 'sms': return new SmsNotification()
      case 'push': return new PushNotification()
    }
  }
}

// Usage
const notifier = NotificationFactory.create('email')
await notifier.send('Hello!')
```
