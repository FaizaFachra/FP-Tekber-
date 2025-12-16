import 'package:flutter/material.dart';
import 'buyer_home_screen.dart';
import 'profile_screen.dart';
// Import 2 file baru tadi
import 'history_screen.dart'; 
import 'chat_list_screen.dart';

class BuyerMainLayout extends StatefulWidget {
  final String username;
  const BuyerMainLayout({super.key, required this.username});

  @override
  State<BuyerMainLayout> createState() => _BuyerMainLayoutState();
}

class _BuyerMainLayoutState extends State<BuyerMainLayout> {
  int _selectedIndex = 0; // Tab yang aktif (0 = Home)

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
       BuyerHomeScreen(username: widget.username), // Tab 0: Home
       const HistoryScreen(),                      // Tab 1: Riwayat
       
       // PERBAIKAN DI SINI: Kirim username asli ke ChatListScreen
       // Hapus 'const' karena sekarang ada parameter variabel
       ChatListScreen(username: widget.username),  // Tab 2: Chat
       
       const ProfileScreen(),                      // Tab 3: Profil
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
      body: _screens[_selectedIndex],
      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF1F4E79),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: "Riwayat"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Pesan"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profil"),
        ],
      ),
      // SAYA PASTIKAN TIDAK MENAMBAHKAN FLOATING ACTION BUTTON DI SINI
    );
  }
}