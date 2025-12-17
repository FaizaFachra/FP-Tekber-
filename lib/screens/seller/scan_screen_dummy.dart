import 'package:flutter/material.dart';

class ScanScreenDummy extends StatelessWidget {
  const ScanScreenDummy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Pindai Kode QR", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text("Arahkan kamera ke QR Code Pelanggan", 
                  style: TextStyle(color: Colors.white70), textAlign: TextAlign.center),
              ),
            ),
          ),
          
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Column(
              children: [
                const Text("Atau Masukkan Kode", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Contoh: #QDJBJ12",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: () => Navigator.pop(context), 
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}