import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/presentation/routes/app_routes.dart';
import 'package:gen_surat/presentation/routes/route_names.dart';
import 'package:gen_surat/presentation/widgets/app_dialog.dart';

class RantingHomeGridMenu extends StatelessWidget {
  final bool isDark;

  const RantingHomeGridMenu({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Quick Stats Section - Monitoring aktivitas
        _buildQuickStats(context),

        const SizedBox(height: 24),

        // Section: Administrasi
        _buildSectionHeader(
          context,
          "Administrasi",
          Icons.description_outlined,
        ),
        const SizedBox(height: 12),
        _buildPrimaryActions(context),

        const SizedBox(height: 24),

        // Section: Informasi
        _buildSectionHeader(context, "Informasi & Lainnya", Icons.info_outline),
        const SizedBox(height: 12),
        _buildSecondaryActions(context),
      ],
    );
  }

  // Quick Stats Cards - Dashboard metrics untuk Ranting
  Widget _buildQuickStats(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickStatCard(
            icon: Icons.pending_actions,
            label: "Draft",
            value: "2",
            color: Colors.orange,
            isDark: isDark,
            onTap: () => AppDialog.showComingSoon(context, feature: "Draft SP"),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickStatCard(
            icon: Icons.send,
            label: "Diajukan",
            value: "5",
            color: Colors.blue,
            isDark: isDark,
            onTap:
                () => AppDialog.showComingSoon(
                  context,
                  feature: "Status Pengajuan",
                ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickStatCard(
            icon: Icons.check_circle,
            label: "Selesai",
            value: "18",
            color: Colors.green,
            isDark: isDark,
            onTap: () => AppDialog.showComingSoon(context, feature: "Riwayat"),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: theme.colorScheme.primary),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  // Primary Actions - Fitur administrasi utama
  Widget _buildPrimaryActions(BuildContext context) {
    final primaryItems = [
      _MenuItem(
        icon: Icons.post_add,
        title: "Pengajuan SP",
        subtitle: "Ajukan Surat Pengesahan baru",
        color: AppColors.documentEmerald,
        isPrimary: true,
        route: () => AppDialog.showComingSoon(context, feature: "Pengajuan SP"),
      ),
      _MenuItem(
        icon: Icons.description_outlined,
        title: "Generate Administrasi",
        subtitle: "Buat dokumen administrasi SP",
        color: AppColors.ipnuPrimaryLight,
        isPrimary: true,
        route: () => AppRoutes.toNamed(RouteNames.documentMenu),
      ),
      _MenuItem(
        icon: Icons.history,
        title: "Riwayat Administrasi",
        subtitle: "Lihat semua dokumen & pengajuan",
        color: AppColors.documentTeal,
        isPrimary: true,
        route: () => AppRoutes.toNamed(RouteNames.generatedFiles),
      ),
    ];

    return Column(
      children:
          primaryItems.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _PrimaryCard(
                icon: item.icon,
                title: item.title,
                subtitle: item.subtitle!,
                color: item.color,
                isDark: isDark,
                onTap: item.route,
              ),
            );
          }).toList(),
    );
  }

  // Secondary Actions - Informasi & support
  Widget _buildSecondaryActions(BuildContext context) {
    final secondaryItems = [
      _MenuItem(
        icon: Icons.newspaper,
        title: "Berita Organisasi",
        color: AppColors.lightError,
        route:
            () =>
                AppDialog.showComingSoon(context, feature: "Berita Organisasi"),
      ),
      _MenuItem(
        icon: Icons.people_alt_outlined,
        title: "Data Pengurus",
        color: AppColors.documentAmber,
        route:
            () => AppDialog.showComingSoon(context, feature: "Data Pengurus"),
      ),
      _MenuItem(
        icon: Icons.analytics_outlined,
        title: "Statistik",
        color: AppColors.documentCyan,
        route: () => AppDialog.showComingSoon(context, feature: "Statistik"),
      ),
      _MenuItem(
        icon: Icons.help_outline,
        title: "Bantuan",
        color: AppColors.ipnuSecondaryLight,
        route: () => AppDialog.showComingSoon(context, feature: "Bantuan"),
      ),
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: secondaryItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.3,
      ),
      itemBuilder: (_, i) {
        final item = secondaryItems[i];
        return _SecondaryCard(
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

// Model untuk menu item
class _MenuItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color color;
  final VoidCallback route;
  final bool isPrimary;

  _MenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.color,
    required this.route,
    this.isPrimary = false,
  });
}

// Quick Stat Card - Kartu statistik monitoring
class _QuickStatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool isDark;
  final VoidCallback onTap;

  const _QuickStatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: isDark ? theme.colorScheme.surface : Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Primary Card - Kartu besar untuk fitur administrasi utama
class _PrimaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final bool isDark;
  final VoidCallback onTap;

  const _PrimaryCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withValues(alpha: 0.9),
                color.withValues(alpha: 0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Icon Container
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 32),
              ),

              const SizedBox(width: 16),

              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.9),
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Arrow Icon
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white.withValues(alpha: 0.7),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Secondary Card - Kartu kecil untuk informasi & support
class _SecondaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final bool isDark;
  final VoidCallback onTap;

  const _SecondaryCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? theme.colorScheme.surface : Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color:
                  isDark
                      ? theme.colorScheme.outline.withValues(alpha: 0.2)
                      : color.withValues(alpha: 0.4),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
