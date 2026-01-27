import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/presentation/routes/app_routes.dart';
import 'package:gen_surat/presentation/routes/route_names.dart';
import 'package:gen_surat/presentation/widgets/app_dialog.dart';

class SekretarisHomeGridMenu extends StatelessWidget {
  final bool isDark;

  const SekretarisHomeGridMenu({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Action Queue - Tasks yang perlu attention
        _buildActionQueue(context),

        const SizedBox(height: 24),

        // Section: Dokumen & Surat
        _buildSectionHeader(context, "Dokumen & Surat", Icons.description),
        const SizedBox(height: 12),
        _buildPrimaryActions(context),

        const SizedBox(height: 24),

        // Section: Manajemen & Arsip
        _buildSectionHeader(context, "Manajemen & Arsip", Icons.folder_special),
        const SizedBox(height: 12),
        _buildSecondaryActions(context),
      ],
    );
  }

  // Action Queue - Priority notifications untuk task yang butuh attention
  Widget _buildActionQueue(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.notification_important,
              size: 20,
              color: Colors.orange.shade700,
            ),
            const SizedBox(width: 8),
            Text(
              "Perlu Perhatian",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _ActionQueueCard(
                icon: Icons.pending_actions,
                label: "Perlu Validasi",
                value: "7",
                color: Colors.orange,
                isDark: isDark,
                onTap:
                    () => AppDialog.showComingSoon(
                      context,
                      feature: "Validasi Berkas",
                    ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ActionQueueCard(
                icon: Icons.archive_outlined,
                label: "Belum Diarsip",
                value: "12",
                color: Colors.purple,
                isDark: isDark,
                onTap:
                    () => AppDialog.showComingSoon(
                      context,
                      feature: "Pengarsipan",
                    ),
              ),
            ),
          ],
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

  // Primary Actions - Core secretary functions
  Widget _buildPrimaryActions(BuildContext context) {
    final primaryItems = [
      _MenuItem(
        icon: Icons.edit_document,
        title: "Generate Surat Internal",
        subtitle: "Buat surat organisasi internal",
        color: AppColors.documentEmerald,
        isPrimary: true,
        route: () => AppRoutes.toNamed(RouteNames.documentMenu),
      ),
      _MenuItem(
        icon: Icons.fact_check,
        title: "Validasi Berkas",
        subtitle: "Review & validasi pengajuan",
        color: AppColors.ipnuPrimaryLight,
        isPrimary: true,
        badge: "7",
        badgeColor: Colors.orange,
        route:
            () => AppDialog.showComingSoon(context, feature: "Validasi Berkas"),
      ),
      _MenuItem(
        icon: Icons.archive,
        title: "Pengarsipan Dokumen",
        subtitle: "Kelola arsip masuk & keluar",
        color: AppColors.documentCyan,
        isPrimary: true,
        route: () => AppDialog.showComingSoon(context, feature: "Pengarsipan"),
      ),
      _MenuItem(
        icon: Icons.school_outlined,
        title: "Kelola Edukasi",
        subtitle: "Materi administrasi & panduan",
        color: AppColors.documentTeal,
        isPrimary: true,
        route:
            () => AppDialog.showComingSoon(context, feature: "Kelola Edukasi"),
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
                badge: item.badge,
                badgeColor: item.badgeColor,
                onTap: item.route,
              ),
            );
          }).toList(),
    );
  }

  // Secondary Actions - Supporting features
  Widget _buildSecondaryActions(BuildContext context) {
    final secondaryItems = [
      _MenuItem(
        icon: Icons.history,
        title: "Riwayat Surat",
        color: AppColors.documentAmber,
        route: () => AppRoutes.toNamed(RouteNames.generatedFiles),
      ),
      _MenuItem(
        icon: Icons.analytics_outlined,
        title: "Statistik",
        color: AppColors.lightError,
        route: () => AppDialog.showComingSoon(context, feature: "Statistik"),
      ),
      _MenuItem(
        icon: Icons.people_outline,
        title: "Data Organisasi",
        color: AppColors.documentLime,
        route:
            () => AppDialog.showComingSoon(context, feature: "Data Organisasi"),
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
  final String? badge;
  final Color? badgeColor;

  _MenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.color,
    required this.route,
    this.isPrimary = false,
    this.badge,
    this.badgeColor,
  });
}

// Action Queue Card - Highlight tasks yang perlu immediate attention
class _ActionQueueCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool isDark;
  final VoidCallback onTap;

  const _ActionQueueCard({
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
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withValues(alpha: 0.15),
                color.withValues(alpha: 0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: color, size: 24),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Primary Card - Main secretary functions
class _PrimaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final bool isDark;
  final String? badge;
  final Color? badgeColor;
  final VoidCallback onTap;

  const _PrimaryCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.isDark,
    this.badge,
    this.badgeColor,
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
                        if (badge != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: badgeColor ?? Colors.red,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: (badgeColor ?? Colors.red).withValues(
                                    alpha: 0.4,
                                  ),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              badge!,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
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

// Secondary Card - Supporting features
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
            color: isDark ? theme.colorScheme.surface : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color:
                  isDark
                      ? theme.colorScheme.outline.withValues(alpha: 0.1)
                      : color.withValues(alpha: 0.15),
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
