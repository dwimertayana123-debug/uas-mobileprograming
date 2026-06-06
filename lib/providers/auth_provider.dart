import 'package:flutter/material.dart';
import '../services/auth_service.dart';

// AuthProvider: mengelola state login/logout dan error message
// ChangeNotifier memungkinkan widget lain "mendengar" perubahan state
class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;

  // Getter agar widget bisa baca nilai state
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _authService.isLoggedIn;

  // Register akun baru
  Future<bool> register({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      await _authService.register(email: email, password: password);
      _setLoading(false);
      return true; // Berhasil
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false; // Gagal
    }
  }

  // Login dengan email dan password
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      await _authService.login(email: email, password: password);
      _setLoading(false);
      notifyListeners(); // Beritahu widget bahwa state berubah
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    await _authService.logout();
    notifyListeners(); // Beritahu widget supaya redirect ke login
  }

  // Helper methods untuk mengubah state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}
