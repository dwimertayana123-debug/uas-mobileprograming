import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'penghuni_page.dart';
import 'kamar_page.dart';

class PembayaranPage extends StatelessWidget {
  const PembayaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E6F2),

      body: SafeArea(
        child: Column(
          children: [
            

            Center(
              child: Container(
                width: 150,
                height: 150,
                color: Colors.grey.shade300,
                child: const Center(
                  child: Text(
                    "Logo",
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey.shade300,
                          child: const Center(
                            child: Text(
                              "Foto",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),

                        const SizedBox(width: 20),

                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nama",
                              style: TextStyle(fontSize: 28),
                            ),
                            Text(
                              "Nomor Kamar",
                              style: TextStyle(fontSize: 28),
                            ),
                            Text(
                              "Tanggal Masuk",
                              style: TextStyle(fontSize: 28),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    const Center(
                      child: Text(
                        "Tagihan Bulan Ini",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    _buildBillRow("Harga Kamar"),
                    const SizedBox(height: 16),

                    _buildBillRow("Harga Listrik"),
                    const SizedBox(height: 16),

                    _buildBillRow("Harga Air"),

                    const SizedBox(height: 20),

                    const Divider(
                      thickness: 1,
                      color: Colors.black54,
                    ),

                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const Spacer(),

                    const Text(
                      "Status Pembayaran\nLunas/Belum",
                      style: TextStyle(
                        fontSize: 28,
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
        currentIndex: 3,
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const KamarPage(),
                ),
              );
              break;

            case 3:
              break; // Sudah di Pembayaran
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

  static Widget _buildBillRow(String title) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        Container(
          width: 120,
          height: 1,
          color: Colors.black54,
        ),
      ],
    );
  }
}