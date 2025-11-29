import 'package:flutter/material.dart';
import 'splash_screen.dart';
// Import file tujuan navigasi
import 'seller/seller_home_screen.dart';
import 'buyer/buyer_main_layout.dart'; 

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controller untuk menangkap teks inputan
  final TextEditingController _usernameController = TextEditingController();
  bool _isSellerMode = false;

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1F4E79)),
          onPressed: () {
            // Kembali ke Splash Screen jika ditekan back
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const SplashScreen()));
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            // Logo Kecil
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: const Color(0xFF1F4E79),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.local_laundry_service_outlined, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'LAUNDRYIN',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1F4E79),
                letterSpacing: 1.5,
              ),
            ),
            Text(
              'Your Personal Laundry Assistant',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 40),

            // Toggle Mode (Untuk demo tugas)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Buyer"),
                  Switch(
                    activeColor: const Color(0xFF1F4E79),
                    value: _isSellerMode,
                    onChanged: (val) => setState(() => _isSellerMode = val),
                  ),
                  const Text("Seller"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Form Username
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Username or Email", style: TextStyle(color: Colors.grey[700], fontSize: 14)),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _usernameController, // Sambungkan Controller
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF2F4F7),
                hintText: "Masukkan nama kamu...",
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(30),
                   borderSide: const BorderSide(color: Color(0xFF1F4E79), width: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Form Password
             Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text("Password", style: TextStyle(color: Colors.grey[700], fontSize: 14)),
                  const Text("*", style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF2F4F7),
                hintText: "Enter your password",
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(30),
                   borderSide: const BorderSide(color: Color(0xFF1F4E79), width: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  text: "Don't have an account yet? ",
                  style: TextStyle(color: Colors.grey[600]),
                  children: const [
                    TextSpan(
                      text: "Register",
                      style: TextStyle(color: Color(0xFF1F4E79), fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Button Login
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Logika untuk mengirim nama user
                  String usernameInput = _usernameController.text.trim();
                  
                  // Jika kosong, kasih default name biar tidak error
                  if (usernameInput.isEmpty) {
                    usernameInput = _isSellerMode ? "Admin Seller" : "Pengguna Baru";
                  }

                  if (_isSellerMode) {
                    // Masuk ke Halaman Seller
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (_) => SellerHomeScreen(username: usernameInput))
                    );
                  } else {
                    // Masuk ke Halaman Buyer Layout (yang ada Navigasi Bawahnya)
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (_) => BuyerMainLayout(username: usernameInput))
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F4E79),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 5,
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}