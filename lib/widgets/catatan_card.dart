import 'package:flutter/material.dart';
import '../models/catatan.dart';

// Widget kartu untuk menampilkan satu item catatan di list
class CatatanCard extends StatelessWidget {
  final Catatan catatan;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CatatanCard({
    super.key,
    required this.catatan,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Baris judul + tombol aksi
            Row(
              children: [
                Expanded(
                  child: Text(
                    catatan.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Tombol edit
                IconButton(
                  icon: const Icon(Icons.edit_outlined, color: Colors.indigo),
                  tooltip: 'Edit',
                  onPressed: onEdit,
                  visualDensity: VisualDensity.compact,
                ),
                // Tombol hapus
                IconButton(
                  icon: const Icon(Icons.delete_outlined, color: Colors.red),
                  tooltip: 'Hapus',
                  onPressed: onDelete,
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            // Deskripsi catatan
            if (catatan.description.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                catatan.description,
                style: const TextStyle(color: Colors.black87),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 8),
            // Tanggal dibuat
            Text(
              _formatDate(catatan.createdAt),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // Format tanggal menjadi "18 Mei 2025, 14:30"
  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}, '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }
}
