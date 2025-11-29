import 'package:flutter/material.dart';

// ================== SCREEN 3: BUYER HOME ==================
class BuyerHomeScreen extends StatelessWidget {
  final String username; // Variabel penampung username

  const BuyerHomeScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://images.unsplash.com/photo-1517677208171-0bc6799a631e?q=80&w=2070&auto=format&fit=crop"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(color: Colors.black.withOpacity(0.4)),
                ),
                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: Center(child: const Text("LAUNDRYIN", style: TextStyle(color: Colors.white, letterSpacing: 2))),
                ),
                
                // Card Halo User
                Padding(
                  padding: const EdgeInsets.only(top: 180, left: 20, right: 20),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // DISINI NAMA AKAN BERUBAH SESUAI INPUT
                            Text("Halo, $username", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const Text("Scan untuk melanjutkan pesanan", style: TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                        const Icon(Icons.qr_code_2, size: 40, color: Color(0xFF1F4E79)),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Status Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2D5C8A),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Laundry Selesai Dalam", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                              SizedBox(height: 10),
                              Text("Tanggal masuk : 19 Juli 2025", style: TextStyle(color: Colors.white70, fontSize: 12)),
                              Text("Status             : Sedang Dicuci", style: TextStyle(color: Colors.white70, fontSize: 12)),
                            ],
                          ),
                          Container(
                            width: 60, height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("2", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                                Text("hari", style: TextStyle(color: Colors.white, fontSize: 10)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const BoxDecoration(
                        color: Color(0xFF1F4E79),
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                      ),
                      child: const Center(
                        child: Text("Lihat Progress >", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Riwayat Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Riwayat Transaksi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1F4E79))),
                  Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF1F4E79)),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // Riwayat List
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  _buildHistoryCard("17/07/2025", "Cuci Express", "Rp 90.000"),
                  _buildHistoryCard("10/07/2025", "Cuci Biasa", "Rp 76.000"),
                  _buildHistoryCard("05/07/2025", "Setrika", "Rp 40.000"),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF1F4E79),
        unselectedItemColor: Colors.grey[400],
        showUnselectedLabels: true,
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Riwayat"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Pesan"),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(String date, String type, String price) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          Text(date, style: const TextStyle(color: Color(0xFF1F4E79), fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(type, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          const SizedBox(height: 15),
          Text(price, style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}