import { createClient } from '@supabase/supabase-js'

// Support both Vite (browser/dev) and GitHub Actions (test env)
const supabaseUrl =
  import.meta.env.VITE_SUPABASE_URL ||
  process.env.SUPABASE_URL ||
  ''

const supabaseAnonKey =
  import.meta.env.VITE_SUPABASE_ANON_KEY ||
  process.env.SUPABASE_ANON_KEY ||
  ''

// Allow dummy values during test
const isTest = process.env.NODE_ENV === 'test'

if ((!supabaseUrl || !supabaseAnonKey) && !isTest) {
  throw new Error('Missing Supabase environment variables')
}

export const supabase = createClient(
  supabaseUrl || 'http://localhost',
  supabaseAnonKey || 'test-anon-key',
  {
    auth: {
      autoRefreshToken: true,
      persistSession: true,
      detectSessionInUrl: true
    }
  }
)
