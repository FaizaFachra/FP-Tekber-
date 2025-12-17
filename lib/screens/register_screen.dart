import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  
  String _selectedRole = 'buyer'; 
  bool _isLoading = false;

  Future<void> _register() async {
    setState(() => _isLoading = true);

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final username = _usernameController.text.trim();
    final phone = _phoneController.text.trim();

    try {
      final AuthResponse res = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      final User? user = res.user;

      if (user != null) {
        await Supabase.instance.client.from('profiles').insert({
          'id': user.id,               
          'username': username,
          'role': _selectedRole,       
          'phone_number': phone,
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registrasi Berhasil! Silakan Login.')),
          );
          Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen())
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
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
        title: const Text("Daftar Akun Baru"),
        backgroundColor: const Color(0xFF1F4E79),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.person_add, size: 80, color: Color(0xFF1F4E79)),
            const SizedBox(height: 20),
            
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: "Username", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: "Nomor HP", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: _selectedRole,
              decoration: const InputDecoration(labelText: "Daftar Sebagai", border: OutlineInputBorder()),
              items: const [
                DropdownMenuItem(value: 'buyer', child: Text("Buyer (Pelanggan)")),
                DropdownMenuItem(value: 'seller', child: Text("Seller (Laundry)")),
              ],
              onChanged: (val) => setState(() => _selectedRole = val!),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _register,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1F4E79)),
                child: _isLoading 
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Daftar Sekarang", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}