# Frontend Patterns

Best practices and patterns for React/Next.js frontend development.

## When to Use

- Building React components
- State management
- Data fetching
- Form handling
- Performance optimization

---

## Component Structure

### File Organization

```
src/
├── components/           # Shared components
│   ├── ui/              # Base UI components
│   │   ├── Button.tsx
│   │   ├── Input.tsx
│   │   └── Modal.tsx
│   └── common/          # Common composed components
│       ├── Header.tsx
│       └── Footer.tsx
├── features/            # Feature-based organization
│   └── users/
│       ├── components/  # Feature-specific components
│       ├── hooks/       # Feature-specific hooks
│       ├── api/         # API calls
│       └── types.ts     # Feature types
├── hooks/               # Shared hooks
├── lib/                 # Utilities
└── types/               # Global types
```

### Component Template

```typescript
// components/UserCard.tsx
import { type FC } from 'react'

interface UserCardProps {
  user: User
  onEdit?: (user: User) => void
  className?: string
}

export const UserCard: FC<UserCardProps> = ({ 
  user, 
  onEdit,
  className 
}) => {
  return (
    <div className={cn('rounded-lg border p-4', className)}>
      <h3 className="font-semibold">{user.name}</h3>
      <p className="text-gray-600">{user.email}</p>
      {onEdit && (
        <button onClick={() => onEdit(user)}>Edit</button>
      )}
    </div>
  )
}
```

---

## Custom Hooks

### Data Fetching Hook

```typescript
// hooks/useQuery.ts
import { useState, useEffect, useCallback } from 'react'

interface UseQueryResult<T> {
  data: T | null
  isLoading: boolean
  error: Error | null
  refetch: () => void
}

export function useQuery<T>(
  fetcher: () => Promise<T>,
  deps: unknown[] = []
): UseQueryResult<T> {
  const [data, setData] = useState<T | null>(null)
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)

  const fetch = useCallback(async () => {
    setIsLoading(true)
    setError(null)
    try {
      const result = await fetcher()
      setData(result)
    } catch (e) {
      setError(e instanceof Error ? e : new Error('Unknown error'))
    } finally {
      setIsLoading(false)
    }
  }, deps)

  useEffect(() => {
    fetch()
  }, [fetch])

  return { data, isLoading, error, refetch: fetch }
}

// Usage
const { data: users, isLoading } = useQuery(() => api.getUsers())
```

### Form Hook

```typescript
// hooks/useForm.ts
import { useState, useCallback } from 'react'

interface UseFormOptions<T> {
  initialValues: T
  onSubmit: (values: T) => Promise<void>
  validate?: (values: T) => Partial<Record<keyof T, string>>
}

export function useForm<T extends Record<string, unknown>>({
  initialValues,
  onSubmit,
  validate
}: UseFormOptions<T>) {
  const [values, setValues] = useState(initialValues)
  const [errors, setErrors] = useState<Partial<Record<keyof T, string>>>({})
  const [isSubmitting, setIsSubmitting] = useState(false)

  const handleChange = useCallback((name: keyof T, value: unknown) => {
    setValues(prev => ({ ...prev, [name]: value }))
    setErrors(prev => ({ ...prev, [name]: undefined }))
  }, [])

  const handleSubmit = useCallback(async (e?: React.FormEvent) => {
    e?.preventDefault()
    
    if (validate) {
      const validationErrors = validate(values)
      if (Object.keys(validationErrors).length > 0) {
        setErrors(validationErrors)
        return
      }
    }

    setIsSubmitting(true)
    try {
      await onSubmit(values)
    } finally {
      setIsSubmitting(false)
    }
  }, [values, validate, onSubmit])

  return { values, errors, isSubmitting, handleChange, handleSubmit }
}
```

---

## State Management

### Context Pattern

```typescript
// contexts/AuthContext.tsx
import { createContext, useContext, useState, type FC, type ReactNode } from 'react'

interface User {
  id: string
  email: string
  name: string
}

interface AuthContextValue {
  user: User | null
  login: (email: string, password: string) => Promise<void>
  logout: () => void
  isLoading: boolean
}

const AuthContext = createContext<AuthContextValue | null>(null)

export const AuthProvider: FC<{ children: ReactNode }> = ({ children }) => {
  const [user, setUser] = useState<User | null>(null)
  const [isLoading, setIsLoading] = useState(true)

  const login = async (email: string, password: string) => {
    const user = await api.login(email, password)
    setUser(user)
  }

  const logout = () => {
    setUser(null)
    api.logout()
  }

  return (
    <AuthContext.Provider value={{ user, login, logout, isLoading }}>
      {children}
    </AuthContext.Provider>
  )
}

export function useAuth() {
  const context = useContext(AuthContext)
  if (!context) {
    throw new Error('useAuth must be used within AuthProvider')
  }
  return context
}
```

