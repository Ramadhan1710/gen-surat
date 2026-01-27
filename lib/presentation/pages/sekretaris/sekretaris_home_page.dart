import 'package:flutter/material.dart';
import 'package:gen_surat/presentation/viewmodels/theme/theme_viewmodel.dart';
import 'package:get/get.dart';
import 'package:gen_surat/presentation/widgets/app_drawer.dart';
import 'package:gen_surat/presentation/pages/sekretaris/widgets/sekretaris_home_grid_menu.dart';
import 'package:gen_surat/presentation/routes/route_names.dart';
import 'package:gen_surat/presentation/widgets/app_dialog.dart';

class SekretarisHomePage extends StatefulWidget {
  const SekretarisHomePage({super.key});

  @override
  State<SekretarisHomePage> createState() => _SekretarisHomePageState();
}

class _SekretarisHomePageState extends State<SekretarisHomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? theme.colorScheme.surface : Colors.grey[50],
      appBar: AppBar(
        title: const Text('Portal Sekretaris'),
        centerTitle: true,
        elevation: 0,
        actions: [_buildThemeToggle()],
      ),
      drawer: AppDrawer(
        userRole: "Sekretaris",
        customMenuItems: [
          DrawerMenuItem(
            icon: Icons.edit_document,
            title: "Generate Surat Internal",
            onTap: () {
              Get.back();
              Get.toNamed(RouteNames.documentMenu);
            },
          ),
          DrawerMenuItem(
            icon: Icons.fact_check,
            title: "Validasi Berkas",
            onTap: () {
              Get.back();
              AppDialog.showComingSoon(context, feature: "Validasi Berkas");
            },
          ),
          DrawerMenuItem(
            icon: Icons.archive,
            title: "Pengarsipan Dokumen",
            onTap: () {
              Get.back();
              AppDialog.showComingSoon(context, feature: "Pengarsipan");
            },
          ),
          DrawerMenuItem(
            icon: Icons.school_outlined,
            title: "Kelola Edukasi",
            onTap: () {
              Get.back();
              AppDialog.showComingSoon(context, feature: "Kelola Edukasi");
            },
          ),
          DrawerMenuItem(
            icon: Icons.analytics_outlined,
            title: "Statistik",
            onTap: () {
              Get.back();
              AppDialog.showComingSoon(context, feature: "Statistik");
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Implement refresh untuk reload data stats
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner with friendly greeting
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors:
                        isDark
                            ? [
                              theme.colorScheme.primary.withValues(alpha: 0.4),
                              theme.colorScheme.secondary.withValues(
                                alpha: 0.8,
                              ),
                            ]
                            : [
                              theme.colorScheme.primary,
                              theme.colorScheme.secondary,
                            ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.waving_hand,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            "Selamat Datang, Sekretaris!",
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withValues(alpha: 0.4),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.notifications,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "7",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Kelola dokumen, validasi berkas, dan atur arsip organisasi dengan mudah 📋",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.9),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              // Main Content
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: SekretarisHomeGridMenu(isDark: isDark),
              ),
            ],
          ),
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
