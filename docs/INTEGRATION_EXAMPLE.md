# Contoh Integrasi dengan HomePage

## Menambahkan User Info di HomePage

Jika ingin menampilkan informasi user di HomePage, tambahkan widget ini:

### 1. Update HomePage untuk menampilkan user info

```dart
import 'package:flutter/material.dart';
import 'package:gen_surat/presentation/viewmodels/auth/auth_viewmodel.dart';
import 'package:gen_surat/presentation/routes/route_names.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Get.find<AuthViewModel>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Suite'),
        actions: [
          // Profile Icon
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Get.toNamed(RouteNames.profile);
            },
          ),
          // Theme Toggle
          _buildThemeToggle(),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // User Welcome Card
          Obx(() {
            final user = authViewModel.currentUser;
            if (user != null) {
              return _buildWelcomeCard(user);
            }
            return const SizedBox.shrink();
          }),
          const SizedBox(height: 24),
          
          // Rest of your HomePage content
          const HomeBanner(),
          // ... existing widgets
        ],
      ),
    );
  }
  
  Widget _buildWelcomeCard(UserModel user) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 30,
              backgroundImage: user.photoUrl != null
                  ? NetworkImage(user.photoUrl!)
                  : null,
              child: user.photoUrl == null
                  ? Text(
                      user.displayName?.substring(0, 1).toUpperCase() ?? 
                      user.email.substring(0, 1).toUpperCase(),
                      style: const TextStyle(fontSize: 24),
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            
            // User Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat datang,',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.displayName ?? user.email,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            // Go to Profile button
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                Get.toNamed(RouteNames.profile);
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

### 2. Menambahkan Logout Button di Drawer (Opsional)

Jika HomePage memiliki Drawer, tambahkan logout button:

```dart
drawer: Drawer(
  child: ListView(
    children: [
      // User Account Header
      Obx(() {
        final user = authViewModel.currentUser;
        return UserAccountsDrawerHeader(
          accountName: Text(user?.displayName ?? 'User'),
          accountEmail: Text(user?.email ?? ''),
          currentAccountPicture: CircleAvatar(
            backgroundImage: user?.photoUrl != null
                ? NetworkImage(user!.photoUrl!)
                : null,
            child: user?.photoUrl == null
                ? const Icon(Icons.person, size: 40)
                : null,
          ),
        );
      }),
      
      // Menu items
      ListTile(
        leading: const Icon(Icons.home),
        title: const Text('Home'),
        onTap: () {
          Get.back();
        },
      ),
      ListTile(
        leading: const Icon(Icons.person),
        title: const Text('Profile'),
        onTap: () {
          Get.back();
          Get.toNamed(RouteNames.profile);
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.logout),
        title: const Text('Logout'),
        onTap: () async {
          Get.back();
          final authViewModel = Get.find<AuthViewModel>();
          await authViewModel.signOut();
          Get.offAllNamed(RouteNames.login);
        },
      ),
    ],
  ),
),
```

### 3. Protect Pages yang Memerlukan Auth

Jika ada halaman yang hanya bisa diakses user yang sudah login, tambahkan middleware:

```dart
GetPage(
  name: RouteNames.documentMenu,
  page: () => const DocumentMenuPage(),
  middlewares: [AuthMiddleware()], // Tambahkan ini
  transition: Transition.rightToLeft,
),
```

### 4. Menampilkan User di AppBar

Untuk menampilkan avatar user di AppBar:

```dart
appBar: AppBar(
  title: const Text('Smart Suite'),
  actions: [
    Obx(() {
      final user = authViewModel.currentUser;
      return GestureDetector(
        onTap: () {
          Get.toNamed(RouteNames.profile);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 18,
            backgroundImage: user?.photoUrl != null
                ? NetworkImage(user!.photoUrl!)
                : null,
            child: user?.photoUrl == null
                ? const Icon(Icons.person, size: 20)
                : null,
          ),
        ),
      );
    }),
    const SizedBox(width: 8),
  ],
),
```

---

## Best Practices

1. **Selalu check auth status** sebelum mengakses data user
2. **Gunakan Obx()** untuk reactive updates
3. **Handle null values** dengan proper fallbacks
4. **Tambahkan loading states** saat fetch data user

---

## Contoh Penggunaan di Widget Lain

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authViewModel = Get.find<AuthViewModel>();
    
    return Obx(() {
      if (authViewModel.isLoading) {
        return const CircularProgressIndicator();
      }
      
      if (!authViewModel.isLoggedIn) {
        return const Text('Silakan login terlebih dahulu');
      }
      
      final user = authViewModel.currentUser!;
      return Text('Hello ${user.displayName}');
    });
  }
}
```
