import 'package:flutter/material.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/presentation/routes/app_routes.dart';
import 'package:gen_surat/presentation/routes/route_names.dart';

class HomeGridMenu extends StatelessWidget {
  final bool isDark;

  const HomeGridMenu({super.key, required this.isDark});

  void _showComingSoonDialog(BuildContext context, String documentName) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.warning),
                const SizedBox(width: 12),
                const Text('Segera Hadir'),
              ],
            ),
            content: Text(
              'Fitur "$documentName" sedang dalam pengembangan dan akan segera tersedia.',
              style: AppTextStyles.bodyMedium,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = [
      _MenuItem(
        icon: Icons.description_outlined,
        title: "Buat Dokumen",
        color: AppColors.documentEmerald,
        route: () => AppRoutes.toNamed(RouteNames.documentMenu),
      ),
      _MenuItem(
        icon: Icons.folder_open,
        title: "File Tersimpan",
        color: AppColors.documentAmber,
        route: () => AppRoutes.toNamed(RouteNames.generatedFiles),
      ),
      _MenuItem(
        icon: Icons.people_alt,
        title: "Data Anggota",
        color: AppColors.documentTeal,
        route: () => _showComingSoonDialog(context, "Data Anggota"),
      ),
      _MenuItem(
        icon: Icons.archive,
        title: "Arsip",
        color: AppColors.documentCyan,
        route: () => AppRoutes.toNamed(RouteNames.gdrive),
      ),
      _MenuItem(
        icon: Icons.verified,
        title: "Minta Surat",
        color: AppColors.documentLime,
        route: () => _showComingSoonDialog(context, "Minta Surat"),
      ),
      _MenuItem(
        icon: Icons.library_books,
        title: "Ensiklopedia",
        color: AppColors.ipnuPrimaryLight,
        route: () => _showComingSoonDialog(context, "Ensiklopedia"),
      ),
      _MenuItem(
        icon: Icons.newspaper,
        title: "Berita",
        color: AppColors.lightError,
        route: () => _showComingSoonDialog(context, "Berita"),
      ),
      _MenuItem(
        icon: Icons.calendar_month,
        title: "Agenda",
        color: AppColors.ipnuSecondaryLight,
        route: () => _showComingSoonDialog(context, "Agenda"),
      ),
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemBuilder: (_, i) {
        final item = items[i];
        return _GridCard(
          icon: item.icon,
          title: item.title,
          color: item.color,
          isDark: isDark,
          onTap: item.route,
        );
      },
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback route;

  _MenuItem({
    required this.icon,
    required this.title,
    required this.color,
    required this.route,
  });
}

class _GridCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final bool isDark;
  final VoidCallback onTap;

  const _GridCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withValues(alpha: 0.9),
                color.withValues(alpha: 0.6),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 36),
              ),
              const SizedBox(height: 14),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
