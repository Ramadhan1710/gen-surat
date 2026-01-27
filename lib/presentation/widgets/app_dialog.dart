import 'package:flutter/material.dart';

/// Enum untuk tipe dialog
enum AppDialogType { info, success, warning, error, comingSoon, custom }

/// Custom Dialog yang modern dan dapat digunakan untuk berbagai keperluan
class AppDialog {
  /// Show dialog dengan konfigurasi custom
  static Future<T?> show<T>({
    required BuildContext context,
    AppDialogType type = AppDialogType.info,
    String? title,
    String? message,
    Widget? customContent,
    IconData? customIcon,
    Color? customIconColor,
    String? primaryButtonText,
    String? secondaryButtonText,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    bool barrierDismissible = true,
    bool showCloseButton = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder:
          (context) => _AppDialogWidget(
            type: type,
            title: title,
            message: message,
            customContent: customContent,
            customIcon: customIcon,
            customIconColor: customIconColor,
            primaryButtonText: primaryButtonText,
            secondaryButtonText: secondaryButtonText,
            onPrimaryPressed: onPrimaryPressed,
            onSecondaryPressed: onSecondaryPressed,
            showCloseButton: showCloseButton,
          ),
    );
  }

  /// Show Coming Soon dialog
  static Future<void> showComingSoon(
    BuildContext context, {
    String? feature,
    String? message,
  }) {
    return show(
      context: context,
      type: AppDialogType.comingSoon,
      title: "Segera Hadir",
      message:
          message ??
          (feature != null
              ? "Fitur $feature sedang dalam pengembangan dan akan segera tersedia."
              : "Fitur ini sedang dalam pengembangan dan akan segera tersedia."),
      primaryButtonText: "OK",
    );
  }

  /// Show Success dialog
  static Future<void> showSuccess(
    BuildContext context, {
    String? title,
    String? message,
    VoidCallback? onPressed,
  }) {
    return show(
      context: context,
      type: AppDialogType.success,
      title: title ?? "Berhasil",
      message: message ?? "Operasi berhasil dilakukan.",
      primaryButtonText: "OK",
      onPrimaryPressed: onPressed,
    );
  }

  /// Show Error dialog
  static Future<void> showError(
    BuildContext context, {
    String? title,
    String? message,
    VoidCallback? onPressed,
  }) {
    return show(
      context: context,
      type: AppDialogType.error,
      title: title ?? "Terjadi Kesalahan",
      message: message ?? "Terjadi kesalahan. Silakan coba lagi.",
      primaryButtonText: "OK",
      onPrimaryPressed: onPressed,
    );
  }

  /// Show Warning dialog
  static Future<void> showWarning(
    BuildContext context, {
    String? title,
    String? message,
    VoidCallback? onPressed,
  }) {
    return show(
      context: context,
      type: AppDialogType.warning,
      title: title ?? "Peringatan",
      message: message ?? "Harap perhatikan informasi berikut.",
      primaryButtonText: "OK",
      onPrimaryPressed: onPressed,
    );
  }

  /// Show Info dialog
  static Future<void> showInfo(
    BuildContext context, {
    String? title,
    String? message,
    VoidCallback? onPressed,
  }) {
    return show(
      context: context,
      type: AppDialogType.info,
      title: title ?? "Informasi",
      message: message ?? "Informasi penting untuk Anda.",
      primaryButtonText: "OK",
      onPrimaryPressed: onPressed,
    );
  }

  /// Show Confirmation dialog
  static Future<bool> showConfirmation(
    BuildContext context, {
    String? title,
    String? message,
    String? confirmText,
    String? cancelText,
    bool isDangerous = false,
  }) async {
    final result = await show<bool>(
      context: context,
      type: isDangerous ? AppDialogType.warning : AppDialogType.info,
      title: title ?? "Konfirmasi",
      message: message ?? "Apakah Anda yakin?",
      primaryButtonText: confirmText ?? "Ya",
      secondaryButtonText: cancelText ?? "Tidak",
      onPrimaryPressed: () => Navigator.pop(context, true),
      onSecondaryPressed: () => Navigator.pop(context, false),
    );
    return result ?? false;
  }

  /// Show Loading dialog
  static void showLoading(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => PopScope(
            canPop: false,
            child: Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).dialogBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    if (message != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        message,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
    );
  }

  /// Hide Loading dialog
  static void hideLoading(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}

/// Widget internal untuk dialog
class _AppDialogWidget extends StatelessWidget {
  final AppDialogType type;
  final String? title;
  final String? message;
  final Widget? customContent;
  final IconData? customIcon;
  final Color? customIconColor;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final bool showCloseButton;

  const _AppDialogWidget({
    required this.type,
    this.title,
    this.message,
    this.customContent,
    this.customIcon,
    this.customIconColor,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.showCloseButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final config = _getDialogConfig();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.dialogBackgroundColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close button
            if (showCloseButton)
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),

            // Icon
            _buildIcon(theme, config),

            const SizedBox(height: 16),

            // Title
            if (title != null)
              Text(
                title!,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),

            const SizedBox(height: 12),

            // Message or Custom Content
            if (customContent != null)
              customContent!
            else if (message != null)
              Text(
                message!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

            const SizedBox(height: 24),

            // Buttons
            _buildButtons(context, theme, config),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(ThemeData theme, _DialogConfig config) {
    final icon = customIcon ?? config.icon;
    final color = customIconColor ?? config.color;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
      ),
      child: Icon(icon, size: 48, color: color),
    );
  }

  Widget _buildButtons(
    BuildContext context,
    ThemeData theme,
    _DialogConfig config,
  ) {
    final hasSecondary = secondaryButtonText != null;

    return Row(
      children: [
        // Secondary Button
        if (hasSecondary)
          Expanded(
            child: OutlinedButton(
              onPressed: onSecondaryPressed ?? () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: BorderSide(
                  color: theme.colorScheme.outline.withValues(alpha: 0.5),
                ),
              ),
              child: Text(
                secondaryButtonText!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),

        if (hasSecondary) const SizedBox(width: 12),

        // Primary Button
        if (primaryButtonText != null)
          Expanded(
            child: ElevatedButton(
              onPressed: onPrimaryPressed ?? () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: config.color,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                primaryButtonText!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
      ],
    );
  }

  _DialogConfig _getDialogConfig() {
    switch (type) {
      case AppDialogType.success:
        return _DialogConfig(
          icon: Icons.check_circle_outline,
          color: Colors.green,
        );
      case AppDialogType.error:
        return _DialogConfig(icon: Icons.error_outline, color: Colors.red);
      case AppDialogType.warning:
        return _DialogConfig(
          icon: Icons.warning_amber_rounded,
          color: Colors.orange,
        );
      case AppDialogType.comingSoon:
        return _DialogConfig(
          icon: Icons.rocket_launch_outlined,
          color: Colors.purple,
        );
      case AppDialogType.info:
      case AppDialogType.custom:
        return _DialogConfig(icon: Icons.info_outline, color: Colors.blue);
    }
  }
}

/// Config untuk dialog
class _DialogConfig {
  final IconData icon;
  final Color color;

  _DialogConfig({required this.icon, required this.color});
}
