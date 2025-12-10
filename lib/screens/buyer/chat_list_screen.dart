import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../screens/chat_screen.dart'; // Import chat screen

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil username kita (Dummy logic: ambil dari email/auth metadata biar cepet)
    // Skenario Demo: Kita asumsikan nama kita adalah username dari login tadi
    // Untuk mempermudah, kita ambil dari Order terakhir aja, siapa nama kita.
    
    // TAPI biar SATSET: Kita anggap saja user ini adalah "hafidz_buyer" (sesuaikan saat demo)
    // Dan lawan bicaranya adalah "Admin Laundry"
    final myName = "hafidz_buyer"; 

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesan", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1F4E79),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          _buildChatItem(context, "Admin Laundry", "Klik untuk chat dengan admin", myName),
          const Divider(height: 1),
          // Dummy lain biar rame
          _buildChatItem(context, "Kurir Laundry", "Pesanan sedang diantar...", myName), 
        ],
      ),
    );
  }

  Widget _buildChatItem(BuildContext context, String name, String message, String myName) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.grey[200],
        child: Icon(Icons.store, color: Colors.grey[600]),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(message, maxLines: 1, overflow: TextOverflow.ellipsis),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(myName: myName, otherName: name), // Masuk ke room chat
          ),
        );
      },
    );
  }
}