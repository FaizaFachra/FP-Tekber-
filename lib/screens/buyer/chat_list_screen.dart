import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../screens/chat_screen.dart'; 

class ChatListScreen extends StatelessWidget {
  
  final String username;

 
  const ChatListScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    
    final myName = username; 

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
            builder: (_) => ChatScreen(myName: myName, otherName: name), 
          ),
        );
      },
    );
  }
}