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



### Tugas 8

Pada tugas ini, saya menambahkan formulir Tambah Experience di
`lib/screens/experience_form.dart`. Formulir bisa dibuka dengan kartu
Tambah Experience pada halaman utama dan opsi Add Experience pada drawer.

Input formulir disesuaikan dengan model Experience pada proyek Django:
judul, deskripsi, kategori, URL thumbnail, dan tanggal selesai. Thumbnail
dan tanggal selesai bersifat opsional. Atribut started_at tidak menjadi
input karena pada model Django nilainya diisi secara otomatis.

Tombol Simpan menampilkan ringkasan seluruh isian setelah validasi berhasil.
Pada tahap ini, data belum dikirim atau disimpan ke backend Django.

1. Perbedaan Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop(), serta navigasi formulir dan Home

   Navigator.push() menambahkan halaman baru ke atas tumpukan navigasi.
   Halaman sebelumnya tetap berada di bawahnya sehingga pengguna dapat
   kembali ke halaman tersebut.

   Navigator.pushReplacement() mengganti halaman teratas dengan halaman
   baru. Halaman yang diganti tidak lagi tersedia sebagai tujuan kembali
   pada tumpukan tersebut.

   Navigator.pop() mengeluarkan route teratas. Dalam aplikasi ini, pop()
   juga digunakan untuk menutup drawer dan dialog ringkasan.

   Kartu Tambah Experience menggunakan Navigator.push() untuk membuka
   ExperienceFormPage. Dengan demikian, halaman utama tetap berada di
   bawah formulir dan dapat diakses menggunakan tombol kembali perangkat.

   Opsi Home pada drawer menutup drawer terlebih dahulu, kemudian memakai
   pushAndRemoveUntil() dengan kondisi yang selalu false. Cara ini membuka
   halaman utama dan menghapus seluruh route sebelumnya agar halaman
   formulir tidak menumpuk dalam riwayat navigasi.

2. Peran Scaffold, AppBar, dan Drawer dalam menjaga konsistensi halaman

   Scaffold menyediakan kerangka halaman, termasuk tempat untuk AppBar,
   drawer, dan isi halaman. AppBar menampilkan judul agar pengguna mengetahui
   halaman yang sedang dibuka. LeftDrawer digunakan kembali pada halaman
   utama, formulir proyek, dan formulir Experience sehingga menu navigasinya
   konsisten.

   Contoh penggunaan tema adalah warna latar AppBar pada halaman utama dan
   formulir Experience yang mengambil Theme.of(context).colorScheme.primary.
   Tombol Simpan pada formulir Experience juga menggunakan warna primary,
   sedangkan teksnya menggunakan onPrimary agar tetap terbaca.

3. Alasan pemilihan layout formulir dan peran widget pengatur jarak serta penggulir

   Saya menggunakan Column untuk menyusun input secara vertikal agar alur
   pengisian mudah diikuti. CrossAxisAlignment.stretch membuat input dan
   tombol menggunakan lebar yang tersedia.

   Padding memberi jarak antara isi formulir dan tepi layar, sedangkan
   SizedBox memberi jarak antarinput agar tampilannya tidak terlalu rapat.
   SafeArea membantu menjaga isi dari area antarmuka sistem.

   Column dibungkus SingleChildScrollView agar formulir dapat digulir ketika
   layar sempit atau papan ketik mengurangi ruang yang tersedia. Scaffold
   secara default menyesuaikan ukuran body saat papan ketik tampil.
   Isi dialog ringkasan juga dapat digulir jika teks yang dimasukkan panjang.

4. Peran GlobalKey<FormState>, validator, dan validate()

   GlobalKey<FormState> digunakan untuk mengakses state Form melalui
   _formKey.currentState. Setiap validator memeriksa nilai input dan
   mengembalikan pesan kesalahan jika nilainya tidak valid, atau null
   jika nilainya valid.

   Ketika Simpan ditekan, validate() menjalankan seluruh validator dalam
   formulir. Jika ada input yang tidak valid, proses dihentikan dan pesan
   kesalahan ditampilkan pada kolom terkait. Jika semuanya valid, save()
   menjalankan onSaved untuk mengambil nilai input, lalu showDialog()
   menampilkan ringkasannya dalam AlertDialog.

   Contoh nilai yang ditolak adalah judul berisi spasi saja. Setelah trim(),
   nilainya menjadi kosong sehingga tidak memenuhi aturan judul wajib.
   URL thumbnail seperti "asal" juga ditolak karena tidak memiliki skema
   dan host yang diperlukan.

   Pemilihan TextInputType.url hanya membantu menyediakan papan ketik
   yang sesuai. Pengguna masih dapat mengetik atau menempelkan teks
   sembarang, sehingga validator tetap diperlukan.

#### Cara menjalankan

Dari direktori utama proyek, jalankan:

```powershell
flutter pub get
flutter analyze
flutter run -d chrome


Alternatif yang saya gunakan untuk menjalankan aplikasi melalui server web:

```powershell
flutter run -d web-server --web-hostname 127.0.0.1 --web-port 8080


Buka http://127.0.0.1:8080 di browser dan biarkan proses terminal berjalan.

Untuk mencoba fitur, buka Tambah Experience dari kartu atau Add Experience
dari drawer. Isi formulir, lalu tekan Simpan untuk melihat ringkasan.
Tekan Tutup untuk kembali ke formulir dan gunakan Home pada drawer untuk
kembali ke halaman utama.

#### Penggunaan AI

Saya menggunakan ChatGPT untuk membantu memahami instruksi Tugas 8,
menyesuaikan field formulir dengan model Experience, menjelaskan error, serta membantu untuk membuat draf dokumentasi.

Strategi prompting yang saya gunakan adalah memberikan instruksi tugas,
dan meminta AI untuk membantu dalam menyesuaikan code. Setelah
menerapkan kode, saya mengirimkan screenshot hasil atau error untuk
mendapatkan penjelasan dan langkah perbaikan.

Ringkasan log interaksi:
- Memberikan kode Flutter dan model Django untuk menyesuaikan formulir.
- Meminta bantuan ketika terjadi kesalahan penulisan navigasi.
- Meminta bantuan ketika browser menampilkan ERR_CONNECTION_REFUSED.
- Mengirimkan hasil formulir dan dialog ringkasan untuk ditinjau.

Saya menerapkan kode ke proyek dan memperbaiki kesalahan penulisan
pushAndRemoveUntil serta penggunaan variabel navigator. Saya juga
menjalankan flutter analyze yang menghasilkan "No issues found" dan
mencoba pengisian formulir sampai dialog ringkasan muncul.

