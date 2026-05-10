1. Deskripsi Aplikasi
  Aplikasi **Daftar Tugas Kuliah** dibuat untuk membantu pengguna dalam mencatat dan mengelola tugas kuliah. Setiap data tugas memiliki informasi berupa judul tugas, mata kuliah, deadline, jam, deskripsi, dan status tugas.
  Aplikasi ini menggunakan **MockAPI** sebagai tempat penyimpanan data. Dengan demikian, aplikasi dapat melakukan proses CRUD, yaitu:
    - Create: menambahkan tugas baru
    - Read: menampilkan daftar tugas
    - Update: mengedit data tugas dan mengubah status tugas
    - Delete: menghapus tugas


2. Fitur Aplikasi
  | No | Fitur | Keterangan |
  |---|---|---|
  | 1 | Menampilkan daftar tugas | Data tugas diambil dari MockAPI |
  | 2 | Menambahkan tugas | Pengguna dapat menambahkan tugas baru melalui form |
  | 3 | Validasi form | Input tidak boleh kosong sebelum data disimpan |
  | 4 | Melihat detail tugas | Pengguna dapat melihat informasi lengkap dari tugas |
  | 5 | Mengedit tugas | Data lama ditampilkan terlebih dahulu pada form edit |
  | 6 | Mengubah status tugas | Status tugas dapat diubah menjadi selesai atau belum selesai |
  | 7 | Menghapus tugas | Data dapat dihapus dengan dialog konfirmasi |
  | 8 | Filter tugas | Data dapat difilter berdasarkan Semua, Selesai, dan Belum |
  | 9 | FutureBuilder | Data API ditampilkan secara asynchronous |
  | 10 | GestureDetector | Digunakan pada kartu tugas, filter, tanggal, dan jam |


4. Struktur Folder Project
  ```text
  daftar_tugas_ariani_prak4
  ├── android
  ├── lib
  │   ├── models
  │   │   └── task_model.dart
  │   ├── pages
  │   │   ├── add_task_page.dart
  │   │   ├── detail_page.dart
  │   │   ├── edit_task_page.dart
  │   │   └── home_page.dart
  │   ├── services
  │   │   └── api_service.dart
  │   ├── widgets
  │   │   ├── filter_chip_widget.dart
  │   │   └── task_card.dart
  │   └── main.dart
  ├── pubspec.yaml
  └── README.md
  ```


5. Penjelasan Struktur Folder
  | Folder / File | Penjelasan |
  |---|---|
  | `models` | Berisi model data yang digunakan dalam aplikasi |
  | `task_model.dart` | Berisi struktur data tugas dan method untuk konversi JSON |
  | `pages` | Berisi halaman-halaman utama aplikasi |
  | `home_page.dart` | Halaman utama untuk menampilkan daftar tugas |
  | `add_task_page.dart` | Halaman untuk menambahkan tugas baru |
  | `detail_page.dart` | Halaman untuk melihat detail tugas |
  | `edit_task_page.dart` | Halaman untuk mengedit data tugas |
  | `services` | Berisi file yang menangani koneksi API |
  | `api_service.dart` | Berisi fungsi GET, POST, PUT, dan DELETE ke MockAPI |
  | `widgets` | Berisi komponen tampilan yang dapat digunakan kembali |
  | `filter_chip_widget.dart` | Widget filter status tugas |
  | `task_card.dart` | Widget kartu untuk menampilkan data tugas |
  | `main.dart` | File utama untuk menjalankan aplikasi |
  | `pubspec.yaml` | File konfigurasi dependency dan pengaturan Flutter |
  | `README.md` | File dokumentasi project |

7. Endpoint API
  Aplikasi ini menggunakan MockAPI sebagai database online.
  ```text
  https://69ff456b2b7ab349602f6f3b.mockapi.io/tugas/daftar_tugas
  ```

7. Struktur Data API
  Data tugas pada MockAPI memiliki beberapa field berikut:
  | Field | Tipe Data | Keterangan |
  |---|---|---|
  | `id` | String | ID unik dari MockAPI |
  | `judul` | String | Judul tugas |
  | `mataKuliah` | String | Nama mata kuliah |
  | `deadline` | String / Date | Tanggal deadline tugas |
  | `jam` | String | Jam deadline tugas |
  | `deskripsi` | String | Keterangan tugas |
  | `isDone` | Boolean | Status tugas selesai atau belum |
  
  Contoh data JSON:
  ```json
  {
    "id": "1",
    "judul": "Membuat Laporan Praktikum",
    "mataKuliah": "Teknologi Mobile",
    "deadline": "2026-05-14",
    "jam": "12:57",
    "deskripsi": "Lengkapi laporan praktikum sesuai format yang ada",
    "isDone": false
  }
  ```


