import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({super.key});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final TextEditingController _nameController = TextEditingController();
  
  
  bool isKiloan = false;
  bool isSatuan = false;
  bool isBedcover = false;
  bool isExpress = false;
  
  bool _isLoading = false;

  
  int _calculatePrice() {
    int total = 0;
    if (isKiloan) total += 45000;
    if (isSatuan) total += 30000;
    if (isBedcover) total += 20000;
    
    if (isExpress) total += 10000;
    return total;
  }

  Future<void> _submitOrder() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nama pelanggan wajib diisi!")),
      );
      return;
    }

    if (!isKiloan && !isSatuan && !isBedcover) {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pilih minimal satu layanan!")),
      );
      return;
    }

    setState(() => _isLoading = true);

    List<String> services = [];
    if (isKiloan) services.add("Kiloan");
    if (isSatuan) services.add("Satuan");
    if (isBedcover) services.add("Bedcover");
    if (isExpress) services.add("Express");
    String serviceString = services.join(", ");

    try {
      await Supabase.instance.client.from('orders').insert({
        'buyer_name': name,
        'service_type': serviceString,
        'total_price': _calculatePrice(),
        'status': 'Dicuci', 
        'estimate_date': DateTime.now().add(const Duration(days: 2)).toIso8601String(), // Estimasi 2 hari
      });

      if (mounted) {
        
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(color: Colors.green[100], shape: BoxShape.circle),
                  child: const Icon(Icons.check, color: Colors.green, size: 40),
                ),
                const SizedBox(height: 20),
                const Text("Pesanan Berhasil!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const Text("Data masuk ke database."),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); 
                  Navigator.pop(context); 
                },
                child: const Text("OK"),
              )
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Gagal: $e")));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    int currentTotal = _calculatePrice();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Pesanan", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1F4E79),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Nama Pelanggan", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: "Masukkan nama...",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            
            const Text("Pilih Layanan", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            
            _buildCheckbox("Cuci Kiloan (Reguler)", isKiloan, (val) => setState(() => isKiloan = val!)),
            _buildCheckbox("Cuci Satuan (Jas/Gaun)", isSatuan, (val) => setState(() => isSatuan = val!)),
            _buildCheckbox("Bedcover / Selimut", isBedcover, (val) => setState(() => isBedcover = val!)),
            
            const Divider(),
            _buildCheckbox("Layanan Express (1 Hari)", isExpress, (val) => setState(() => isExpress = val!)),
            
            const SizedBox(height: 30),
            
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Estimasi Total:", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Rp $currentTotal", style: TextStyle(color: const Color(0xFF1F4E79), fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitOrder,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1F4E79)),
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Buat Pesanan", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCheckbox(String title, bool value, Function(bool?) onChanged) {
    return CheckboxListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: const Color(0xFF1F4E79),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
    );
  }
}