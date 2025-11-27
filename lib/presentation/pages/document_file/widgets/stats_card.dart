import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/core/utils/format_utils.dart';
import 'package:gen_surat/domain/entities/generated_file_entity.dart';
import 'package:gen_surat/core/helper/generated_file_helper.dart';

class StatsCard extends StatelessWidget {
  final List<GeneratedFileEntity> files;

  final String fileType;

  const StatsCard({super.key, required this.files, required this.fileType});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final totalSize = files.fold<int>(0, (sum, file) => sum + file.fileSize);
    final latestFile = files.isNotEmpty ? files.first : null;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              isDark
                  ? [AppColors.darkPrimary, AppColors.darkPrimaryVariant]
                  : [
                    theme.colorScheme.primary,
                    theme.colorScheme.primary.withValues(alpha: 0.7),
                  ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  FormatUtils.getIconForFileType(fileType),
                  size: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${files.length} Dokumen',
                      style: AppTextStyles.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Total: ${FormatUtils.formatBytes(totalSize)}',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (latestFile != null) ...[
            const SizedBox(height: 16),
            Divider(color: Colors.white.withValues(alpha: 0.4)),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.update,
                  color: Colors.white.withValues(alpha: 0.7),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Terakhir: ${GeneratedFileHelper.getFormattedDate(latestFile)}',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
