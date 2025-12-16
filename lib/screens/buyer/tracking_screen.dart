import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  // Fungsi untuk menentukan posisi step berdasarkan status teks
  int _getStatusStep(String status) {
    switch (status) {
      case 'Antrian': return 0;
      case 'Dicuci': return 1;
      case 'Dikeringkan': return 2;
      case 'Disetrika': return 3;
      case 'Selesai': return 4;
      default: return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ambil user yang login
    // Catatan: Idealnya pakai User ID, tapi demi kemudahan demo kita pakai logika Username == Buyer Name
    // Kita ambil pesanan TERBARU dari tabel orders
    final user = Supabase.instance.client.auth.currentUser;
    // (Di real app kita query profile dulu, tapi disini kita langsung stream data order saja)

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Pesanan", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1F4E79),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        // Query: Ambil 1 pesanan terakhir yang dibuat (order by created_at desc)
        // Kita asumsikan ini pesanan milik user yang sedang login (simple logic for demo)
        stream: Supabase.instance.client
            .from('orders')
            .stream(primaryKey: ['id'])
            .order('created_at', ascending: false)
            .limit(1),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
             return const Center(child: Text("Belum ada data pesanan."));
          }

          final order = snapshot.data![0];
          final String status = order['status'] ?? 'Antrian';
          final int currentStep = _getStatusStep(status);
          final String idOrder = order['id'].toString();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Status
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F4E79),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.local_laundry_service, color: Colors.white, size: 40),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Status Laundry", style: TextStyle(color: Colors.white70)),
                          Text(status.toUpperCase(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                          Text("#ORDER-$idOrder", style: const TextStyle(color: Colors.white54, fontSize: 12)),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                
                const Text("Tracking Progress", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),

                // Timeline Progress Real-time
                // Step 0: Antrian / Diterima
                _buildTimelineItem("Laundry Diterima", "Menunggu antrian...", currentStep >= 0, currentStep > 0),
                
                // Step 1: Dicuci
                _buildTimelineItem("Sedang Dicuci", "Pakaian sedang diproses mesin", currentStep >= 1, currentStep > 1),
                
                // Step 2: Dikeringkan
                _buildTimelineItem("Sedang Dikeringkan", "Proses pengeringan", currentStep >= 2, currentStep > 2),
                
                // Step 3: Disetrika
                _buildTimelineItem("Sedang Disetrika", "Finishing dan packing", currentStep >= 3, currentStep > 3),
                
                // Step 4: Selesai
                _buildTimelineItem("Siap Diambil", "Silakan ambil laundry Anda", currentStep >= 4, currentStep == 4),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimelineItem(String title, String subtitle, bool isActive, bool isDone) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Biar garisnya nyambung rapi
      children: [
        Column(
          children: [
            // Lingkaran Status
            Container(
              width: 30, height: 30,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF1F4E79) : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: isActive ? const Color(0xFF1F4E79) : Colors.grey[300]!, width: 2),
              ),
              child: Center(
                child: isDone 
                  ? const Icon(Icons.check, color: Colors.white, size: 18)
                  : (isActive ? const CircleAvatar(radius: 5, backgroundColor: Colors.white) : null),
              ),
            ),
            // Garis Penghubung (Kecuali item terakhir)
            if (title != "Siap Diambil") 
              Container(
                width: 2, height: 50,
                color: isDone ? const Color(0xFF1F4E79) : Colors.grey[300],
              ),
          ],
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 20), // Jarak antar kartu
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: isActive ? Colors.blue[50] : Colors.white,
              border: Border.all(color: isActive ? const Color(0xFF1F4E79) : Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: isActive ? FontWeight.bold : FontWeight.normal, color: isActive ? const Color(0xFF1F4E79) : Colors.black)),
                const SizedBox(height: 5),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        )
      ],
    );
  }
}