8. Method API yang Digunakan
  | Method | Fungsi | Keterangan |
  |---|---|---|
  | GET | Mengambil data | Mengambil seluruh data tugas dari MockAPI |
  | POST | Menambahkan data | Menambahkan tugas baru ke MockAPI |
  | PUT | Memperbarui data | Mengubah data tugas berdasarkan ID |
  | DELETE | Menghapus data | Menghapus tugas berdasarkan ID |


9. Implementasi Navigasi
  Aplikasi ini menggunakan `Navigator.push()` untuk berpindah halaman dan `Navigator.pop()` untuk kembali ke halaman sebelumnya.
  
  Navigasi yang digunakan pada aplikasi:
  | Navigasi | Keterangan |
  |---|---|
  | HomePage → AddTaskPage | Membuka halaman tambah tugas |
  | HomePage → DetailPage | Membuka detail tugas yang dipilih |
  | DetailPage → EditTaskPage | Membuka halaman edit tugas |
  | AddTaskPage → HomePage | Kembali setelah tugas berhasil ditambahkan |
  | EditTaskPage → Detail/HomePage | Kembali setelah tugas berhasil diperbarui |
  
  Contoh navigasi ke halaman tambah tugas:
  ```dart
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const AddTaskPage()),
  );
  ```
  
  Contoh pengiriman data ke halaman detail:
  ```dart
  MaterialPageRoute(
    builder: (_) => DetailPage(task: task),
  )
  ```
  
  Contoh pengiriman data ke halaman edit:
  ```dart
  MaterialPageRoute(
    builder: (_) => EditTaskPage(task: widget.task),
  )
  ```


10. Implementasi Form dan Validasi
  Form input digunakan pada halaman tambah tugas dan edit tugas. Form ini menggunakan `TextFormField`, `TextEditingController`, dan `GlobalKey<FormState>`.
  Validasi digunakan agar data tidak boleh kosong sebelum disimpan ke MockAPI.
  
  Contoh validasi:
  ```dart
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Judul tidak boleh kosong';
    }
    return null;
  }
  ```
  
  Input yang digunakan pada form:
  - Judul tugas
  - Mata kuliah
  - Deadline
  - Jam
  - Deskripsi


11. Penggunaan Button
  Aplikasi menggunakan beberapa jenis button sesuai kebutuhan aksi.
  | Button | Fungsi |
  |---|---|
  | `FloatingActionButton.extended` | Membuka halaman tambah tugas |
  | `ElevatedButton` | Menyimpan, menghapus, atau mengubah status tugas |
  | `ElevatedButton.icon` | Mengubah status tugas dan update tugas |
  | `OutlinedButton.icon` | Membuka halaman edit tugas |
  | `TextButton` | Membatalkan dialog hapus |


12. Implementasi GestureDetector
  `GestureDetector` digunakan agar widget biasa dapat merespons sentuhan pengguna.
  GestureDetector digunakan pada:
  
  | Bagian | Interaksi |
  |---|---|
  | TaskCard | Tap untuk membuka detail tugas |
  | TaskCard | Long press untuk menampilkan dialog hapus |
  | FilterChipWidget | Tap untuk memilih filter |
  | Pilih deadline | Tap untuk membuka date picker |
  | Pilih jam | Tap untuk membuka time picker |



13. Implementasi FutureBuilder
  Data dari MockAPI ditampilkan menggunakan `FutureBuilder`. FutureBuilder digunakan karena proses pengambilan data dari API berjalan secara asynchronous.
  
  FutureBuilder menangani beberapa kondisi:
  | Kondisi | Tampilan |
  |---|---|
  | Loading | Menampilkan `CircularProgressIndicator` |
  | Error | Menampilkan pesan kesalahan |
  | Data kosong | Menampilkan pesan belum ada tugas |
  | Data berhasil | Menampilkan data tugas dalam bentuk list |
  
  Data tugas ditampilkan menggunakan `ListView.builder`.


14. Halaman Aplikasi
  Aplikasi terdiri dari beberapa halaman utama:
  a. Halaman Utama
  Halaman utama digunakan untuk menampilkan daftar tugas dari MockAPI. Halaman ini juga menyediakan filter status tugas dan tombol tambah tugas.
  
  b. Halaman Tambah Tugas
  Halaman tambah tugas digunakan untuk memasukkan data tugas baru. Form pada halaman ini memiliki validasi agar data tidak boleh kosong.
  
  c. Halaman Detail Tugas
  Halaman detail tugas digunakan untuk menampilkan informasi lengkap dari tugas yang dipilih. Pada halaman ini pengguna juga dapat mengubah status tugas dan membuka halaman edit.
  
  d. Halaman Edit Tugas
  Halaman edit tugas digunakan untuk memperbarui data tugas yang sudah ada. Data lama akan ditampilkan terlebih dahulu pada form sebelum diperbarui.
  
  e. Dialog Hapus Tugas
  Dialog hapus tugas muncul ketika pengguna menekan lama kartu tugas. Dialog ini digunakan untuk memastikan pengguna benar-benar ingin menghapus data.


