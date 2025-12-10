import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../screens/login_screen.dart'; // Pastikan path import ini benar

class SellerProfileScreen extends StatelessWidget {
  const SellerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil email user yang sedang login
    final user = Supabase.instance.client.auth.currentUser;
    final email = user?.email ?? "Seller LaundryIn";

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Profil Seller", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1F4E79),
        centerTitle: true,
        automaticallyImplyLeading: false, // Hilangkan tombol back
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF1F4E79),
              child: Icon(Icons.store, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 10),
            
            // Tampilkan Email Asli
            Text(email, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text("Seller Account", style: TextStyle(color: Colors.grey)),
            
            const SizedBox(height: 30),
            
            // Panggil fungsi dengan parameter 'context'
            _buildProfileItem(context, Icons.store_mall_directory, "Info Toko"),
            _buildProfileItem(context, Icons.settings, "Pengaturan"),
            _buildProfileItem(context, Icons.help_outline, "Bantuan"),
            
            const SizedBox(height: 20),
            
            // TOMBOL LOGOUT SELLER
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  // 1. Logout Supabase
                  await Supabase.instance.client.auth.signOut();
                  
                  // 2. Balik ke Login
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

  // Fungsi helper yang sudah diperbaiki (pakai context)
  Widget _buildProfileItem(BuildContext context, IconData icon, String title) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF1F4E79)),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Navigasi ke halaman detail dummy
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