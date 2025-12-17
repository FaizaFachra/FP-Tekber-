import 'package:flutter/material.dart';
import 'seller_home_screen.dart';
import 'seller_order_list_screen.dart'; 
import 'add_order_screen.dart'; 
import 'seller_profile_screen.dart';
import 'seller_history_screen.dart';

class SellerMainLayout extends StatefulWidget {
  final String username;
  const SellerMainLayout({super.key, required this.username});

  @override
  State<SellerMainLayout> createState() => _SellerMainLayoutState();
}

class _SellerMainLayoutState extends State<SellerMainLayout> {
  int _selectedIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
       SellerHomeScreen(username: widget.username), 
       const SellerOrderListScreen(),              
       const SellerHistoryScreen(), 
       const SellerProfileScreen(),   
    ];
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF1F4E79),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Pesanan"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Riwayat"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (_) => const AddOrderScreen()));
        },
        backgroundColor: const Color(0xFF1F4E79),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}