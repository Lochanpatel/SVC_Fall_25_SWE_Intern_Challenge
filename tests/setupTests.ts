process.env.NODE_ENV = process.env.NODE_ENV || 'test';
process.env.VITE_SUPABASE_URL = process.env.VITE_SUPABASE_URL || 'http://localhost:9999';
process.env.VITE_SUPABASE_ANON_KEY = process.env.VITE_SUPABASE_ANON_KEY || 'anon-test-key';
process.env.SUPABASE_URL = process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL;
process.env.SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY || process.env.VITE_SUPABASE_ANON_KEY;
