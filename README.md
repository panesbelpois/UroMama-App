# UroMama

Aplikasi kesehatan urin yang inovatif untuk membantu pengguna memantau dan menganalisis kesehatan mereka melalui pelacakan urin dan hidrasi.

## 📋 Deskripsi Aplikasi

**UroMama** adalah aplikasi mobile berbasis Flutter yang dirancang untuk membantu pengguna:
- **Melacak Kesehatan Urin**: Menganalisis karakteristik urin termasuk warna, kejernihan, dan berat jenis untuk mendeteksi potensi masalah kesehatan
- **Memantau Hidrasi**: Mencatat asupan air harian dan memberikan rekomendasi berdasarkan kebutuhan individu
- **Analisis Kesehatan Komprehensif**: Menampilkan interpretasi hasil analisis urin dengan panduan kesehatan yang mudah dipahami

## 🎯 Fitur Utama

### 1. **Splash Screen & Onboarding**
- Layar pembuka yang menarik dengan animasi
- Panduan pengguna untuk membantu pengguna pertama kali memahami aplikasi

### 2. **Halaman Beranda (Home Page)**
- Dashboard utama dengan akses cepat ke semua fitur
- Tampilan ringkasan status kesehatan pengguna

### 3. **Pelacakan Urin (Urine Tracking)**
- Analisis warna urin (kategori warna: sangat muda, muda, normal, gelap, sangat gelap)
- Penilaian kejernihan urin (jernih, sedikit keruh, keruh)
- Pengukuran berat jenis urin (normal, tinggi, sangat tinggi)
- Hasil analisis dengan interpretasi kesehatan yang terperinci

### 4. **Halaman Hidrasi (Hydration Page)**
- Pencatatan asupan air harian
- Rekomendasi hidrasi berdasarkan aktivitas dan kondisi tubuh
- Visualisasi kemajuan pencapaian target hidrasi

### 5. **Hasil Analisis (Analysis Result Page)**
- Interpretasi detail berdasarkan nilai urin yang dianalisis
- Warna-kode visual untuk kemudahan pemahaman
- Catatan kesehatan dan rekomendasi tindakan

## 🏗️ Arsitektur Codebase

### Struktur File
```
lib/
├── main.dart          # Entry point aplikasi, definisi tema, dan semua screen utama

android/              # Konfigurasi dan build untuk platform Android
ios/                  # Konfigurasi dan build untuk platform iOS
linux/                # Konfigurasi dan build untuk platform Linux
macos/                # Konfigurasi dan build untuk platform macOS
windows/              # Konfigurasi dan build untuk platform Windows
web/                  # Konfigurasi untuk platform Web
```

### Komponen Utama

#### 1. **UroMamaApp**
- StatelessWidget utama yang mengkonfigurasi tema aplikasi
- Tema Material Design 3 dengan desain warna pink modern
- Font Poppins dari Google Fonts
- Custom styling untuk tombol, input field, dan card

#### 2. **SplashScreen**
- StatefulWidget yang menampilkan layar pembuka
- Menangani delay dan transisi ke halaman onboarding atau beranda

#### 3. **OnboardingPage**
- Panduan pengguna interaktif untuk pengguna pertama kali
- Memperkenalkan fitur-fitur utama aplikasi

#### 4. **HomePage**
- Dashboard pusat aplikasi
- Navigasi ke semua fitur utama
- Menampilkan status kesehatan ringkas

#### 5. **UrineTrackingPage**
- Form input untuk analisis urin
- Kategori analisis: warna, kejernihan, berat jenis
- Navigasi ke halaman hasil analisis

#### 6. **HydrationPage**
- Pelacakan asupan cairan harian
- Manajemen target hidrasi
- Rekomendasi berbasis AI/logika

#### 7. **AnalysisResultPage**
- Menampilkan hasil interpretasi urin
- Warna-kode visual berdasarkan kondisi kesehatan
- Catatan dan rekomendasi tindakan kesehatan

## 🎨 Desain & UI/UX

### Palet Warna
- **Primary Pink**: `#E91E63` - Warna utama untuk aksen dan tombol
- **Soft Pink Background**: `#FCE4EC` - Latar belakang lembut yang nyaman di mata
- **Secondary Pink**: `#F48FB1` - Warna sekunder untuk highlight
- **White/Card**: `#FFFFFF` - Warna untuk card dan permukaan

### Tipografi
- Font: **Poppins** (Google Fonts)
- Aplikasi responsive dengan ukuran teks yang dapat disesuaikan

### Komponen UI
- Elevated Button dengan rounded corner radius 12
- Input field dengan filled background dan border rounded
- Card dengan shadow effect yang subtle
- AppBar custom dengan design yang clean

## 📦 Dependencies

```yaml
flutter:              # Framework utama
google_fonts: ^6.1.0  # Font Poppins dari Google Fonts
intl: ^0.18.0         # Internationalization dan pemformatan data
cupertino_icons:      # Icon iOS style
```

## 🚀 Getting Started

### Prasyarat
- Flutter SDK >=3.1.0 <4.0.0
- Android/iOS/Web development environment

### Instalasi
1. Clone repository
   ```bash
   git clone <repository_url>
   cd uromama
   ```

2. Install dependencies
   ```bash
   flutter pub get
   ```

3. Jalankan aplikasi
   ```bash
   flutter run
   ```

### Build untuk Production
- **Android**: `flutter build apk` atau `flutter build appbundle`
- **iOS**: `flutter build ios`
- **Web**: `flutter build web`
- **Windows**: `flutter build windows`
- **macOS**: `flutter build macos`
- **Linux**: `flutter build linux`

## 📱 Platform Support

Aplikasi didukung di semua platform utama:
- ✅ Android
- ✅ iOS
- ✅ Windows
- ✅ macOS
- ✅ Linux
- ✅ Web

## 🔍 Kualitas Kode

- **Analysis Options**: Menggunakan `analysis_options.yaml` untuk lint rules
- **Flutter Lints**: Menerapkan recommended lint rules dari `flutter_lints: ^2.0.0`
- **Material Design 3**: Mengikuti latest Material Design guidelines

## 📚 Dokumentasi Lebih Lanjut

- [Flutter Documentation](https://docs.flutter.dev/)
- [Material Design Guidelines](https://material.io/design)
- [Dart Documentation](https://dart.dev/guides)

## 📄 Lisensi

Aplikasi ini adalah proyek pribadi dan tidak dipublikasikan ke pub.dev.
