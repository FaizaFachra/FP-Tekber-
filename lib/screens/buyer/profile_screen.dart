import 'package:flutter/material.dart';
import '../login_screen.dart'; // Import login untuk navigasi logout

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Profil Saya", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1F4E79),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Foto Profil Dummy
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF1F4E79),
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text("Hafidz User", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text("081234567890", style: TextStyle(color: Colors.grey)),
            
            const SizedBox(height: 30),
            
            // Menu Settings
            _buildProfileItem(Icons.person_outline, "Edit Profil"),
            _buildProfileItem(Icons.notifications_outlined, "Notifikasi"),
            _buildProfileItem(Icons.lock_outline, "Keamanan"),
            
            const SizedBox(height: 20),
            
            // TOMBOL LOGOUT
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Logika Logout: Hapus semua tumpukan layar, balik ke Login
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
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

  Widget _buildProfileItem(IconData icon, String title) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF1F4E79)),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}