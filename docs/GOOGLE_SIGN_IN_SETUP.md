# Dokumentasi Login dengan Google menggunakan Supabase

## Daftar Isi
1. [Setup Supabase](#1-setup-supabase)
2. [Setup Google Cloud Console](#2-setup-google-cloud-console)
3. [Konfigurasi Android](#3-konfigurasi-android)
4. [Konfigurasi iOS](#4-konfigurasi-ios)
5. [Testing](#5-testing)
6. [Troubleshooting](#6-troubleshooting)

---

## 1. Setup Supabase

### 1.1 Enable Google Auth Provider

1. Login ke [Supabase Dashboard](https://app.supabase.com)
2. Pilih project Anda
3. Navigasi ke **Authentication** → **Providers**
4. Cari **Google** dan klik **Enable**
5. Simpan **Callback URL (Redirect URL)** yang diberikan oleh Supabase, contoh:
   ```
   https://mrdrrjtwaydhayeqccds.supabase.co/auth/v1/callback
   ```

### 1.2 Konfigurasi Email Settings (Opsional)

Jika ingin mengirim email konfirmasi:
1. Navigasi ke **Authentication** → **Email Templates**
2. Customize template sesuai kebutuhan

---

## 2. Setup Google Cloud Console

### 2.1 Buat Project di Google Cloud Console

1. Buka [Google Cloud Console](https://console.cloud.google.com)
2. Klik **Select a Project** → **New Project**
3. Masukkan nama project (misal: "Smart Suite Auth")
4. Klik **Create**

### 2.2 Enable Google+ API

1. Navigasi ke **APIs & Services** → **Library**
2. Search "Google+ API"
3. Klik dan enable API tersebut

### 2.3 Konfigurasi OAuth Consent Screen

1. Navigasi ke **APIs & Services** → **OAuth consent screen**
2. Pilih **External** (untuk testing) atau **Internal** (untuk organisasi)
3. Klik **Create**
4. Isi informasi yang diperlukan:
   - **App name**: Smart Suite
   - **User support email**: email Anda
   - **Developer contact information**: email Anda
5. Klik **Save and Continue**
6. Di bagian **Scopes**, klik **Add or Remove Scopes**
   - Pilih: `email`, `profile`, `openid`
7. Klik **Save and Continue**
8. Di bagian **Test users** (jika External), tambahkan email untuk testing
9. Klik **Save and Continue**

### 2.4 Buat OAuth Client ID untuk Web

1. Navigasi ke **APIs & Services** → **Credentials**
2. Klik **Create Credentials** → **OAuth client ID**
3. Pilih **Application type**: **Web application**
4. Masukkan informasi:
   - **Name**: Smart Suite Web Client
   - **Authorized redirect URIs**: Tambahkan callback URL dari Supabase
     ```
     https://mrdrrjtwaydhayeqccds.supabase.co/auth/v1/callback
     ```
5. Klik **Create**
6. **SIMPAN** Client ID dan Client Secret

### 2.5 Update Supabase dengan Google Credentials

1. Kembali ke Supabase Dashboard
2. Navigasi ke **Authentication** → **Providers** → **Google**
3. Masukkan:
   - **Client ID (for OAuth)**: Client ID dari Google Cloud Console
   - **Client Secret (for OAuth)**: Client Secret dari Google Cloud Console
4. Klik **Save**

### 2.6 Buat OAuth Client ID untuk Android

1. Di Google Cloud Console, klik **Create Credentials** → **OAuth client ID** lagi
2. Pilih **Application type**: **Android**
3. Masukkan informasi:
   - **Name**: Smart Suite Android
   - **Package name**: `com.example.gen_surat` (sesuaikan dengan package Anda)
   - **SHA-1 certificate fingerprint**: Dapatkan dari langkah berikut

#### Dapatkan SHA-1 Fingerprint

Untuk **Debug**:
```powershell
keytool -list -v -keystore "$env:USERPROFILE\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
```

Untuk **Release** (setelah buat keystore):
```powershell
keytool -list -v -keystore path\to\your\release.keystore -alias your-alias
```

4. Copy **SHA-1** dan paste ke Google Cloud Console
5. Klik **Create**
6. **SIMPAN** Client ID yang dihasilkan

### 2.7 Buat OAuth Client ID untuk iOS (Jika deploy ke iOS)

1. Klik **Create Credentials** → **OAuth client ID** lagi
2. Pilih **Application type**: **iOS**
3. Masukkan:
   - **Name**: Smart Suite iOS
   - **Bundle ID**: sesuai dengan iOS bundle ID Anda (ada di `ios/Runner.xcodeproj`)
4. Klik **Create**

---

## 3. Konfigurasi Android

### 3.1 Update auth_service.dart

Buka file `lib/core/services/auth_service.dart` dan update `serverClientId`:

```dart
final GoogleSignIn _googleSignIn = GoogleSignIn(
  serverClientId: 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com', // Ganti dengan Web Client ID
);
```

**PENTING**: Gunakan **Web Client ID**, bukan Android Client ID!

### 3.2 Update AndroidManifest.xml

Buka file `android/app/src/main/AndroidManifest.xml` dan tambahkan:

```xml
<manifest ...>
    <application ...>
        <!-- Existing configurations -->
        
        <meta-data
            android:name="com.google.android.gms.version"
            android:value="@integer/google_play_services_version" />
    </application>
</manifest>
```

### 3.3 Update build.gradle

File sudah menggunakan Kotlin DSL (`.kts`), tidak perlu perubahan tambahan.

---

## 4. Konfigurasi iOS

### 4.1 Update Info.plist

Buka `ios/Runner/Info.plist` dan tambahkan:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>com.googleusercontent.apps.YOUR_IOS_CLIENT_ID</string>
        </array>
    </dict>
</array>
```

Ganti `YOUR_IOS_CLIENT_ID` dengan iOS Client ID dari Google Cloud Console (reversed).

### 4.2 Update AppDelegate.swift

Buka `ios/Runner/AppDelegate.swift`:

```swift
import UIKit
import Flutter
import GoogleSignIn

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  override func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
  ) -> Bool {
    return GIDSignIn.sharedInstance.handle(url)
  }
}
```

---

## 5. Testing

### 5.1 Install Dependencies

```powershell
flutter pub get
```

### 5.2 Jalankan Aplikasi

```powershell
flutter run
```

### 5.3 Flow Testing

1. Aplikasi akan membuka **Splash Screen**
2. Jika belum login, akan diarahkan ke **Login Page**
3. Klik tombol **"Sign in with Google"**
4. Pilih akun Google
5. Setelah berhasil, akan diarahkan ke **Home Page**
6. Buka **Profile Page** untuk melihat informasi user
7. Test logout dengan klik icon logout

### 5.4 Verifikasi di Supabase

1. Login ke Supabase Dashboard
2. Navigasi ke **Authentication** → **Users**
3. User yang baru login akan muncul di list

---

## 6. Troubleshooting

### Error: "PlatformException(sign_in_failed)"

**Penyebab**: SHA-1 fingerprint tidak cocok atau Client ID salah

**Solusi**:
1. Pastikan SHA-1 fingerprint sudah ditambahkan di Google Cloud Console
2. Pastikan menggunakan **Web Client ID** di `auth_service.dart`
3. Clean dan rebuild project:
   ```powershell
   flutter clean
   flutter pub get
   flutter run
   ```

### Error: "Error 10"

**Penyebab**: `google-services.json` tidak ditemukan atau tidak valid

**Solusi**:
1. Download `google-services.json` dari Firebase Console
2. Letakkan di `android/app/`
3. Rebuild project

### Error: "The OAuth client was not found"

**Penyebab**: Client ID tidak valid atau tidak sesuai

**Solusi**:
1. Verifikasi Client ID di Google Cloud Console
2. Pastikan menggunakan Web Client ID yang benar
3. Pastikan aplikasi sudah di-publish (atau dalam mode testing dengan test users)

### Login berhasil tapi data user null

**Penyebab**: Scope tidak lengkap

**Solusi**:
1. Pastikan scope `email` dan `profile` sudah ditambahkan di OAuth Consent Screen
2. Revoke akses aplikasi di Google Account dan coba login lagi

### Error: "Unable to launch browser"

**Penyebab**: URL launcher tidak dikonfigurasi dengan benar

**Solusi**:
1. Pastikan package `url_launcher` sudah di-install
2. Update `AndroidManifest.xml` dengan intent-filter yang sesuai

---

## 7. Struktur File yang Dibuat

```
lib/
├── core/
│   ├── config/
│   │   ├── env_config.dart          # Konfigurasi environment variables
│   │   └── supabase_config.dart     # Konfigurasi Supabase
│   ├── di/
│   │   ├── app_bindings.dart        # Updated: AuthViewModel binding
│   │   └── global_bindings.dart     # Updated: AuthService binding
│   └── services/
│       └── auth_service.dart        # Service untuk autentikasi
├── domain/
│   └── models/
│       └── user_model.dart          # Model untuk User
├── presentation/
│   ├── pages/
│   │   └── auth/
│   │       ├── login_page.dart      # Halaman login
│   │       └── profile_page.dart    # Halaman profile
│   ├── routes/
│   │   ├── app_routes.dart          # Updated: Tambah auth routes
│   │   ├── route_names.dart         # Updated: Tambah auth route names
│   │   └── middlewares/
│   │       └── auth_middleware.dart # Middleware untuk auth guard
│   └── viewmodels/
│       └── auth/
│           └── auth_viewmodel.dart  # ViewModel untuk autentikasi
└── main.dart                         # Updated: Initialize Supabase & load env
```

---

## 8. Environment Variables

File `.env` sudah dikonfigurasi dengan:

```env
SUPABASE_URL=https://mrdrrjtwaydhayeqccds.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

**PENTING**: Jangan commit file `.env` ke Git! Tambahkan ke `.gitignore`:

```gitignore
.env
```

---

## 9. Dependencies yang Ditambahkan

```yaml
dependencies:
  supabase_flutter: ^2.10.3      # Existing
  google_sign_in: ^6.2.2          # NEW: Google Sign In
  flutter_dotenv: ^5.2.1          # NEW: Environment variables

assets:
  - .env                           # NEW: Load .env file
```

---

## 10. Fitur yang Tersedia

### AuthService
- ✅ Sign in with Google
- ✅ Sign out
- ✅ Get current user
- ✅ Auth state changes listener
- ✅ Get user profile from database
- ✅ Update user profile
- ✅ Delete account

### AuthViewModel
- ✅ Observable auth state
- ✅ Loading state
- ✅ Error handling
- ✅ User-friendly error messages
- ✅ Auto-redirect berdasarkan auth status

### UI Pages
- ✅ Login Page dengan Google Sign In button
- ✅ Profile Page dengan informasi user lengkap
- ✅ Error display di login page
- ✅ Loading indicator

---

## 11. Penggunaan dalam Kode

### Mengakses Current User

```dart
final authViewModel = Get.find<AuthViewModel>();
final user = authViewModel.currentUser;

if (user != null) {
  print('User email: ${user.email}');
  print('User name: ${user.displayName}');
}
```

### Check Login Status

```dart
final authViewModel = Get.find<AuthViewModel>();

if (authViewModel.isLoggedIn) {
  // User sudah login
} else {
  // User belum login
}
```

### Sign Out

```dart
final authViewModel = Get.find<AuthViewModel>();
await authViewModel.signOut();
```

### Listen Auth Changes

```dart
@override
void onInit() {
  super.onInit();
  
  final authService = Get.find<AuthService>();
  authService.authStateChanges.listen((state) {
    if (state.session != null) {
      // User login
    } else {
      // User logout
    }
  });
}
```

---

## 12. Best Practices

1. **Security**:
   - Jangan hardcode credentials
   - Gunakan environment variables
   - Jangan commit `.env` ke repository

2. **Error Handling**:
   - Selalu handle error dari auth operations
   - Tampilkan pesan error yang user-friendly

3. **User Experience**:
   - Tampilkan loading indicator saat proses login
   - Auto-redirect setelah login/logout berhasil
   - Cache auth state untuk startup cepat

4. **Testing**:
   - Test dengan berbagai akun Google
   - Test logout flow
   - Test error scenarios

---

## 13. Next Steps (Opsional)

1. **Database Schema** - Buat table `profiles` di Supabase:
   ```sql
   create table profiles (
     id uuid references auth.users on delete cascade primary key,
     email text,
     display_name text,
     photo_url text,
     created_at timestamp with time zone default timezone('utc'::text, now()) not null,
     updated_at timestamp with time zone default timezone('utc'::text, now()) not null
   );

   -- Enable RLS
   alter table profiles enable row level security;

   -- Policy: Users can read their own profile
   create policy "Users can read own profile" 
     on profiles for select 
     using (auth.uid() = id);

   -- Policy: Users can update their own profile
   create policy "Users can update own profile" 
     on profiles for update 
     using (auth.uid() = id);
   ```

2. **Auto-create Profile** - Gunakan Supabase Triggers untuk auto-create profile saat user baru:
   ```sql
   create or replace function public.handle_new_user()
   returns trigger as $$
   begin
     insert into public.profiles (id, email, display_name, photo_url)
     values (
       new.id,
       new.email,
       new.raw_user_meta_data->>'full_name',
       new.raw_user_meta_data->>'avatar_url'
     );
     return new;
   end;
   $$ language plpgsql security definer;

   create trigger on_auth_user_created
     after insert on auth.users
     for each row execute procedure public.handle_new_user();
   ```

3. **Email Authentication** - Tambahkan login dengan email/password
4. **Phone Authentication** - Tambahkan login dengan nomor telepon
5. **Social Auth** - Tambahkan provider lain (Facebook, Apple, dll)

---

## Support

Jika mengalami kendala:
1. Check error di console
2. Verifikasi semua konfigurasi
3. Check dokumentasi [Supabase](https://supabase.com/docs/guides/auth)
4. Check dokumentasi [Google Sign-In](https://pub.dev/packages/google_sign_in)

---

**Created by**: GitHub Copilot  
**Date**: December 9, 2025
