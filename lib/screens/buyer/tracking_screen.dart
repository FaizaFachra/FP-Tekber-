import 'package:flutter/material.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Pesanan", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1F4E79),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Status
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1F4E79),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_laundry_service, color: Colors.white, size: 40),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Status Laundry", style: TextStyle(color: Colors.white70)),
                      Text("SEDANG DICUCI", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            
            const Text("Tracking Progress", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            // Timeline Progress Dummy
            _buildTimelineItem("Diterima Seller", "19 Juli 10:00", true, true),
            _buildTimelineItem("Sedang Dicuci", "19 Juli 10:30", true, true),
            _buildTimelineItem("Sedang Dikeringkan", "Estimasi 12:00", true, false), // false means in progress/not done
            _buildTimelineItem("Disetrika", "Menunggu", false, false),
            _buildTimelineItem("Siap Diambil", "Menunggu", false, false),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem(String title, String time, bool isActive, bool isDone) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              height: 40,
              width: 2,
              color: isDone ? const Color(0xFF1F4E79) : Colors.grey[300],
            ),
            Icon(
              isActive ? Icons.check_circle : Icons.circle_outlined,
              color: isActive ? const Color(0xFF1F4E79) : Colors.grey,
            ),
             Container(
              height: 40,
              width: 2,
              color: isDone ? const Color(0xFF1F4E79) : Colors.grey[300],
            ),
          ],
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: isActive ? Colors.blue[50] : Colors.white,
              border: Border.all(color: isActive ? const Color(0xFF1F4E79) : Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyle(fontWeight: isActive ? FontWeight.bold : FontWeight.normal, color: isActive ? const Color(0xFF1F4E79) : Colors.black)),
                Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        )
      ],
    );
  }
}