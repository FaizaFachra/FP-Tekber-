import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'seller_order_list_screen.dart';
import 'scan_screen_dummy.dart';
import 'seller_history_screen.dart'; // Import History
import 'seller_chat_list_screen.dart'; // Import Chat List

class SellerHomeScreen extends StatelessWidget {
  final String username;

  const SellerHomeScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F4E79),
      body: Stack(
        children: [
          // Background
          Positioned(
            top: 0, left: 0, right: 0, height: 300,
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: NetworkImage("https://images.unsplash.com/photo-1545173168-9f1947eebb8f?q=80&w=2071&auto=format&fit=crop"), 
                  fit: BoxFit.cover,
                ),
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          
          // Header Text & Chat Icon
          Positioned(
            top: 50, left: 20, right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("LAUNDRYIN", style: TextStyle(color: Colors.white70, fontSize: 12, letterSpacing: 2)),
                    const SizedBox(height: 5),
                    Text("Halo $username !", style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
                // TOMBOL CHAT DI HEADER
                IconButton(
                  icon: const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 28),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerChatListScreen()));
                  },
                )
              ],
            ),
          ),

          // Main Card (Jumlah Pesanan)
          Positioned(
            top: 140, left: 24, right: 24,
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  children: [
                    const Text("Jumlah Pesanan Laundry", style: TextStyle(color: Color(0xFF1F4E79), fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    StreamBuilder<List<Map<String, dynamic>>>(
                      stream: Supabase.instance.client.from('orders').stream(primaryKey: ['id']),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const Text("-", style: TextStyle(fontSize: 40));
                        return Text(snapshot.data!.length.toString(), style: const TextStyle(color: Color(0xFF1F4E79), fontSize: 80, fontWeight: FontWeight.bold));
                      },
                    ),
                    const SizedBox(height: 10),
                    Text("Data Real-time", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),

          // Menu Buttons (Riwayat Sudah Dihidupkan)
          Positioned(
            top: 420, left: 24, right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerOrderListScreen())),
                  child: _buildSquareButton(Icons.assignment_outlined, "Daftar\nPesanan"),
                ),
                // TOMBOL RIWAYAT SEKARANG BISA DIKLIK
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerHistoryScreen())),
                  child: _buildSquareButton(Icons.history, "Riwayat"),
                ),
              ],
            ),
          ),

          // Scan Button
          Positioned(
            top: 540, left: 24, right: 24,
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ScanScreenDummy())),
              child: Container(
                height: 80,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.qr_code_scanner, size: 35, color: Color(0xFF1F4E79)),
                    SizedBox(height: 5),
                    Text("Scan QR Pelanggan", style: TextStyle(color: Color(0xFF1F4E79), fontWeight: FontWeight.bold, fontSize: 12)),
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
      width: 150, height: 100,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
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