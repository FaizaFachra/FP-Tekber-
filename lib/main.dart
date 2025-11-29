import 'package:flutter/material.dart';
// Import file yang sudah kita pindahkan tadi:
import 'screens/splash_screen.dart'; 

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
          seedColor: const Color(0xFF1F4E79),
          primary: const Color(0xFF1F4E79),
          secondary: const Color(0xFF2D6DA3),
          surface: Colors.white,
        ),
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(), // Memanggil file splash_screen.dart
    );
  }
}