import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Tambahkan import ini
import 'screens/splash_screen.dart'; 

void main() async {
  // Pastikan binding flutter siap
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Supabase
  await Supabase.initialize(
    url: 'https://znzhhtkffaoivzxaumbi.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpuemhodGtmZmFvaXZ6eGF1bWJpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQzOTU2NjgsImV4cCI6MjA3OTk3MTY2OH0.swKsevYpYskPo_LV21JwtDrfv-eg56sBW8OIsFX5YCo',
  );

  runApp(const LaundryInApp());
}

// ... class LaundryInApp ke bawah biarin aja

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