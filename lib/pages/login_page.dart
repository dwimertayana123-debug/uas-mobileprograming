import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'register_page.dart';
import 'dashboard_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controller untuk membaca isi TextField
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Key untuk validasi form
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Selalu dispose controller untuk menghindari memory leak
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fungsi yang dipanggil saat tombol Login ditekan
  Future<void> _handleLogin() async {
  if (!_formKey.currentState!.validate()) return;

  final authProvider = context.read<AuthProvider>();

  final success = await authProvider.login(
    email: _emailController.text.trim(),
    password: _passwordController.text,
  );

  if (success && mounted) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const DashboardPage(),
      ),
    );
  } else if (mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          authProvider.errorMessage ?? 'Login gagal',
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    // context.watch agar widget rebuild saat isLoading berubah
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo dan Judul
                  Center(
                    child: Image.asset(
                      'kostku.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.home,
                          size: 120,
                          color: Colors.indigo,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),

                  const Text(
                    'KostKu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Text(
                    'Kost Kita',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Input Email
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Email wajib diisi';
                      if (!value.contains('@')) return 'Email tidak valid';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Input Password
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outlined),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Password wajib diisi';
                      if (value.length < 6) return 'Password minimal 6 karakter';
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Tombol Login
                  ElevatedButton(
                    onPressed: authProvider.isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: authProvider.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Login', style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 16),

                  // Link ke halaman Register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Belum punya akun?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RegisterPage(),
                            ),
                          );
                        },
                        child: const Text('Daftar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
