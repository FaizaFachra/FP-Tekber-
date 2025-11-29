import 'package:flutter/material.dart';

// ================== SCREEN 2: SELLER HOME ==================
class SellerHomeScreen extends StatelessWidget {
  final String username; // Variabel penampung username

  const SellerHomeScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F4E79),
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 300,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://images.unsplash.com/photo-1545173168-9f1947eebb8f?q=80&w=2071&auto=format&fit=crop"), 
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          ),
          
          // Header Text dengan Nama Dinamis
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("LAUNDRYIN", style: TextStyle(color: Colors.white70, fontSize: 12, letterSpacing: 2)),
                    const SizedBox(height: 5),
                    // DISINI NAMA AKAN BERUBAH SESUAI INPUT
                    Text("Halo $username !", style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.chat_bubble_outline, color: Colors.white),
                    SizedBox(width: 15),
                    Icon(Icons.more_vert, color: Colors.white),
                  ],
                )
              ],
            ),
          ),

          // Main Card
          Positioned(
            top: 140,
            left: 24,
            right: 24,
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  children: [
                    const Text("Jumlah Pesanan Laundry", 
                      style: TextStyle(color: Color(0xFF1F4E79), fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    const Text("3", 
                      style: TextStyle(color: Color(0xFF1F4E79), fontSize: 80, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text("Pengambilan Terdekat : 20 Juli 2025", 
                      style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),

          // Menu Buttons
          Positioned(
            top: 420, 
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSquareButton(Icons.assignment_outlined, "Daftar\nPesanan"),
                _buildSquareButton(Icons.history, "Riwayat"),
              ],
            ),
          ),

          // Scan Button
          Positioned(
            top: 540,
            left: 24,
            right: 24,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.qr_code_scanner, size: 40, color: Color(0xFF1F4E79)),
                  SizedBox(height: 5),
                  Text("Scan\nQR", textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF1F4E79), fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
            ),
          ),

          // Bottom Sheet Handle
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height: 4, width: 40, color: Colors.grey[400]),
                    const SizedBox(height: 8),
                    Text("Antrian Laundry", style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSquareButton(IconData icon, String label) {
    return Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: const Color(0xFF1F4E79)),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFF1F4E79), fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }
}