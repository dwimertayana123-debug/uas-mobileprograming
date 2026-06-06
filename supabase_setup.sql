-- ============================================================
-- SETUP DATABASE SUPABASE UNTUK APLIKASI TAKU
-- Jalankan query ini di Supabase → SQL Editor
-- ============================================================

-- 1. Buat tabel catatan
CREATE TABLE catatan (
  id          BIGSERIAL PRIMARY KEY,         -- ID auto increment
  user_id     UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  title       TEXT NOT NULL,
  description TEXT NOT NULL DEFAULT '',
  created_at  TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- 2. Aktifkan Row Level Security (RLS)
--    RLS memastikan user hanya bisa akses data miliknya sendiri
ALTER TABLE catatan ENABLE ROW LEVEL SECURITY;

-- 3. Policy: user hanya bisa SELECT catatan miliknya sendiri
CREATE POLICY "User can view own catatan"
  ON catatan FOR SELECT
  USING (auth.uid() = user_id);

-- 4. Policy: user hanya bisa INSERT catatan untuk dirinya sendiri
CREATE POLICY "User can insert own catatan"
  ON catatan FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- 5. Policy: user hanya bisa UPDATE catatan miliknya sendiri
CREATE POLICY "User can update own catatan"
  ON catatan FOR UPDATE
  USING (auth.uid() = user_id);

-- 6. Policy: user hanya bisa DELETE catatan miliknya sendiri
CREATE POLICY "User can delete own catatan"
  ON catatan FOR DELETE
  USING (auth.uid() = user_id);
