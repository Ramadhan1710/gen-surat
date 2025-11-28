import 'package:flutter/material.dart';
import 'package:gen_surat/core/constants/image_constants.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';

class HeaderCard extends StatelessWidget {
  final int totalFiles;
  final int totalTypes;
  final String lembaga;

  const HeaderCard({
    super.key,
    required this.totalFiles,
    required this.totalTypes,
    required this.lembaga,
  });

  String getLembagaLogo() {
    if (lembaga == 'IPNU') {
      return ImageConstants.logoIpnu;
    } else if (lembaga == 'IPPNU') {
      return ImageConstants.logoIppnu;
    } else {
      return ImageConstants.logo;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withValues(alpha: isDark ? 0.2 : 0.1),
            theme.colorScheme.primary.withValues(alpha: isDark ? 0.1 : 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Image.asset(
            getLembagaLogo(),
            width: 80,
            height: 80,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                lembaga == 'IPNU' ? Icons.group : Icons.group_outlined,
                size: 60,
                color: theme.colorScheme.primary,
              );
            },
          ),
          const SizedBox(height: 12),
          Text(
            lembaga,
            style: AppTextStyles.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatColumn(
                Icons.description_outlined,
                totalFiles.toString(),
                'Dokumen',
                theme.colorScheme.primary,
              ),
              Container(
                width: 1,
                height: 50,
                color: theme.colorScheme.primary.withValues(alpha: 0.3),
              ),
              _buildStatColumn(
                Icons.folder_outlined,
                totalTypes.toString(),
                'Jenis',
                theme.colorScheme.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: color.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

}
