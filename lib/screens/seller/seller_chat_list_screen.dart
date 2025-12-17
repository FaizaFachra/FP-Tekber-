import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../screens/chat_screen.dart'; 

class SellerChatListScreen extends StatelessWidget {
  const SellerChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const myName = "Admin Laundry";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesan Masuk", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1F4E79),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: Supabase.instance.client
            .from('messages')
            .stream(primaryKey: ['id'])
            .eq('receiver', myName)
            .order('created_at', ascending: false),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada pesan masuk."));
          }

          final allMessages = snapshot.data!;
          final Set<String> uniqueSenders = {};
          final List<Map<String, dynamic>> chatList = [];

          for (var msg in allMessages) {
            if (!uniqueSenders.contains(msg['sender'])) {
              uniqueSenders.add(msg['sender']);
              chatList.add(msg);
            }
          }

          return ListView.builder(
            itemCount: chatList.length,
            itemBuilder: (context, index) {
              final chat = chatList[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF1F4E79),
                  child: Text(chat['sender'][0].toUpperCase(), style: const TextStyle(color: Colors.white)),
                ),
                title: Text(chat['sender'], style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(chat['content'], maxLines: 1, overflow: TextOverflow.ellipsis),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(myName: myName, otherName: chat['sender']),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}