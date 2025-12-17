import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; 
import '../login_screen.dart'; 

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final user = Supabase.instance.client.auth.currentUser;
    final email = user?.email ?? "User LaundryIn";

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Profil Saya", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1F4E79),
        centerTitle: true,
        automaticallyImplyLeading: false, 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF1F4E79),
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 10),
            
            
            Text(email, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text("Buyer Account", style: TextStyle(color: Colors.grey)),
            
            const SizedBox(height: 30),
            
            
            
            _buildProfileItem(context, Icons.person_outline, "Edit Profil"),
            _buildProfileItem(context, Icons.notifications_outlined, "Notifikasi"),
            _buildProfileItem(context, Icons.lock_outline, "Keamanan"),
            
            
            const SizedBox(height: 20),
            
            
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  
                  await Supabase.instance.client.auth.signOut();
                  
                  
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (route) => false,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[50],
                  elevation: 0,
                  side: const BorderSide(color: Colors.red),
                ),
                child: const Text("Keluar (Logout)", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }

  
  Widget _buildProfileItem(BuildContext context, IconData icon, String title) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF1F4E79)),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Scaffold(
              appBar: AppBar(title: Text(title), backgroundColor: const Color(0xFF1F4E79), foregroundColor: Colors.white),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 80, color: Colors.grey[300]),
                    const SizedBox(height: 20),
                    Text("Fitur $title", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    const Text("Halaman ini sedang dalam pengembangan.", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            )),
          );
        },
      ),
    );
  }
}