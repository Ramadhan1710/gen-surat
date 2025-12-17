# 📱 Google Sign-In dengan Supabase - Flutter

Implementasi lengkap Google Sign-In menggunakan Supabase untuk aplikasi Flutter Gen Surat.

## 📚 Dokumentasi

### Quick Start
- **[QUICK_START_GOOGLE_SIGNIN.md](./QUICK_START_GOOGLE_SIGNIN.md)** - Panduan cepat untuk memulai (BACA INI DULU!)

### Dokumentasi Lengkap
- **[GOOGLE_SIGN_IN_SETUP.md](./GOOGLE_SIGN_IN_SETUP.md)** - Setup lengkap dengan troubleshooting
- **[INTEGRATION_EXAMPLE.md](./INTEGRATION_EXAMPLE.md)** - Contoh integrasi dengan HomePage
- **[SUPABASE_SCHEMA.sql](./SUPABASE_SCHEMA.sql)** - Database schema untuk Supabase

## 🚀 Fitur

✅ Login dengan Google Account  
✅ Auto-create user profile di Supabase  
✅ Auth state management dengan GetX  
✅ Protected routes dengan middleware  
✅ Profile page dengan user info  
✅ Logout functionality  
✅ Error handling & user feedback  
✅ Loading states  
✅ Environment variables dengan dotenv  

## 📁 Struktur File

```
lib/
├── core/
│   ├── config/
│   │   ├── env_config.dart              # ✅ NEW: Environment config
│   │   └── supabase_config.dart         # ✅ NEW: Supabase initialization
│   ├── di/
│   │   ├── app_bindings.dart            # ✏️ UPDATED
│   │   └── global_bindings.dart         # ✏️ UPDATED
│   └── services/
│       └── auth_service.dart            # ✅ NEW: Authentication service
├── domain/
│   └── models/
│       └── user_model.dart              # ✅ NEW: User data model
├── presentation/
│   ├── pages/
│   │   ├── auth/
│   │   │   ├── login_page.dart          # ✅ NEW: Login page
│   │   │   └── profile_page.dart        # ✅ NEW: Profile page
│   │   └── splash/
│   │       └── splash_page.dart         # ✏️ UPDATED: Auth check
│   ├── routes/
│   │   ├── app_routes.dart              # ✏️ UPDATED: Auth routes
│   │   ├── route_names.dart             # ✏️ UPDATED: Route names
│   │   └── middlewares/
│   │       └── auth_middleware.dart     # ✅ NEW: Auth guard
│   └── viewmodels/
│       └── auth/
│           └── auth_viewmodel.dart      # ✅ NEW: Auth view model
└── main.dart                             # ✏️ UPDATED: Initialize Supabase

docs/
├── GOOGLE_SIGN_IN_README.md             # ✅ File ini
├── QUICK_START_GOOGLE_SIGNIN.md         # ✅ Quick start guide
├── GOOGLE_SIGN_IN_SETUP.md              # ✅ Setup lengkap
├── INTEGRATION_EXAMPLE.md               # ✅ Contoh integrasi
└── SUPABASE_SCHEMA.sql                  # ✅ Database schema

.env.example                              # ✅ Environment template
```

## 🔧 Dependencies Baru

```yaml
dependencies:
  google_sign_in: ^6.2.2    # Google Sign-In
  flutter_dotenv: ^5.2.1     # Environment variables
```

## ⚡ Quick Start

### 1. Setup Environment
```powershell
# Install dependencies
flutter pub get

# Copy .env.example ke .env (sudah ada)
# .env sudah berisi SUPABASE_URL dan SUPABASE_ANON_KEY
```

### 2. Konfigurasi Google Cloud Console

#### A. Buat Web Client ID
1. [Google Cloud Console](https://console.cloud.google.com) → Credentials
2. Create OAuth client ID → Web application
3. Authorized redirect URIs: 
   ```
   https://mrdrrjtwaydhayeqccds.supabase.co/auth/v1/callback
   ```
4. Copy Client ID & Secret

#### B. Buat Android Client ID
1. Create OAuth client ID → Android
2. Package name: `com.example.gen_surat`
3. SHA-1: Dapatkan dengan command:
   ```powershell
   keytool -list -v -keystore "$env:USERPROFILE\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
   ```

### 3. Update auth_service.dart

```dart
// lib/core/services/auth_service.dart
final GoogleSignIn _googleSignIn = GoogleSignIn(
  serverClientId: 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com', // ⚠️ UPDATE INI!
);
```

### 4. Setup Supabase

1. [Supabase Dashboard](https://app.supabase.com)
2. Authentication → Providers → Google → Enable
3. Masukkan Client ID & Secret dari Google Cloud Console
4. (Opsional) Jalankan SQL schema: [SUPABASE_SCHEMA.sql](./SUPABASE_SCHEMA.sql)

### 5. Run!

```powershell
flutter run
```

## 🎯 Flow Aplikasi

```
Splash Screen
    ↓
    ├─→ [Not Logged In] → Login Page → Google Sign-In → Home Page
    └─→ [Logged In] → Home Page
```

## 📱 Screenshots Flow

1. **Login Page** - Tombol "Sign in with Google"
2. **Google Sign-In** - Pilih akun Google
3. **Home Page** - Setelah login berhasil
4. **Profile Page** - Lihat info user & logout

## 🔐 Security Best Practices

✅ Environment variables tidak di-commit  
✅ `.env` sudah ada di `.gitignore`  
✅ Row Level Security (RLS) di Supabase  
✅ OAuth credentials di Google Cloud Console  
✅ Proper error handling  

## 📝 Cara Menggunakan di Kode

### Check Login Status
```dart
final authViewModel = Get.find<AuthViewModel>();

if (authViewModel.isLoggedIn) {
  print('User: ${authViewModel.currentUser?.email}');
}
```

### Sign Out
```dart
await authViewModel.signOut();
```

### Protect Routes
```dart
GetPage(
  name: '/protected',
  page: () => ProtectedPage(),
  middlewares: [AuthMiddleware()],
),
```

## 🐛 Troubleshooting

| Error | Solusi |
|-------|--------|
| Sign in failed | Check SHA-1 & Web Client ID |
| OAuth client not found | Verifikasi Client ID di Google Console |
| Access denied | Tambahkan email sebagai test user |

Detail troubleshooting: [GOOGLE_SIGN_IN_SETUP.md](./GOOGLE_SIGN_IN_SETUP.md)

## 📖 Resources

- [Supabase Auth Docs](https://supabase.com/docs/guides/auth)
- [Google Sign-In Package](https://pub.dev/packages/google_sign_in)
- [Google Cloud Console](https://console.cloud.google.com)

## ✅ Checklist

- [ ] Install dependencies
- [ ] Setup Google Cloud Console
  - [ ] Buat Web Client ID
  - [ ] Buat Android Client ID
  - [ ] Dapatkan SHA-1 fingerprint
- [ ] Setup Supabase
  - [ ] Enable Google Provider
  - [ ] Input Client ID & Secret
- [ ] Update `auth_service.dart`
- [ ] (Opsional) Run SQL schema
- [ ] Test login
- [ ] Verify user di Supabase Dashboard

## 🎉 Done!

Sekarang aplikasi Anda sudah memiliki fitur login dengan Google!

**Need help?** Baca dokumentasi lengkap di [GOOGLE_SIGN_IN_SETUP.md](./GOOGLE_SIGN_IN_SETUP.md)
