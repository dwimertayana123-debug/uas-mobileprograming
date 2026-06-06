import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'penghuni_page.dart';
import 'pembayaran_page.dart';

class KamarPage extends StatelessWidget {
  const KamarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E6F2),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ListView(
                    children: const [
                      KamarCard(
                        nomorKamar: "A01",
                        status: "Isi",
                      ),
                      SizedBox(height: 25),

                      KamarCard(
                        nomorKamar: "A02",
                        status: "Kosong",
                      ),
                      SizedBox(height: 25),

                      KamarCard(
                        nomorKamar: "A03",
                        status: "Isi",
                      ),
                      SizedBox(height: 25),

                      KamarCard(
                        nomorKamar: "A04",
                        status: "Kosong",
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
        currentIndex: 2,
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const PenghuniPage(),
                ),
              );
              break;

            case 2:
              break; // Sudah di halaman Kamar

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
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.meeting_room),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments),
            label: "",
          ),
        ],
      ),
    );
  }
}

class KamarCard extends StatelessWidget {
  final String nomorKamar;
  final String status;

  const KamarCard({
    super.key,
    required this.nomorKamar,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 110,
          height: 110,
          color: Colors.grey.shade300,
          child: const Center(
            child: Text(
              "Foto",
              style: TextStyle(
                fontSize: 26,
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
                "Nomor Kamar $nomorKamar",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Status ($status)",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}