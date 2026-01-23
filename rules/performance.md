# Performance Guidelines

## Database Optimization

### Avoid N+1 Queries
```typescript
// BAD: N+1 query problem
const users = await db.users.findAll()
for (const user of users) {
  user.posts = await db.posts.findByUser(user.id) // N queries!
}

// GOOD: Single query with joins
const users = await db.users.findAll({
  include: { posts: true }
})
```

### Use Indexes
```sql
-- Add indexes for frequently queried columns
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_posts_user_id ON posts(user_id);
```

### Pagination
```typescript
// Always paginate large datasets
const users = await db.users.findMany({
  skip: (page - 1) * limit,
  take: limit,
  orderBy: { createdAt: 'desc' }
})
```

## Caching Strategy

### Cache-Aside Pattern
```typescript
async function getUser(id: string) {
  // Check cache first
  const cached = await redis.get(`user:${id}`)
  if (cached) return JSON.parse(cached)

  // Fetch from database
  const user = await db.users.findById(id)

  // Cache for 5 minutes
  await redis.setex(`user:${id}`, 300, JSON.stringify(user))

  return user
}
```

### Cache Invalidation
```typescript
async function updateUser(id: string, data: UpdateData) {
  // Update database
  const user = await db.users.update(id, data)

  // Invalidate cache
  await redis.del(`user:${id}`)

  return user
}
```

## Frontend Optimization

### React Performance
```typescript
// Use React.memo for expensive components
const ExpensiveList = memo(({ items }: Props) => {
  return items.map(item => <Item key={item.id} {...item} />)
})

// Use useMemo for expensive calculations
const sortedItems = useMemo(() => {
  return items.sort((a, b) => b.score - a.score)
}, [items])

// Use useCallback for stable function references
const handleClick = useCallback(() => {
  onSelect(item.id)
}, [item.id, onSelect])
```

### Code Splitting
```typescript
// Lazy load routes
const Dashboard = lazy(() => import('./Dashboard'))
const Settings = lazy(() => import('./Settings'))

// Use Suspense
<Suspense fallback={<Loading />}>
  <Dashboard />
</Suspense>
```

### Image Optimization
```typescript
// Next.js Image component
import Image from 'next/image'

<Image
  src="/hero.png"
  width={800}
  height={600}
  alt="Hero"
  priority // for above-the-fold images
  placeholder="blur"
/>
```

## Bundle Optimization

### Tree Shaking
```typescript
// BAD: Import entire library
import _ from 'lodash'

// GOOD: Import specific functions
import debounce from 'lodash/debounce'
```

### Dynamic Imports
```typescript
// Load heavy libraries on demand
const Chart = dynamic(() => import('chart.js'), {
  loading: () => <Skeleton />,
  ssr: false
})
```

## Performance Metrics

### Core Web Vitals
- **LCP** (Largest Contentful Paint): < 2.5s
- **FID** (First Input Delay): < 100ms
- **CLS** (Cumulative Layout Shift): < 0.1

### Monitoring
```typescript
// Log slow operations
const start = performance.now()
const result = await heavyOperation()
const duration = performance.now() - start

if (duration > 100) {
  console.warn(`Slow operation: ${duration}ms`)
}
```

## Build Troubleshooting

If build fails or is slow:
1. Check for circular dependencies
2. Analyze bundle size with `npm run analyze`
3. Remove unused dependencies
4. Check for duplicate packages
5. Use production builds for testing

```bash
# Analyze bundle
npm run build -- --analyze

# Check for duplicates
npx depcheck
```
