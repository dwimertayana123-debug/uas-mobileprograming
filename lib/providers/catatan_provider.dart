import 'package:flutter/material.dart';
import '../models/catatan.dart';
import '../services/catatan_service.dart';

// CatatanProvider: mengelola daftar catatan dan operasi CRUD
class CatatanProvider extends ChangeNotifier {
  final CatatanService _service = CatatanService();

  List<Catatan> _catatanList = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getter
  List<Catatan> get catatanList => _catatanList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Ambil semua catatan dari Supabase
  Future<void> fetchCatatanList() async {
    _setLoading(true);
    _clearError();

    try {
      _catatanList = await _service.getCatatanList();
    } catch (e) {
      _setError('Gagal memuat catatan: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Tambah catatan baru
  Future<bool> createCatatan({
    required String title,
    required String description,
  }) async {
    try {
      await _service.createCatatan(title: title, description: description);
      await fetchCatatanList(); // Refresh daftar setelah tambah
      return true;
    } catch (e) {
      _setError('Gagal menambah catatan: ${e.toString()}');
      return false;
    }
  }

  // Update catatan yang sudah ada
  Future<bool> updateCatatan({
    required String id,
    required String title,
    required String description,
  }) async {
    try {
      await _service.updateCatatan(id: id, title: title, description: description);
      await fetchCatatanList(); // Refresh daftar setelah update
      return true;
    } catch (e) {
      _setError('Gagal mengupdate catatan: ${e.toString()}');
      return false;
    }
  }

  // Hapus catatan
  Future<bool> deleteCatatan(String id) async {
    try {
      await _service.deleteCatatan(id);
      await fetchCatatanList(); // Refresh daftar setelah hapus
      return true;
    } catch (e) {
      _setError('Gagal menghapus catatan: ${e.toString()}');
      return false;
    }
  }

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
