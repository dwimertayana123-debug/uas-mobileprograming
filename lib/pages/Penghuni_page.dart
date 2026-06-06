import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'kamar_page.dart';
import 'pembayaran_page.dart';

class PenghuniPage extends StatelessWidget {
  const PenghuniPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E6F2),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
            
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(
                            Icons.volume_up,
                            size: 40,
                          ),
                          onPressed: () {},
                        ),
                      ),

                      Expanded(
                        child: ListView(
                          children: const [
                            PenghuniCard(
                              nama: 'Ahmad Fauzi',
                              kamar: 'A01',
                            ),
                            SizedBox(height: 20),

                            PenghuniCard(
                              nama: 'Budi Santoso',
                              kamar: 'A02',
                            ),
                            SizedBox(height: 20),

                            PenghuniCard(
                              nama: 'Citra Dewi',
                              kamar: 'A03',
                            ),
                            SizedBox(height: 20),

                            PenghuniCard(
                              nama: 'Dina Putri',
                              kamar: 'A04',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,

        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const DashboardPage(),
                ),
              );
              break;

            case 1:
              break; // Sudah di Penghuni

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
}

class PenghuniCard extends StatelessWidget {
  final String nama;
  final String kamar;

  const PenghuniCard({
    super.key,
    required this.nama,
    required this.kamar,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          color: Colors.grey.shade300,
          child: const Center(
            child: Text(
              'Foto',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),
        ),

        const SizedBox(width: 20),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nama,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                'Nomor Kamar $kamar',
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}