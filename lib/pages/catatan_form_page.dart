import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/catatan.dart';
import '../providers/catatan_provider.dart';

// Halaman ini dipakai untuk ADD dan EDIT catatan.
// Jika parameter [catatan] diisi → mode Edit, jika null → mode Tambah.
class CatatanFormPage extends StatefulWidget {
  final Catatan? catatan; // null = tambah baru, ada isinya = edit

  const CatatanFormPage({super.key, this.catatan});

  @override
  State<CatatanFormPage> createState() => _CatatanFormPageState();
}

class _CatatanFormPageState extends State<CatatanFormPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Cek apakah ini mode edit
  bool get _isEditMode => widget.catatan != null;

  @override
  void initState() {
    super.initState();
    // Jika mode edit, isi form dengan data yang sudah ada
    if (_isEditMode) {
      _titleController.text = widget.catatan!.title;
      _descriptionController.text = widget.catatan!.description;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<CatatanProvider>();
    bool success;

    if (_isEditMode) {
      // Mode Edit: panggil updateCatatan
      success = await provider.updateCatatan(
        id: widget.catatan!.id,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
      );
    } else {
      // Mode Tambah: panggil createCatatan
      success = await provider.createCatatan(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
      );
    }

    if (!mounted) return;

    if (success) {
      Navigator.pop(context); // Kembali ke HomePage setelah berhasil
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.errorMessage ?? 'Terjadi kesalahan'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CatatanProvider>();

    return Scaffold(
      appBar: AppBar(
        // Judul berubah sesuai mode
        title: Text(_isEditMode ? 'Edit Catatan' : 'Tambah Catatan'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Input Judul
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Judul',
                  hintText: 'Masukkan judul catatan...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Judul wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Input Deskripsi (multi-line)
              TextFormField(
                controller: _descriptionController,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  hintText: 'Tulis isi catatan di sini...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Deskripsi wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Tombol Simpan
              ElevatedButton.icon(
                onPressed: provider.isLoading ? null : _handleSave,
                icon: provider.isLoading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.save),
                label: Text(
                  _isEditMode ? 'Simpan Perubahan' : 'Tambah Catatan',
                  style: const TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
