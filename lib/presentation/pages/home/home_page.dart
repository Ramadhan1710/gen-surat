import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/presentation/pages/home/widgets/header_section.dart';
import 'package:gen_surat/presentation/pages/home/widgets/home_banner.dart';
import 'package:gen_surat/presentation/pages/home/widgets/home_grid_menu.dart';
import 'package:gen_surat/presentation/pages/home/widgets/info_section.dart';
import 'package:gen_surat/presentation/pages/home/widgets/menu_card.dart';
import 'package:gen_surat/presentation/routes/app_routes.dart';
import 'package:gen_surat/presentation/routes/route_names.dart';
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
        title: const Text('Gen Surat'),
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
          ),
        );
      },
    );
  }
}
