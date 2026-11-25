# SpotBanua

Aplikasi mobile berbasis Flutter untuk menjelajahi destinasi wisata di Kalimantan Selatan (seperti Banjarbaru, Banjarmasin, dan sekitarnya), dilengkapi dengan tampilan beranda, pencarian destinasi, daftar favorit, serta pengelolaan data wisata menggunakan Cloud Firestore.

## Fitur Utama

- **Splash Screen & Onboarding**: Animasi layar pembuka (`SplashScreen`) dan halaman pengenalan aplikasi (`GetStartedPage`) mengenai pencarian wisata di Kalimantan Selatan, rating/ulasan, dan fitur favorit.
- **Tampilan Autentikasi**: Halaman pilihan masuk/daftar (`LoginScreen`), `SignInScreen`, dan `SignUpScreen` dengan animasi transisi.
- **Navigasi Utama (`MainNavigation`)**: Navigasi bawah interaktif menggunakan `CurvedNavigationBar` untuk mengakses halaman Beranda, Jelajah, Favorit, dan Profil.
- **Beranda (`HomePage`)**: Menampilkan carousel gambar destinasi, bagian *Upcoming Event*, dan daftar rekomendasi tempat wisata.
- **Jelajah (`DiscoverPage`)**: Menampilkan daftar event, kolom pencarian tempat wisata, tab filter wilayah (`Banjarbaru`, `Banjarmasin`, `Lainnya`), serta daftar *Top Destination*.
- **Favorit (`FavoritePage`)**: Menampilkan daftar destinasi wisata favorit beserta model data `FavoriteModel`.
- **Profil & CRUD Wisata (`ProfilePage`, `ListWisataScreen`, `AddEditWisataScreen`)**: Menu profil dengan akses ke manajemen data wisata yang terhubung ke Cloud Firestore untuk melihat daftar wisata, menambah/mengubah data (`nama`, `wilayah`, `maps_url`, `gambar_url`, `is_top_recomend`), dan menghapus data wisata. Tersedia juga model dan layanan untuk komentar/rating (`KomentarModel`, `KomentarService`) serta pengguna (`UserModel`).

## Tech Stack

- **Framework & Bahasa**: Flutter, Dart SDK (`^3.7.0`)
- **Backend & Database**: Firebase Core (`firebase_core`), Cloud Firestore (`cloud_firestore`)
- **UI & Navigasi**: `google_fonts`, `carousel_slider`, `curved_navigation_bar`, `smooth_page_indicator`, `page_transition`
- **Ikon & Utilitas**: `cupertino_icons`, `font_awesome_flutter`, `flutter_vector_icons`, `lucide_icons`, `intl`

## Struktur Proyek

```text
spotbanua/
├── assets/
│   └── images/               # Aset gambar wisata, event, ikon, vektor, dan efek
├── lib/
│   ├── main.dart             # Entry point aplikasi dan inisialisasi Firebase
│   └── pages/
│       ├── splash_screen.dart
│       ├── getstarted.dart
│       ├── login.dart
│       ├── signin.dart
│       ├── signup.dart
│       └── admin/
│           ├── mainnavigation.dart
│           ├── index.dart    # Halaman Beranda
│           ├── discover.dart # Halaman Jelajah
│           ├── favorite.dart # Halaman Favorit
│           ├── profile.dart  # Halaman Profil
│           └── crud/
│               ├── firebase_options.dart
│               ├── form_wisata.dart
│               ├── list_wisata.dart
│               ├── models/   # wisata_model, komentar_model, favorite_model, user_model
│               └── services/ # wisata_services, komentars_services
├── test/
│   └── widget_test.dart
├── firebase.json             # Konfigurasi FlutterFire
└── pubspec.yaml              # Daftar dependensi dan aset Flutter
```

## Konfigurasi Lingkungan & Firebase

Repositori ini tidak menggunakan file `.env` / `.env.example`, melainkan mengandalkan konfigurasi FlutterFire (`firebase.json`, `lib/pages/admin/crud/firebase_options.dart`, dan `android/app/google-services.json`).

Jika ingin menghubungkan aplikasi ke proyek Firebase Anda sendiri:

1. Pastikan proyek Firebase dan database **Cloud Firestore** sudah dibuat di Firebase Console.
2. Instal dan jalankan FlutterFire CLI untuk memperbarui konfigurasi platform:
   ```bash
   flutterfire configure
   ```
3. Apabila Anda menambahkan file `.env` secara lokal untuk kebutuhan pengembangan tambahan, jangan pernah meng-commit kredensial atau rahasia apa pun ke repositori (jadikan `.env.example` sebagai templat bila diperlukan).

## Instalasi & Menjalankan Aplikasi

### Prasyarat

- [Flutter SDK](https://docs.flutter.dev/get-started/install) dengan Dart SDK `^3.7.0`
- Android Studio / Xcode / VS Code serta emulator atau perangkat fisik

### Langkah Menjalankan

1. **Clone repositori**
   ```bash
   git clone https://github.com/BevandJanuartama/spot-banua.git
   cd spot-banua
   ```

2. **Unduh dependensi**
   ```bash
   flutter pub get
   ```

3. **Jalankan aplikasi**
   ```bash
   flutter run
   ```
