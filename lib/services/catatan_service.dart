import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/catatan.dart';

// Service untuk operasi CRUD tabel "catatan" di Supabase
class CatatanService {
  final _supabase = Supabase.instance.client;

  // Nama tabel di Supabase
  static const String _tableName = 'catatan';

  // READ: Ambil semua catatan milik user yang sedang login
  Future<List<Catatan>> getCatatanList() async {
    final response = await _supabase
        .from(_tableName)
        .select()                          // SELECT * FROM catatan
        .order('created_at', ascending: false); // ORDER BY created_at DESC

    // Ubah setiap item JSON menjadi objek Catatan
    return (response as List).map((json) => Catatan.fromJson(json)).toList();
  }

  // CREATE: Tambah catatan baru
  Future<void> createCatatan({
    required String title,
    required String description,
  }) async {
    // user_id wajib diisi secara eksplisit agar lolos RLS policy
    final userId = _supabase.auth.currentUser!.id;
    await _supabase.from(_tableName).insert({
      'user_id': userId,
      'title': title,
      'description': description,
    });
  }

  // UPDATE: Edit catatan yang sudah ada berdasarkan id
  Future<void> updateCatatan({
    required String id,
    required String title,
    required String description,
  }) async {
    await _supabase
        .from(_tableName)
        .update({'title': title, 'description': description})
        .eq('id', id); // WHERE id = ?
  }

  // DELETE: Hapus catatan berdasarkan id
  Future<void> deleteCatatan(String id) async {
    await _supabase
        .from(_tableName)
        .delete()
        .eq('id', id); // WHERE id = ?
  }
}
