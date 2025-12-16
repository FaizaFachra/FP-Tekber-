import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'splash_screen.dart';
import 'register_screen.dart';
// Import halaman tujuan
import 'buyer/buyer_main_layout.dart';
import 'seller/seller_main_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Kita butuh Email & Password, bukan Username
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // --- FUNGSI LOGIN ASLI ---
  Future<void> _login() async {
    setState(() => _isLoading = true);
    
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      // 1. Cek Email & Password ke Supabase Auth
      final AuthResponse res = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      final User? user = res.user;

      if (user != null) {
        // 2. Kalau login sukses, ambil data 'role' & 'username' dari tabel profiles
        //    Kita filter berdasarkan id user yang sedang login
        final data = await Supabase.instance.client
            .from('profiles')
            .select()
            .eq('id', user.id)
            .single(); // .single() artinya kita yakin cuma ada 1 data

        final String role = data['role'] ?? 'buyer';
        final String username = data['username'] ?? 'User';

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login Berhasil!')),
          );

          // 3. Arahkan ke halaman sesuai Role
          if (role == 'seller') {
             Navigator.pushReplacement(
              context, 
              MaterialPageRoute(builder: (_) => SellerMainLayout(username: username))
            );
          } else {
             Navigator.pushReplacement(
              context, 
              MaterialPageRoute(builder: (_) => BuyerMainLayout(username: username))
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        // Tampilkan error jika email/password salah
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Gagal: Pastikan Email & Password Benar.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
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
            Container(
              height: 100, width: 100,
              decoration: BoxDecoration(
                color: const Color(0xFF1F4E79),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.local_laundry_service_outlined, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'LAUNDRYIN',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF1F4E79), letterSpacing: 1.5),
            ),
            Text('Your Personal Laundry Assistant', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            
            const SizedBox(height: 40),

            // Form Email (Bukan Username lagi)
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Email Address", style: TextStyle(color: Colors.grey[700], fontSize: 14)),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF2F4F7),
                hintText: "Contoh: hafidz@test.com",
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),
            
            // Form Password
             Align(
              alignment: Alignment.centerLeft,
              child: Text("Password", style: TextStyle(color: Colors.grey[700], fontSize: 14)),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF2F4F7),
                hintText: "Masukkan password...",
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
              ),
            ),
            
            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account yet? ", style: TextStyle(color: Colors.grey[600])),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen()));
                  },
                  child: const Text("Register", style: TextStyle(color: Color(0xFF1F4E79), fontWeight: FontWeight.bold)),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Tombol Login
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _login, // Panggil fungsi _login
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F4E79),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 5,
                ),
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Login", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}