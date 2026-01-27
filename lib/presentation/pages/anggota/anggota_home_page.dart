import 'package:flutter/material.dart';
import 'package:gen_surat/presentation/pages/anggota/widgets/anggota_home_grid_menu.dart';
import 'package:gen_surat/presentation/pages/home/widgets/home_banner.dart';
import 'package:gen_surat/presentation/routes/app_routes.dart';
import 'package:gen_surat/presentation/routes/route_names.dart';
import 'package:gen_surat/presentation/viewmodels/auth/auth_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/theme/theme_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/app_dialog.dart';
import 'package:gen_surat/presentation/widgets/app_drawer.dart';
import 'package:get/get.dart';

class AnggotaHomePage extends StatefulWidget {
  const AnggotaHomePage({super.key});

  @override
  State<AnggotaHomePage> createState() => _AnggotaHomePageState();
}

class _AnggotaHomePageState extends State<AnggotaHomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      drawer: AppDrawer(
        userRole: "Anggota",
        customMenuItems: [
          DrawerMenuItem(
            icon: Icons.person_outline,
            title: "Profil Saya",
            onTap: () {
              Navigator.pop(context);
              AppRoutes.toNamed(RouteNames.profile);
            },
          ),
          DrawerMenuItem(
            icon: Icons.history,
            title: "Riwayat Surat",
            onTap: () => AppRoutes.toNamed(RouteNames.generatedFiles),
          ),
          DrawerMenuItem(
            icon: Icons.notifications_outlined,
            title: "Notifikasi",
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Text(
                "3",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () {
              AppDialog.showComingSoon(context, feature: "Notifikasi");
              // Navigate to notifications
            },
          ),
        ],
        onLogout: _handleLogout,
      ),
      appBar: AppBar(
        title: const Text('Smart Suite'),
        centerTitle: true,
        elevation: 0,
        actions: [_buildThemeToggle()],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:
                isDark
                    ? [theme.scaffoldBackgroundColor, theme.colorScheme.surface]
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

            AnggotaHomeGridMenu(isDark: isDark),
          ],
        ),
      ),
    );
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

  Future<void> _handleLogout() async {
    final authViewModel = Get.find<AuthViewModel>();
    await authViewModel.signOut();
    Get.offAllNamed(RouteNames.login);
  }
}
