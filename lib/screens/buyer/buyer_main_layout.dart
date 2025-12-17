import 'package:flutter/material.dart';
import 'buyer_home_screen.dart';
import 'profile_screen.dart';
import 'history_screen.dart'; 
import 'chat_list_screen.dart';

class BuyerMainLayout extends StatefulWidget {
  final String username;
  const BuyerMainLayout({super.key, required this.username});

  @override
  State<BuyerMainLayout> createState() => _BuyerMainLayoutState();
}

class _BuyerMainLayoutState extends State<BuyerMainLayout> {
  int _selectedIndex = 0; 

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
       BuyerHomeScreen(username: widget.username), 
       const HistoryScreen(),                      
       
       
       ChatListScreen(username: widget.username),  
       
       const ProfileScreen(),                      
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
      
    );
  }
}