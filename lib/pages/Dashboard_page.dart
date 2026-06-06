import 'package:flutter/material.dart';
import 'penghuni_page.dart';
import 'pembayaran_page.dart';
import 'kamar_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E6F2),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            Center(
              child: Image.asset(
                'kostku.png',
                width: 140,
                height: 140,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.home,
                    size: 140,
                    color: Colors.indigo,
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    _buildInfoRow(
                      Icons.meeting_room_outlined,
                      "Kamar Isi",
                      "15 / 20",
                    ),

                    const SizedBox(height: 32),

                    _buildInfoRow(
                      Icons.door_front_door_outlined,
                      "Kamar Kosong",
                      "5 / 20",
                    ),

                    const SizedBox(height: 32),

                    _buildInfoRow(
                      Icons.payments_outlined,
                      "Sudah Bayar",
                      "12 Pengguna",
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      "(Total pengguna yang sudah membayar)",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
  currentIndex: 0,
  type: BottomNavigationBarType.fixed,

  onTap: (index) {
    switch (index) {
      case 0:
        break; // Sudah di Dashboard

      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const PenghuniPage(),
          ),
        );
        break;

      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const KamarPage(),
          ),
        );
        break;

      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const PembayaranPage(),
          ),
        );
        break;
    }
  },

  items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.meeting_room),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.payments),
      label: '',
    ),
  ],
),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 42,
          color: Colors.black87,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}