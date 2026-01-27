import 'package:flutter/material.dart';
import 'package:gen_surat/presentation/pages/home/widgets/home_banner.dart';
import 'package:gen_surat/presentation/pages/ranting/widgets/ranting_home_grid_menu.dart';
import 'package:gen_surat/presentation/routes/route_names.dart';
import 'package:gen_surat/presentation/viewmodels/theme/theme_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/app_dialog.dart';
import 'package:gen_surat/presentation/widgets/app_drawer.dart';
import 'package:get/get.dart';

class RantingHomePage extends StatefulWidget {
  const RantingHomePage({super.key});

  @override
  State<RantingHomePage> createState() => _RantingHomePageState();
}

class _RantingHomePageState extends State<RantingHomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      drawer: AppDrawer(
        userRole: "Ranting",
        customMenuItems: [
          DrawerMenuItem(
            icon: Icons.post_add,
            title: "Pengajuan SP",
            onTap: () {
              Navigator.pop(context);
              AppDialog.showComingSoon(context, feature: "Pengajuan SP");
            },
          ),
          DrawerMenuItem(
            icon: Icons.description_outlined,
            title: "Generate Administrasi",
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(RouteNames.documentMenu);
            },
          ),
          DrawerMenuItem(
            icon: Icons.history,
            title: "Riwayat Administrasi",
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(RouteNames.generatedFiles);
            },
          ),
          DrawerMenuItem(
            icon: Icons.newspaper,
            title: "Berita Organisasi",
            onTap: () {
              Navigator.pop(context);
              AppDialog.showComingSoon(context, feature: "Berita Organisasi");
            },
          ),
          DrawerMenuItem(
            icon: Icons.person_outline,
            title: "Profil Saya",
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(RouteNames.profile);
            },
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('Smart Suite - Ranting'),
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
            RantingHomeGridMenu(isDark: isDark),
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
}
