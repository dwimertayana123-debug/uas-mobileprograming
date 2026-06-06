# Panduan Setup Aplikasi Taku

## Struktur Folder

```
lib/
├── main.dart                  # Entry point + inisialisasi Supabase
├── models/
│   └── catatan.dart           # Model data Catatan
├── services/
│   ├── auth_service.dart      # Operasi login/register/logout
│   └── catatan_service.dart   # Operasi CRUD catatan ke Supabase
├── providers/
│   ├── auth_provider.dart     # State management untuk auth
│   └── catatan_provider.dart  # State management untuk catatan
├── pages/
│   ├── login_page.dart        # Halaman login
│   ├── register_page.dart     # Halaman daftar akun
│   ├── home_page.dart         # Halaman daftar catatan
│   └── catatan_form_page.dart # Halaman tambah/edit catatan
└── widgets/
    └── catatan_card.dart      # Widget kartu satu item catatan
```

---

## Langkah 1 — Setup Supabase

1. Buka [https://supabase.com](https://supabase.com) dan buat akun
2. Klik **New Project**, isi nama dan password database
3. Tunggu project selesai dibuat (~2 menit)

---

## Langkah 2 — Buat Tabel Database

1. Di dashboard Supabase, klik **SQL Editor** di sidebar kiri
2. Buat query baru, copy-paste isi file `supabase_setup.sql`
3. Klik **Run** untuk menjalankan

---

## Langkah 3 — Ambil API Keys

1. Di sidebar kiri, klik **Settings → API**
2. Copy nilai:
   - **Project URL** → contoh: `https://abcdefgh.supabase.co`
   - **anon public** key → string panjang yang dimulai dengan `eyJ...`

---

## Langkah 4 — Pasang Keys ke Aplikasi

Buka file `lib/main.dart`, ganti dua baris ini:

```dart
const String supabaseUrl = 'https://YOUR_PROJECT_ID.supabase.co';
const String supabaseAnonKey = 'YOUR_ANON_KEY';
```

Contoh setelah diisi:

```dart
const String supabaseUrl = 'https://abcdefghijkl.supabase.co';
const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
```

---

## Langkah 5 — Install Dependencies

Jalankan di terminal:

```bash
flutter pub get
```

---

## Langkah 6 — Jalankan Aplikasi

```bash
flutter run
```

---

## Alur Aplikasi

```
Buka App
   │
   ▼
AuthWrapper (cek status login)
   │
   ├── Belum login → LoginPage
   │       └── Tombol "Daftar" → RegisterPage
   │
   └── Sudah login → HomePage
           ├── Daftar catatan (bisa pull-to-refresh)
           ├── Tombol + → CatatanFormPage (tambah)
           ├── Tombol edit kartu → CatatanFormPage (edit)
           ├── Tombol hapus kartu → Dialog konfirmasi → hapus
           └── Tombol logout → kembali ke LoginPage
```

---

## Penjelasan Row Level Security (RLS)

RLS adalah fitur Supabase yang memastikan setiap user **hanya bisa membaca dan mengubah data miliknya sendiri**, meskipun semua data ada di tabel yang sama.

Tanpa RLS: user A bisa baca catatan user B → **berbahaya!**  
Dengan RLS: query otomatis difilter `WHERE user_id = auth.uid()` → **aman!**

Itulah kenapa di `catatan_service.dart` kita tidak perlu menulis filter `user_id` secara manual — Supabase menanganinya otomatis lewat policy.
