# Quick Start - Google Sign-In

## Langkah Cepat untuk Menjalankan

### 1. Install Dependencies
```powershell
flutter pub get
```

### 2. Konfigurasi Wajib

#### A. Update `auth_service.dart`
Buka `lib/core/services/auth_service.dart` dan ganti `serverClientId`:

```dart
final GoogleSignIn _googleSignIn = GoogleSignIn(
  serverClientId: 'YOUR_WEB_CLIENT_ID_HERE.apps.googleusercontent.com',
);
```

**Dapatkan Web Client ID dari:**
- Google Cloud Console → Credentials → Web Client

#### B. Setup Supabase
1. Login ke [Supabase Dashboard](https://app.supabase.com)
2. Pilih project Anda
3. **Authentication** → **Providers** → **Google** → **Enable**
4. Masukkan Client ID dan Client Secret dari Google Cloud Console

#### C. Setup Google Cloud Console
1. Buka [Google Cloud Console](https://console.cloud.google.com)
2. Buat project baru atau pilih yang sudah ada
3. **APIs & Services** → **Credentials** → **Create Credentials** → **OAuth client ID**
4. Buat 2 Client ID:
   - **Web application**: Untuk Supabase callback
   - **Android**: Untuk aplikasi Android

**Web Client:**
- Authorized redirect URIs: `https://mrdrrjtwaydhayeqccds.supabase.co/auth/v1/callback`

**Android Client:**
- Package name: `com.example.gen_surat` (atau sesuaikan)
- SHA-1: Dapatkan dengan command:
  ```powershell
  keytool -list -v -keystore "$env:USERPROFILE\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
  ```

### 3. Jalankan Aplikasi
```powershell
flutter run
```

### 4. Test Login
1. Klik "Sign in with Google"
2. Pilih akun Google
3. Jika berhasil, akan redirect ke Home Page

---

## File-File Penting

### Authentication
- `lib/core/services/auth_service.dart` - **UPDATE serverClientId di sini!**
- `lib/core/config/env_config.dart` - Load environment variables
- `lib/core/config/supabase_config.dart` - Inisialisasi Supabase

### UI
- `lib/presentation/pages/auth/login_page.dart` - Halaman login
- `lib/presentation/pages/auth/profile_page.dart` - Halaman profile

### ViewModel
- `lib/presentation/viewmodels/auth/auth_viewmodel.dart` - Manajemen state auth

### Model
- `lib/domain/models/user_model.dart` - Model data user

---

## Troubleshooting Cepat

### ❌ Sign in failed / Error 10
**Solusi:**
1. Pastikan SHA-1 sudah ditambahkan di Google Cloud Console
2. Pastikan Web Client ID sudah benar di `auth_service.dart`
3. Clean project:
   ```powershell
   flutter clean
   flutter pub get
   ```

### ❌ OAuth client not found
**Solusi:**
1. Periksa Client ID di Google Cloud Console
2. Pastikan menggunakan **Web Client ID**, bukan Android Client ID
3. Pastikan OAuth Consent Screen sudah dikonfigurasi

### ❌ Access denied
**Solusi:**
1. Tambahkan email Anda sebagai test user di Google Cloud Console
2. OAuth Consent Screen → Test users → Add users

---

## Dokumentasi Lengkap

Untuk panduan lengkap termasuk setup iOS, database schema, dan troubleshooting detail, lihat:
- [GOOGLE_SIGN_IN_SETUP.md](./GOOGLE_SIGN_IN_SETUP.md)

---

## Checklist Setup

- [ ] Install dependencies (`flutter pub get`)
- [ ] Buat project di Google Cloud Console
- [ ] Enable Google Provider di Supabase
- [ ] Buat Web Client ID di Google Cloud Console
- [ ] Buat Android Client ID di Google Cloud Console
- [ ] Dapatkan SHA-1 fingerprint
- [ ] Update `serverClientId` di `auth_service.dart`
- [ ] Masukkan Client ID & Secret ke Supabase
- [ ] Test login
- [ ] Verifikasi user muncul di Supabase Dashboard

---

**Selamat mencoba! 🚀**
