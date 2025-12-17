LaundryIn

LaundryIn adalah aplikasi manajemen laundry berbasis mobile yang dirancang untuk mempermudah proses transaksi, pelacakan status, dan komunikasi antara Buyer (Pelanggan) dan Seller (Penyedia Jasa Laundry).

Aplikasi ini dibangun menggunakan Flutter untuk antarmuka pengguna (Frontend) dan Supabase sebagai layanan Backend as a Service (BaaS) untuk menangani database, autentikasi, dan pembaruan data secara real-time.

📱 Fitur Utama

Untuk Buyer (Pelanggan)

- Tracking Real-time: Memantau status cucian (Diterima -> Dicuci -> Dikeringkan -> Selesai) secara langsung.

- Riwayat Transaksi: Melihat daftar pesanan yang sudah selesai.

- Chat: Berkomunikasi langsung dengan admin laundry.

- Scan QR: Fitur untuk mempermudah identifikasi pesanan.

Untuk Seller (Admin Laundry)

- Dashboard Operasional: Melihat jumlah pesanan aktif dan statistik harian.

- Manajemen Pesanan: Membuat pesanan baru dan mengubah status pengerjaan (Update Status).

- Chat Admin: Membalas pesan dari pelanggan.

- Riwayat: Rekapitulasi pesanan yang telah selesai.

🛠️ Teknologi yang Digunakan

Frontend: Flutter (Dart) - Framework UI lintas platform.

Backend: Supabase - Open Source Firebase Alternative (PostgreSQL, Auth, Realtime).

Design: Material Design 3 (Google).

⚙️ Cara Instalasi

Ikuti langkah-langkah berikut untuk menjalankan proyek ini di komputer lokal Anda:

Prasyarat

Pastikan Flutter SDK sudah terinstal. Cek dengan perintah flutter doctor.

Miliki akun Supabase dan buat proyek baru.

Langkah Instalasi

Clone Repository
Buka terminal dan jalankan perintah:

git clone [https://github.com/FaizaFachra/FP-Tekber-Kelompok-1-Kelas-A)
cd FP-Tekber-Kelompok-1-Kelas-A


Install Dependencies
Unduh paket-paket yang diperlukan (seperti supabase_flutter):

flutter pub get


Konfigurasi Supabase

Buka file lib/main.dart.

Cari bagian Supabase.initialize.

Pastikan URL dan Anon Key sudah terisi dengan benar (Gunakan kredensial berikut atau milik Anda sendiri):

await Supabase.initialize(
  url: '[https://znzhhtkffaoivzxaumbi.supabase.co](https://znzhhtkffaoivzxaumbi.supabase.co)',
  anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpuemhodGtmZmFvaXZ6eGF1bWJpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQzOTU2NjgsImV4cCI6MjA3OTk3MTY2OH0.swKsevYpYskPo_LV21JwtDrfv-eg56sBW8OIsFX5YCo',
);


Setup Database (Tabel)
Buat tabel berikut di dashboard Supabase Anda (SQL Editor):

profiles: (id uuid, username text, role text)

orders: (id int8, buyer_name text, service_type text, status text, total_price int, created_at timestamp)

messages: (id int8, content text, sender text, receiver text, created_at timestamp)

▶️ Cara Menjalankan Aplikasi

Setelah instalasi selesai, Anda dapat menjalankan aplikasi melalui terminal atau VS Code.

Menjalankan di Emulator / Device

Pastikan emulator (Android/iOS) sudah berjalan atau HP terhubung via USB.

flutter run


Tips Pengujian (Role-Based)

Karena aplikasi ini memiliki dua sisi (Buyer & Seller) dalam satu aplikasi:

Register Akun Baru:

Pilih peran "Seller" saat mendaftar untuk mengakses fitur Admin.

Pilih peran "Buyer" saat mendaftar untuk mengakses fitur Pelanggan.

Simulasi Real-time:

Buka aplikasi di dua device (atau 1 HP + 1 Emulator).

Login sebagai Seller di satu device dan Buyer di device lain.

Ubah status pesanan di Seller, dan lihat perubahannya di Buyer secara langsung!

📂 Struktur Folder

Berikut adalah struktur folder utama dalam proyek ini agar mudah dipahami:

lib/
├── main.dart                  # Entry point aplikasi & Inisialisasi Supabase
├── screens/                   # Halaman-halaman aplikasi (UI)
│   ├── splash_screen.dart     # Halaman pembuka (Welcome)
│   ├── login_screen.dart      # Halaman Login
│   ├── register_screen.dart   # Halaman Pendaftaran
│   ├── chat_screen.dart       # Halaman Room Chat (Umum)
│   │
│   ├── buyer/                 # Fitur Khusus Buyer (Pelanggan)
│   │   ├── buyer_main_layout.dart  # Navigasi Utama Buyer
│   │   ├── buyer_home_screen.dart  # Dashboard Buyer
│   │   ├── tracking_screen.dart    # Timeline Status Cucian
│   │   ├── history_screen.dart     # Riwayat Pesanan Buyer
│   │   ├── chat_list_screen.dart   # Daftar Chat Buyer
│   │   └── profile_screen.dart     # Profil Buyer
│   │
│   └── seller/                # Fitur Khusus Seller (Admin)
│       ├── seller_main_layout.dart # Navigasi Utama Seller
│       ├── seller_home_screen.dart # Dashboard Seller
│       ├── add_order_screen.dart   # Form Tambah Pesanan
│       ├── seller_order_list.dart  # Daftar & Update Status Pesanan
│       ├── seller_history.dart     # Riwayat Pesanan Selesai
│       ├── seller_chat_list.dart   # Daftar Pesan Masuk Seller
│       └── seller_profile.dart     # Profil Seller
└── ...
