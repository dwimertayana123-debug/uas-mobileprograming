// Model Catatan - merepresentasikan satu baris di tabel "catatan" Supabase
class Catatan {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;

  Catatan({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  // Buat objek Catatan dari data JSON (hasil query Supabase)
  factory Catatan.fromJson(Map<String, dynamic> json) {
    return Catatan(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Ubah objek Catatan menjadi Map untuk dikirim ke Supabase
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}
