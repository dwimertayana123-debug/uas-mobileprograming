import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/catatan_provider.dart';
import '../models/catatan.dart';
import '../widgets/catatan_card.dart';
import 'catatan_form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Ambil data catatan begitu halaman dibuka
    // Gunakan addPostFrameCallback agar context sudah siap
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CatatanProvider>().fetchCatatanList();
    });
  }

  // Tampilkan dialog konfirmasi sebelum hapus
  Future<void> _confirmDelete(BuildContext context, Catatan catatan) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Catatan?'),
        content: Text('Yakin ingin menghapus "${catatan.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    // Cek mounted sebelum gunakan context setelah await
    if (confirmed == true && mounted) {
      await context.read<CatatanProvider>().deleteCatatan(catatan.id); // ignore: use_build_context_synchronously
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final catatanProvider = context.watch<CatatanProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Saya'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          // Tombol logout di pojok kanan atas
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => authProvider.logout(),
          ),
        ],
      ),
      body: _buildBody(catatanProvider),
      // Tombol tambah catatan baru
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CatatanFormPage()),
          );
        },
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(CatatanProvider provider) {
    // Tampilkan loading spinner
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Tampilkan pesan error jika ada
    if (provider.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(provider.errorMessage!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.read<CatatanProvider>().fetchCatatanList(),
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    // Tampilkan pesan jika catatan kosong
    if (provider.catatanList.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.note_add, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Belum ada catatan',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Tekan tombol + untuk menambah',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    // Tampilkan daftar catatan
    return RefreshIndicator(
      onRefresh: () => context.read<CatatanProvider>().fetchCatatanList(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: provider.catatanList.length,
        itemBuilder: (context, index) {
          final catatan = provider.catatanList[index];
          return CatatanCard(
            catatan: catatan,
            onEdit: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CatatanFormPage(catatan: catatan),
                ),
              );
            },
            onDelete: () => _confirmDelete(context, catatan),
          );
        },
      ),
    );
  }
}
