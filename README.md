# myportofolio_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# Tugas 7
1. Apa yang dimaksud dengan widget tree dan bagaimana hubungan parent-child bekerja?
    Jadi widget tree adalah susunan widget yang berbentuk hierarki yang membentuk antarmuka flutter. Widget induk membungkus atau menyusun widget anak, misalnya Padding yang punya satu child, sedangkan Column punya daftar children.
    Di proyek ini, MyApp membangun MaterialApp dengan MyHomePage sebagai halaman awal. MyHomePage membangun Scaffold, yang berisi AppBar dan bagian body. Di dalam body, Column menyusun baris kartu identitas dan area menu. Row menata InfoCard secara horizontal, sedangkan GridView.count menata ItemCard dalam tiga kolom. Susunan yang seperti ini bisa membantu dalam memisahkan tanggung jawab antar komponen. Dalam proses layout, batasan ukuran diteruskan dari induk ke anak; anak menentukan ukurannya sesuai batasan, kemudian induk menentukan posisi anak.

2. Widget yang digunakan dan fungsinya
    - MyApp = Widget aplikasi yang membangun konfigurasi utama.
    - MaterialApp = Mengatur tema, judul aplikasi, dan halaman awal.
    - MyHomePage = Menggabungkan identitas dan menu pada halaman utama.
    - Scaffold = Menyediakan struktur halaman Material, termasuk app bar dan body.
    - AppBar = Menampilkan judul MyPortfolio pada bagian atas.
    - Text = Menampilkan identitas, judul, nama menu, dan isi pesan.
    - Padding = Memberi ruang di sekitar widget anak.
    - Column = Menyusun beberapa widget secara vertikal.
    - Row = Menyusun kartu identitas secara horizontal.
    - SizedBox = Memberikan jarak, misalnya antara judul kartu dan isinya.
    - Center = 	Menempatkan anak di tengah ruang yang tersedia.
    - GridView.count = Menata kartu menu dengan jumlah kolom tertentu.
    - InfoCard = Widget buatan sendiri untuk menampilkan judul dan nilai identitas.
    - Card = Memberikan bentuk kartu dan elevasi pada InfoCard.
    - Container = Mengatur ukuran dan padding isi kartu.
    - ItemCard = Widget buatan sendiri untuk menampilkan satu aksi portofolio.
    - Material = Memberikan permukaan berwarna dan tempat menggambar efek tinta.
    - InkWell = Mendeteksi ketukan serta memberikan efek visual saat kartu ditekan.
    - Icon = Menampilkan simbol untuk setiap menu.
    - SnackBar = Menampilkan pesan singkat sebagai respons terhadap ketukan.
    - Theme = Diakses melalui Theme.of(context) untuk membaca tema, misalnya warna AppBar.
    - MediaQuery = Diakses melalui MediaQuery.of(context) untuk memperoleh ukuran layar.
    - ScaffoldMessenger = Diakses melalui ScaffoldMessenger.of(context) untuk mengelola SnackBar.

3. Fungsi MaterialApp dan alasan penggunaannya sebagai root widget?
    MaterialApp menyediakan konfigurasi tingkat aplikasi untuk antarmuka Material Design. Di proyek ini, properti title itu yang menentukan judul aplikasi, theme menentukan tema, dan home menentukan halaman awal. MaterialApp juga mendukung navigasi dan menyediakan infrastruktur yang digunakan oleh banyak komponen Material, termasuk pengelolaan SnackBar melalui ScaffoldMessenger.
    Widget ini biasanya ditempatkan di dekat akar widget tree agar konfigurasi yang sama bisa dipakai sama halaman-halaman di bawahnya.

4. Perbedaan StatelessWidget dan StatefulWidget?
    StatelessWidget tidak punya objek State buat menyimpan state internal yang bisa berubah. Tampilannya dibangun dari konfigurasi dan context. Widget ini tetap bisa dibuat ulang saat konfigurasi dari induk atau data inherited yang dipakainya berubah.
    Sedangkan StatefulWidget punya objek State yang terpisah buat mengelola data yang berubah selama widget nya digunakan. Objek widget-nya sendiri tetap immutable. Ketika data pada State berubah, setState() bisa digunakan untuk memberi tahu framework agar menjadwalkan pembangunan ulang tampilannya.
    StatelessWidget cocok untuk kartu identitas dan menu pada proyek ini, karena komponen nya tidak mengelola data internal yang berubah. StatefulWidget juga cocok sebagai penghitung, status pilihan, atau tampilan dengan data internal yang berubah karena interaksi atau bisa juga karena proses asynchronus.

5. BuildContext dan penggunaannya dalam method build
    BuildContext adalah pegangan untuk lokasi suatu widget di dalam tree. Context membantu Flutter menemukan layanan atau data dari ancestor yang sesuai. Parameter context di Widget build(BuildContext context) memungkinkan widget membuat tampilan sesuai lingkungan tempatnya. Di proyek ini, Theme.of(context) mengambil tema, MediaQuery.of(context) memperoleh informasi layar, dan ScaffoldMessenger.of(context) menemukan pengelola SnackBar. Context harus di bawah penyedia layanan yang dicari. Context di method build sebuah widget juga berbeda dari context milik widget anak yang baru dihasilkan oleh method tersebut. Karena itu, lokasi penggunaan context memengaruhi hasil pencarian ancestor.

6. Hot reload, hot restart, dan full restart
    Hot reload memasukkan perubahan kode dan membangun ulang widget tree sambil mempertahankan state aplikasi. Cara ini cocok untuk mencoba perubahan teks, warna, atau layout. Hot reload tidak menjalankan ulang main() maupun initState(). Kalau di terminal flutter run, perintahnya adalah r. 
    Hot restart memulai ulang aplikasi Flutter dan menghapus state runtime sehingga proses inisialisasi dijalankan kembali. Pada terminal, perintahnya adalah R. Hot restart diperlukan ketika perubahan harus diterapkan melalui proses inisialisasi ulang, state lama mengganggu pemeriksaan, atau perubahan struktur kode tidak didukung oleh hot reload.
    Full restart dilakukan dengan menghentikan aplikasi dan menjalankannya lagi. Ini diperlukan untuk perubahan yang memerlukan build ulang bagian native, misalnya kode Kotlin/Java/Swift/Objective-C atau konfigurasi platform tertentu. Jika terdapat kesalahan kompilasi, kode harus diperbaiki terlebih dahulu; melakukan restart saja tidak memperbaiki kesalahan tersebut.


AI Disclosure
 Pada tugas ini saya menggunakan bantuan declarative AI (ChatGPT) sebagai pembantu saya dalam menyelesaikan tugas ini, saya menggunakan bantuan AI untuk memahami perubahan code yang saya lakukan pada tugas ini. Apa yang saya lakukan dengan generative AI saat saya mengerjakan tugas ini adalah, saya bertanya pada AI pada bagian bagian code saya. Misal saya menemukan error dan buntu untuk memperbaiki nya, saya mengscreenshoot error nya dan memberikan nya ke AI agar tau apa yang kesalahan yang saya lakukan dan bisa memahami nya. berikut prompt yang saya gunakan:
    - "Aku sudah melakukan pengisian sesuai instruksi, tetapi kenapa masih ada error? , tolong jelaskan errornya, dan jika ketemu error yang seperti ini apa yang harus dilakukan"
    