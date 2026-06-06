import 'package:supabase_flutter/supabase_flutter.dart';

// Service untuk semua operasi Authentication (login, register, logout)
class AuthService {
  // Ambil instance Supabase client
  final _supabase = Supabase.instance.client;

  // Getter: cek apakah user saat ini sudah login
  User? get currentUser => _supabase.auth.currentUser;
  bool get isLoggedIn => currentUser != null;

  // Daftar akun baru dengan email dan password
  Future<AuthResponse> register({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

  // Login dengan email dan password
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Logout dari akun
  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  // Stream untuk mendengarkan perubahan status auth secara real-time
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;
}