---

## Performance

### Memoization

```typescript
import { useMemo, useCallback, memo } from 'react'

// Memoize expensive calculations
const ExpensiveComponent: FC<{ items: Item[] }> = ({ items }) => {
  const sortedItems = useMemo(
    () => [...items].sort((a, b) => a.name.localeCompare(b.name)),
    [items]
  )

  const handleClick = useCallback((id: string) => {
    console.log('Clicked:', id)
  }, [])

  return (
    <ul>
      {sortedItems.map(item => (
        <li key={item.id} onClick={() => handleClick(item.id)}>
          {item.name}
        </li>
      ))}
    </ul>
  )
}

// Memoize component to prevent unnecessary re-renders
export const MemoizedExpensiveComponent = memo(ExpensiveComponent)
```

### Code Splitting

```typescript
import { lazy, Suspense } from 'react'

// Lazy load heavy components
const HeavyChart = lazy(() => import('./HeavyChart'))
const AdminPanel = lazy(() => import('./AdminPanel'))

function App() {
  return (
    <Suspense fallback={<Loading />}>
      <HeavyChart />
    </Suspense>
  )
}
```

### Virtualization

```typescript
import { FixedSizeList } from 'react-window'

const VirtualList: FC<{ items: Item[] }> = ({ items }) => {
  return (
    <FixedSizeList
      height={400}
      width="100%"
      itemCount={items.length}
      itemSize={50}
    >
      {({ index, style }) => (
        <div style={style}>
          {items[index].name}
        </div>
      )}
    </FixedSizeList>
  )
}
```

---

## Error Handling

### Error Boundary

```typescript
import { Component, type ReactNode } from 'react'

interface Props {
  children: ReactNode
  fallback?: ReactNode
}

interface State {
  hasError: boolean
  error: Error | null
}

export class ErrorBoundary extends Component<Props, State> {
  state: State = { hasError: false, error: null }

  static getDerivedStateFromError(error: Error): State {
    return { hasError: true, error }
  }

  componentDidCatch(error: Error, info: React.ErrorInfo) {
    console.error('Error caught:', error, info)
  }

  render() {
    if (this.state.hasError) {
      return this.props.fallback || <DefaultErrorFallback error={this.state.error} />
    }
    return this.props.children
  }
}

// Usage
<ErrorBoundary fallback={<ErrorPage />}>
  <App />
</ErrorBoundary>
```

---

## Styling Patterns

### Tailwind with cn utility

```typescript
// lib/utils.ts
import { clsx, type ClassValue } from 'clsx'
import { twMerge } from 'tailwind-merge'

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

// Usage in components
<button 
  className={cn(
    'px-4 py-2 rounded-md',
    variant === 'primary' && 'bg-blue-500 text-white',
    variant === 'secondary' && 'bg-gray-200 text-gray-800',
    disabled && 'opacity-50 cursor-not-allowed',
    className
  )}
>
  {children}
</button>
```

---

## Testing

### Component Testing

```typescript
import { render, screen, fireEvent } from '@testing-library/react'
import { UserCard } from './UserCard'

describe('UserCard', () => {
  const mockUser = { id: '1', name: 'John', email: 'john@example.com' }

  it('renders user information', () => {
    render(<UserCard user={mockUser} />)
    
    expect(screen.getByText('John')).toBeInTheDocument()
    expect(screen.getByText('john@example.com')).toBeInTheDocument()
  })

  it('calls onEdit when edit button is clicked', () => {
    const onEdit = jest.fn()
    render(<UserCard user={mockUser} onEdit={onEdit} />)
    
    fireEvent.click(screen.getByText('Edit'))
    
    expect(onEdit).toHaveBeenCalledWith(mockUser)
  })
})
```

### Hook Testing

```typescript
import { renderHook, act } from '@testing-library/react'
import { useCounter } from './useCounter'

describe('useCounter', () => {
  it('increments counter', () => {
    const { result } = renderHook(() => useCounter())
    
    act(() => {
      result.current.increment()
    })
    
    expect(result.current.count).toBe(1)
  })
})
```
