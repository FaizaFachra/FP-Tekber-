import 'package:flutter/material.dart';
import 'buyer_home_screen.dart';
import 'profile_screen.dart';

class BuyerMainLayout extends StatefulWidget {
  final String username;
  const BuyerMainLayout({super.key, required this.username});

  @override
  State<BuyerMainLayout> createState() => _BuyerMainLayoutState();
}

class _BuyerMainLayoutState extends State<BuyerMainLayout> {
  int _selectedIndex = 0; // Tab yang aktif (0 = Home)

  // Daftar halaman untuk tiap tab
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
       BuyerHomeScreen(username: widget.username), // Tab 0: Home
       const Center(child: Text("Halaman Riwayat (Coming Soon)")), // Tab 1: Riwayat
       const Center(child: Text("Halaman Chat (Coming Soon)")), // Tab 2: Chat
       const ProfileScreen(), // Tab 3: Profil & Logout
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menampilkan halaman sesuai tab yang dipilih
      body: _screens[_selectedIndex],
      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF1F4E79),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Riwayat"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}