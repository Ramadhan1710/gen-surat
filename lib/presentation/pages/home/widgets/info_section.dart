import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:
            isDark
                ? theme.colorScheme.surface
                : AppColors.info.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              isDark
                  ? AppColors.info.withValues(alpha: 0.3)
                  : AppColors.info.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.info, size: 24),
              const SizedBox(width: 12),
              Text(
                'Informasi',
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? theme.colorScheme.onSurface : AppColors.info,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Aplikasi ini menyediakan template dokumen administrasi untuk:',
            style: AppTextStyles.bodyMedium.copyWith(
              color:
                  isDark
                      ? theme.colorScheme.onSurface.withValues(alpha: 0.9)
                      : AppColors.greyDark,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLogo('assets/images/logo_ipnu.png', 'IPNU', 80),
              const SizedBox(width: 10),
              _buildLogo('assets/images/logo_ippnu.png', 'IPPNU', 80),
            ],
          ),
          const SizedBox(height: 8),
          _buildInfoItem(context, 'IPNU - Ikatan Pelajar Nahdlatul Ulama'),
          _buildInfoItem(
            context,
            'IPPNU - Ikatan Pelajar Putri Nahdlatul Ulama',
          ),
          const SizedBox(height: 8),
          Text(
            'Saat ini tersedia: Generate adminsitrasi untuk pengajuan Surat Pengesahan (SP)',
            style: AppTextStyles.bodySmall.copyWith(
              color:
                  isDark
                      ? theme.colorScheme.onSurface.withValues(alpha: 0.7)
                      : AppColors.grey,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, String text) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, size: 18, color: AppColors.success),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyMedium.copyWith(
                color:
                    isDark
                        ? theme.colorScheme.onSurface.withValues(alpha: 0.9)
                        : AppColors.greyDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo(String assetPath, String alt, double size) {
    return Image.asset(
      assetPath,
      width: size,
      height: size,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color:
                alt == 'IPNU'
                    ? AppColors.ipnuPrimary.withValues(alpha: 0.1)
                    : AppColors.ippnuPrimary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(size / 4),
            border: Border.all(
              color:
                  alt == 'IPNU'
                      ? AppColors.ipnuPrimary
                      : AppColors.ippnuPrimary,
              width: 2,
            ),
          ),
          child: Icon(
            Icons.account_balance,
            size: size * 0.5,
            color:
                alt == 'IPNU' ? AppColors.ipnuPrimary : AppColors.ippnuPrimary,
          ),
        );
      },
    );
  }
}
