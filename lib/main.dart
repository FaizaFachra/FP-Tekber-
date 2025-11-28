import 'package:flutter/material.dart';

void main() {
  runApp(const LaundryInApp());
}

class LaundryInApp extends StatelessWidget {
  const LaundryInApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LaundryIn',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1F4E79), // Warna Biru Tua LaundryIn
          primary: const Color(0xFF1F4E79),
          secondary: const Color(0xFF2D6DA3),
          surface: Colors.white,
        ),
        fontFamily: 'Roboto',
      ),
      // UBAH HOME JADI SPLASH SCREEN DULU
      home: const SplashScreen(),
    );
  }
}

// ================== SCREEN 0: SPLASH / WELCOME SCREEN ==================
// Halaman ini sesuai gambar "Mulai" yang kamu kirim
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Logo Besar
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F4E79),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.local_laundry_service_rounded,
                  size: 100,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              // Judul Aplikasi
              const Text(
                "LAUNDRYIN",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1F4E79),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              // Slogan
              Text(
                "Your Personal Laundry Assistant",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const Spacer(),
              // Tombol Mulai
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // Pindah ke Halaman Login
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F4E79),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    "Mulai",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// ================== SCREEN 1: LOGIN ==================
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
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (_) => SellerHomeScreen(username: usernameInput))
                    );
                  } else {
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (_) => BuyerHomeScreen(username: usernameInput))
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

// ================== SCREEN 2: SELLER HOME ==================
class SellerHomeScreen extends StatelessWidget {
  final String username; // Variabel penampung username

  const SellerHomeScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F4E79),
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 300,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://images.unsplash.com/photo-1545173168-9f1947eebb8f?q=80&w=2071&auto=format&fit=crop"), 
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          ),
          
          // Header Text dengan Nama Dinamis
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("LAUNDRYIN", style: TextStyle(color: Colors.white70, fontSize: 12, letterSpacing: 2)),
                    const SizedBox(height: 5),
                    // DISINI NAMA AKAN BERUBAH SESUAI INPUT
                    Text("Halo $username !", style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.chat_bubble_outline, color: Colors.white),
                    SizedBox(width: 15),
                    Icon(Icons.more_vert, color: Colors.white),
                  ],
                )
              ],
            ),
          ),

          // Main Card
          Positioned(
            top: 140,
            left: 24,
            right: 24,
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  children: [
                    const Text("Jumlah Pesanan Laundry", 
                      style: TextStyle(color: Color(0xFF1F4E79), fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    const Text("3", 
                      style: TextStyle(color: Color(0xFF1F4E79), fontSize: 80, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text("Pengambilan Terdekat : 20 Juli 2025", 
                      style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),

          // Menu Buttons
          Positioned(
            top: 420, 
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSquareButton(Icons.assignment_outlined, "Daftar\nPesanan"),
                _buildSquareButton(Icons.history, "Riwayat"),
              ],
            ),
          ),

          // Scan Button
          Positioned(
            top: 540,
            left: 24,
            right: 24,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.qr_code_scanner, size: 40, color: Color(0xFF1F4E79)),
                  SizedBox(height: 5),
                  Text("Scan\nQR", textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF1F4E79), fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
            ),
          ),

          // Bottom Sheet Handle
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height: 4, width: 40, color: Colors.grey[400]),
                    const SizedBox(height: 8),
                    Text("Antrian Laundry", style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSquareButton(IconData icon, String label) {
    return Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: const Color(0xFF1F4E79)),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFF1F4E79), fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }
}

// ================== SCREEN 3: BUYER HOME ==================
class BuyerHomeScreen extends StatelessWidget {
  final String username; // Variabel penampung username

  const BuyerHomeScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://images.unsplash.com/photo-1517677208171-0bc6799a631e?q=80&w=2070&auto=format&fit=crop"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(color: Colors.black.withOpacity(0.4)),
                ),
                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: Center(child: const Text("LAUNDRYIN", style: TextStyle(color: Colors.white, letterSpacing: 2))),
                ),
                
                // Card Halo User
                Padding(
                  padding: const EdgeInsets.only(top: 180, left: 20, right: 20),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // DISINI NAMA AKAN BERUBAH SESUAI INPUT
                            Text("Halo, $username", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const Text("Scan untuk melanjutkan pesanan", style: TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                        const Icon(Icons.qr_code_2, size: 40, color: Color(0xFF1F4E79)),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Status Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2D5C8A),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Laundry Selesai Dalam", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                              SizedBox(height: 10),
                              Text("Tanggal masuk : 19 Juli 2025", style: TextStyle(color: Colors.white70, fontSize: 12)),
                              Text("Status             : Sedang Dicuci", style: TextStyle(color: Colors.white70, fontSize: 12)),
                            ],
                          ),
                          Container(
                            width: 60, height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("2", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                                Text("hari", style: TextStyle(color: Colors.white, fontSize: 10)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const BoxDecoration(
                        color: Color(0xFF1F4E79),
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                      ),
                      child: const Center(
                        child: Text("Lihat Progress >", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Riwayat Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Riwayat Transaksi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1F4E79))),
                  Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF1F4E79)),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // Riwayat List
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  _buildHistoryCard("17/07/2025", "Cuci Express", "Rp 90.000"),
                  _buildHistoryCard("10/07/2025", "Cuci Biasa", "Rp 76.000"),
                  _buildHistoryCard("05/07/2025", "Setrika", "Rp 40.000"),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF1F4E79),
        unselectedItemColor: Colors.grey[400],
        showUnselectedLabels: true,
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Riwayat"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Pesan"),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(String date, String type, String price) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          Text(date, style: const TextStyle(color: Color(0xFF1F4E79), fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(type, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          const SizedBox(height: 15),
          Text(price, style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}