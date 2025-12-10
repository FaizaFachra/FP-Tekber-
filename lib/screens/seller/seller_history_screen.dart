import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SellerHistoryScreen extends StatelessWidget {
  const SellerHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Pesanan Selesai", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1F4E79),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: Supabase.instance.client
            .from('orders')
            .stream(primaryKey: ['id'])
            .eq('status', 'Selesai') // FILTER HANYA YANG SELESAI
            .order('created_at', ascending: false),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada riwayat pesanan selesai."));
          }
          final orders = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: const CircleAvatar(backgroundColor: Colors.green, child: Icon(Icons.check, color: Colors.white)),
                  title: Text(order['buyer_name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("${order['service_type']} - Rp ${order['total_price']}"),
                  trailing: Text(order['created_at'].toString().substring(0, 10)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}