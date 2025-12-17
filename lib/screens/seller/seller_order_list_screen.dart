import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SellerOrderListScreen extends StatefulWidget {
  const SellerOrderListScreen({super.key});

  @override
  State<SellerOrderListScreen> createState() => _SellerOrderListScreenState();
}

class _SellerOrderListScreenState extends State<SellerOrderListScreen> {
  Future<void> _updateStatus(int orderId, String newStatus) async {
    try {
      await Supabase.instance.client
          .from('orders')
          .update({'status': newStatus})
          .eq('id', orderId);
      
      if (mounted) {
        Navigator.pop(context); 
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Status diubah ke $newStatus")));
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  void _showUpdateDialog(BuildContext context, Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Update Pesanan: ${order['buyer_name']}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              _buildStatusOption(order['id'], "Dicuci", Colors.blue),
              _buildStatusOption(order['id'], "Disetrika", Colors.orange),
              _buildStatusOption(order['id'], "Selesai", Colors.green),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusOption(int id, String status, Color color) {
    return ListTile(
      leading: Icon(Icons.circle, color: color, size: 15),
      title: Text("Ubah ke status: $status"),
      onTap: () => _updateStatus(id, status),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kelola Pesanan", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1F4E79),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: Supabase.instance.client
            .from('orders')
            .stream(primaryKey: ['id'])
            .order('created_at', ascending: false),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada pesanan."));
          }
          final orders = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF1F4E79),
                    child: Text(order['buyer_name'][0].toUpperCase(), style: const TextStyle(color: Colors.white)),
                  ),
                  title: Text(order['buyer_name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("${order['service_type']} - ${order['status']}"),
                  trailing: const Icon(Icons.edit, size: 20, color: Colors.grey),
                  onTap: () => _showUpdateDialog(context, order), 
                ),
              );
            },
          );
        },
      ),
    );
  }
}