import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'providers/auth_provider.dart';
import 'providers/catatan_provider.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';

// ============================================================
// LANGKAH SETUP SUPABASE:
// 1. Buat akun di https://supabase.com
// 2. Buat project baru
// 3. Masuk ke Settings > API
// 4. Copy "Project URL" dan "anon public key"
// 5. Ganti nilai SUPABASE_URL dan SUPABASE_ANON_KEY di bawah
// ============================================================
const String supabaseUrl = 'https://prmmhzvusqkdibhilyto.supabase.co';
const String supabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBybW1oenZ1c3FrZGliaGlseXRvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODA3MTUzNTcsImV4cCI6MjA5NjI5MTM1N30.HnBgbb5IKjwHRFGc6aErv-kL5TZj1_yAPhQLxTrq7o8';


void main() async {
  // Pastikan Flutter sudah siap sebelum inisialisasi
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Supabase - wajib dilakukan sebelum runApp
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Daftarkan semua provider di sini
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CatatanProvider()),
      ],
      child: MaterialApp(
        title: 'Taku - Catatan Saya',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        // Cek apakah user sudah login atau belum
        home: const AuthWrapper(),
      ),
    );
  }
}

// Widget untuk menentukan halaman awal berdasarkan status login
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Dengarkan perubahan status auth
    final authProvider = context.watch<AuthProvider>();

    if (authProvider.isLoggedIn) {
      return const HomePage();
    } else {
      return const LoginPage();
    }
  }
}
