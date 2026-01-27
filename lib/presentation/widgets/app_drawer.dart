import 'package:flutter/material.dart';
import 'package:gen_surat/presentation/routes/route_names.dart';
import 'package:gen_surat/presentation/viewmodels/auth/auth_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/app_dialog.dart';
import 'package:get/get.dart';

/// Model untuk menu item di drawer
class DrawerMenuItem {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Widget? trailing;

  DrawerMenuItem({
    required this.icon,
    required this.title,
    this.onTap,
    this.iconColor,
    this.trailing,
  });
}

/// Custom Drawer yang modern dan dapat digunakan untuk berbagai role
class AppDrawer extends StatelessWidget {
  final String? userRole;
  final List<DrawerMenuItem>? customMenuItems;
  final VoidCallback? onLogout;

  const AppDrawer({
    super.key,
    this.userRole,
    this.customMenuItems,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Drawer(
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:
                isDark
                    ? [
                      theme.colorScheme.surface,
                      theme.colorScheme.surface.withValues(alpha: 0.95),
                    ]
                    : [
                      Colors.white,
                      theme.colorScheme.primary.withValues(alpha: 0.02),
                    ],
          ),
        ),
        child: Column(
          children: [
            _buildDrawerHeader(context, theme, isDark),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  if (customMenuItems != null)
                    ...customMenuItems!.map(
                      (item) => _buildMenuItem(context, theme, item),
                    )
                  else
                    ..._buildDefaultMenuItems(context, theme),
                ],
              ),
            ),
            _buildDrawerFooter(context, theme, isDark),
          ],
        ),
      ),
    );
  }

  /// Header drawer dengan profil user
  Widget _buildDrawerHeader(
    BuildContext context,
    ThemeData theme,
    bool isDark,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 48, bottom: 24, left: 16, right: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withValues(alpha: 0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Obx(() {
        final user = Get.find<AuthViewModel>().currentUser;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar dengan border
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.3),
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child:
                  user?.photoUrl != null
                      ? CircleAvatar(
                        radius: 36,
                        backgroundImage: NetworkImage(user!.photoUrl!),
                      )
                      : CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.white.withValues(alpha: 0.2),
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
            ),
            const SizedBox(height: 16),

            // Nama user
            Text(
              user?.displayName ?? "Guest User",
              style: theme.textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            // Email
            Text(
              user?.email ?? "",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.9),
                letterSpacing: 0.3,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            // Role badge (jika ada)
            if (userRole != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.workspace_premium,
                      size: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      userRole!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        );
      }),
    );
  }

  /// Build menu item dengan desain modern
  Widget _buildMenuItem(
    BuildContext context,
    ThemeData theme,
    DrawerMenuItem item,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: item.onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (item.iconColor ?? theme.colorScheme.primary)
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    item.icon,
                    size: 22,
                    color: item.iconColor ?? theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    item.title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                if (item.trailing != null)
                  item.trailing!
                else
                  Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Default menu items jika tidak ada custom items
  List<Widget> _buildDefaultMenuItems(BuildContext context, ThemeData theme) {
    return [
      _buildMenuItem(
        context,
        theme,
        DrawerMenuItem(
          icon: Icons.person_outline,
          title: "Profil Saya",
          onTap: () {
            Navigator.pop(context);
            Get.toNamed(RouteNames.profile);
          },
        ),
      ),
      _buildMenuItem(
        context,
        theme,
        DrawerMenuItem(
          icon: Icons.settings_outlined,
          title: "Pengaturan",
          onTap: () {
            Navigator.pop(context);
            // Navigate to settings
          },
        ),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Divider(),
      ),
      _buildMenuItem(
        context,
        theme,
        DrawerMenuItem(
          icon: Icons.help_outline,
          title: "Bantuan",
          onTap: () {
            Navigator.pop(context);
            // Navigate to help
          },
        ),
      ),
      _buildMenuItem(
        context,
        theme,
        DrawerMenuItem(
          icon: Icons.info_outline,
          title: "Tentang Aplikasi",
          onTap: () {
            Navigator.pop(context);
            // Show about dialog
          },
        ),
      ),
    ];
  }

  /// Footer drawer dengan tombol logout
  Widget _buildDrawerFooter(
    BuildContext context,
    ThemeData theme,
    bool isDark,
  ) {
    final authViewModel = Get.find<AuthViewModel>();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.dividerColor.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap:
                () => AppDialog.show(
                  context: context,
                  title: 'Konfirmasi Logout',
                  message: 'Apakah Anda yakin ingin keluar dari aplikasi?',
                  primaryButtonText: 'Logout',
                  customIconColor: Colors.red.shade700,
                  type: AppDialogType.error,
                  onPrimaryPressed: () async {
                    Navigator.pop(context); // Tutup dialog
                    await authViewModel.signOut();
                    Get.offAllNamed(RouteNames.login);
                  },
                ),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.red.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout_rounded,
                    size: 22,
                    color: Colors.red.shade700,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Keluar Aplikasi",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
