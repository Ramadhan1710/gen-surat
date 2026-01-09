import 'package:flutter/material.dart';
import 'package:gen_surat/presentation/pages/home/widgets/home_banner.dart';
import 'package:gen_surat/presentation/pages/home/widgets/home_grid_menu.dart';
import 'package:gen_surat/presentation/routes/route_names.dart';
import 'package:gen_surat/presentation/viewmodels/auth/auth_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/theme/theme_viewmodel.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Suite'),
        centerTitle: true,
        elevation: 0,
        actions: [
          _buildProfileButton(),
          _buildThemeToggle(),
          _buildLogoutButton(),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:
                isDark
                    ? [
                      theme.scaffoldBackgroundColor,
                      theme.colorScheme.surface,
                    ]
                    : [
                      theme.colorScheme.primary.withValues(alpha: 0.1),
                      theme.scaffoldBackgroundColor,
                    ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const HomeBanner(),
            const SizedBox(height: 24),

            // const HeaderSection(),
            // const SizedBox(height: 24),

            // MenuCard(
            //   icon: Icons.description_outlined,
            //   title: 'Buat Dokumen',
            //   description: 'Pilih jenis administrasi IPNU atau IPPNU',
            //   gradient:
            //       isDark
            //           ? [AppColors.darkPrimary, AppColors.darkPrimaryVariant]
            //           : [
            //             theme.colorScheme.primary,
            //             theme.colorScheme.primary.withValues(alpha: 0.7),
            //           ],
            //   onTap: () => AppRoutes.toNamed(RouteNames.documentMenu),
            // ),
            // const SizedBox(height: 16),

            // MenuCard(
            //   icon: Icons.folder_open,
            //   title: 'File Tersimpan',
            //   description: 'Lihat dan kelola dokumen yang sudah dibuat',
            //   gradient:
            //       isDark
            //           ? [
            //             AppColors.warning,
            //             AppColors.warning.withValues(alpha: 0.8),
            //           ]
            //           : [
            //             AppColors.warning,
            //             AppColors.warning.withValues(alpha: 0.7),
            //           ],
            //   onTap: () => AppRoutes.toNamed(RouteNames.generatedFiles),
            // ),
            // const SizedBox(height: 16),

            // MenuCard(
            //   icon: Icons.menu_book,
            //   title: 'Al-Quran Digital',
            //   description: 'Baca Al-Quran online dari NU Online',
            //   gradient:
            //       isDark
            //           ? [
            //             AppColors.success,
            //             AppColors.success.withValues(alpha: 0.8),
            //           ]
            //           : [
            //             AppColors.success,
            //             AppColors.success.withValues(alpha: 0.7),
            //           ],
            //   onTap: () => AppRoutes.toNamed(RouteNames.quran),
            // ),
            // const SizedBox(height: 16),

            // MenuCard(
            //   icon: Icons.cloud,
            //   title: 'Google Drive',
            //   description: 'Akses file dan dokumen di Google Drive',
            //   gradient:
            //       isDark
            //           ? [Colors.blue, Colors.blue.withValues(alpha: 0.8)]
            //           : [Colors.blue, Colors.blue.withValues(alpha: 0.7)],
            //   onTap: () => AppRoutes.toNamed(RouteNames.gdrive),
            // ),
            HomeGridMenu(isDark: isDark),
            // const SizedBox(height: 32),
            // const InfoSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileButton() {
    final authViewModel = Get.find<AuthViewModel>();
    return Obx(() {
      final user = authViewModel.currentUser;
      return IconButton(
        icon: user?.photoUrl != null
            ? CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(user!.photoUrl!),
              )
            : const Icon(Icons.account_circle),
        onPressed: () => Get.toNamed(RouteNames.profile),
        tooltip: 'Profile',
      );
    });
  }

  Widget _buildThemeToggle() {
    return Builder(
      builder: (context) {
        final themeController = Get.find<ThemeViewModel>();
        return Obx(
          () => IconButton(
            icon: Icon(
              themeController.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () => themeController.toggleTheme(),
            tooltip: 'Toggle Theme',
          ),
        );
      },
    );
  }

  Widget _buildLogoutButton() {
    final authViewModel = Get.find<AuthViewModel>();
    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () async {
        final confirm = await Get.dialog<bool>(
          AlertDialog(
            title: const Text('Logout'),
            content: const Text('Apakah Anda yakin ingin logout?'),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () => Get.back(result: true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
        );

        if (confirm == true) {
          await authViewModel.signOut();
          Get.offAllNamed(RouteNames.login);
        }
      },
      tooltip: 'Logout',
    );
  }
}
