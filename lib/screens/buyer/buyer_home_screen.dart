import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'tracking_screen.dart';

class BuyerHomeScreen extends StatelessWidget {
  final String username;

  const BuyerHomeScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- HEADER (SAMA SEPERTI SEBELUMNYA) ---
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
                  top: 50, left: 0, right: 0,
                  child: Center(child: const Text("LAUNDRYIN", style: TextStyle(color: Colors.white, letterSpacing: 2))),
                ),
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

            // --- STATUS CARD (YANG KITA UBAH JADI REAL-TIME) ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: StreamBuilder<List<Map<String, dynamic>>>(
                // Query: Ambil pesanan dimana buyer_name == username login, urutkan terbaru, ambil 1 aja
                stream: Supabase.instance.client
                    .from('orders')
                    .stream(primaryKey: ['id'])
                    .eq('buyer_name', username) 
                    .order('created_at', ascending: false)
                    .limit(1),
                builder: (context, snapshot) {
                  // KONDISI 1: Loading
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // KONDISI 2: Tidak ada pesanan aktif
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
                      child: const Center(child: Text("Belum ada laundry aktif saat ini.", style: TextStyle(color: Colors.grey))),
                    );
                  }

                  // KONDISI 3: Ada Data!
                  final order = snapshot.data![0];
                  final status = order['status'] ?? 'Proses';
                  final date = order['created_at'] != null 
                      ? order['created_at'].toString().substring(0, 10) // Ambil tanggalnya aja
                      : '-';

                  return Container(
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
                                children: [
                                  const Text("Laundry Selesai Dalam", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                                  const SizedBox(height: 10),
                                  Text("Tanggal masuk : $date", style: const TextStyle(color: Colors.white70, fontSize: 12)),
                                  Text("Status            : $status", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
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
                        
                        // Tombol Lihat Progress
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const TrackingScreen()));
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: const BoxDecoration(
                              color: Color(0xFF1F4E79),
                              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                            ),
                            child: const Center(child: Text("Lihat Progress >", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 25),

            // Riwayat Title (Statis dulu biar gak kepanjangan kodenya)
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
             SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  _buildHistoryCard("17/07/2025", "Cuci Express", "Rp 90.000"),
                  _buildHistoryCard("10/07/2025", "Cuci Biasa", "Rp 76.000"),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
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