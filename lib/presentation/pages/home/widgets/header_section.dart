import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selamat Datang! 👋',
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Aplikasi pembuatan dokumen administrasi untuk IPNU & IPPNU',
          style: AppTextStyles.bodyMedium.copyWith(
            color:
                isDark
                    ? theme.colorScheme.onSurface.withValues(alpha: 0.7)
                    : AppColors.grey,
          ),
        ),
      ],
    );
  }
}