15. Tampilan Aplikasi
  Beberapa tampilan yang terdapat pada aplikasi:
  - Tampilan halaman utama daftar tugas
  - Tampilan filter Semua, Selesai, dan Belum
  - Tampilan form tambah tugas
  - Tampilan validasi form kosong
  - Tampilan halaman detail tugas
  - Tampilan halaman edit tugas
  - Tampilan dialog konfirmasi hapus tugas
  - Tampilan data pada MockAPI


16. Hasil Pengujian
  | No | Fitur yang Diuji | Hasil |
  |---|---|---|
  | 1 | Navigasi dari halaman utama ke halaman tambah | Berhasil |
  | 2 | Navigasi dari halaman utama ke halaman detail | Berhasil |
  | 3 | Navigasi dari halaman detail ke halaman edit | Berhasil |
  | 4 | Kembali ke halaman sebelumnya menggunakan `Navigator.pop()` | Berhasil |
  | 5 | Pengiriman data dari halaman utama ke halaman detail | Berhasil |
  | 6 | Pengiriman data dari halaman detail ke halaman edit | Berhasil |
  | 7 | Form validasi judul, mata kuliah, dan deskripsi | Berhasil |
  | 8 | Validasi deadline dan jam | Berhasil |
  | 9 | Tambah data ke MockAPI | Berhasil |
  | 10 | Data berhasil masuk ke MockAPI setelah tambah tugas | Berhasil |
  | 11 | Menampilkan data API dengan `FutureBuilder` | Berhasil |
  | 12 | `FutureBuilder` menampilkan loading saat mengambil data | Berhasil |
  | 13 | `FutureBuilder` menampilkan data API dalam bentuk list | Berhasil |
  | 14 | `FutureBuilder` menampilkan pesan saat data kosong atau error | Berhasil |
  | 15 | Filter data Semua, Selesai, dan Belum | Berhasil |
  | 16 | Mengubah status tugas | Berhasil |
  | 17 | Edit tugas | Berhasil |
  | 18 | Data berhasil diperbarui di MockAPI setelah edit tugas | Berhasil |
  | 19 | Hapus tugas dengan long press | Berhasil |
  | 20 | Dialog konfirmasi hapus muncul | Berhasil |
  | 21 | Data berhasil dihapus dari MockAPI setelah hapus tugas | Berhasil |
  | 22 | Penggunaan minimal dua jenis button | Berhasil |
  | 23 | `GestureDetector` pada kartu tugas untuk membuka detail | Berhasil |
  | 24 | `GestureDetector` long press untuk menampilkan dialog hapus | Berhasil |
  | 25 | `GestureDetector` pada pilihan tanggal dan jam | Berhasil |


17. Dependency
  Dependency utama yang digunakan pada aplikasi:
  
  ```yaml
  dependencies:
    flutter:
      sdk: flutter
  
    http: ^1.2.1
    intl: ^0.19.0
    cupertino_icons: ^1.0.8
  ```


18. Materi Praktikum yang Diterapkan
  | Materi | Implementasi pada Aplikasi |
  |---|---|
  | Navigasi & Routing | Menggunakan `Navigator.push()` dan `Navigator.pop()` |
  | Form & Input Pengguna | Menggunakan `TextFormField` |
  | Validasi Form | Menggunakan `Form` dan `GlobalKey<FormState>` |
  | Button dan Interaksi | Menggunakan `ElevatedButton`, `OutlinedButton`, dan `TextButton` |
  | GestureDetector | Digunakan pada kartu tugas, filter, tanggal, dan jam |
  | API Consumption | Menggunakan package `http` dan MockAPI |
  | FutureBuilder | Menampilkan data API secara asynchronous |
  | ListView | Menampilkan daftar tugas dalam bentuk list |


19. Alur Aplikasi
  1. Pengguna membuka aplikasi.
  2. Aplikasi mengambil data tugas dari MockAPI.
  3. Data tugas ditampilkan pada halaman utama menggunakan `FutureBuilder`.
  4. Pengguna dapat menambahkan tugas melalui halaman tambah tugas.
  5. Pengguna dapat membuka detail tugas dengan menekan kartu tugas.
  6. Pengguna dapat mengubah status tugas pada halaman detail.
  7. Pengguna dapat mengedit tugas melalui halaman edit tugas.
  8. Pengguna dapat menghapus tugas dengan menekan lama kartu tugas.
  9. Setiap perubahan data akan terhubung dengan MockAPI.
