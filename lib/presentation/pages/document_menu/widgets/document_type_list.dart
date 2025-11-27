import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/presentation/pages/document_menu/models/document_item.dart';
import 'package:gen_surat/presentation/pages/document_menu/widgets/document_type_card.dart';

class DocumentTypeList extends StatelessWidget {
  final String lembaga;
  final Color color;
  final List<DocumentItem> documents;

  const DocumentTypeList({
    super.key,
    required this.lembaga,
    required this.color,
    required this.documents,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors:
              isDark
                  ? [theme.colorScheme.surface, theme.colorScheme.surface]
                  : [
                    color.withValues(alpha: 0.05),
                    theme.scaffoldBackgroundColor,
                  ],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:
                    isDark
                        ? [
                          theme.colorScheme.surface,
                          theme.colorScheme.surface.withValues(alpha: 0.8),
                        ]
                        : [
                          color.withValues(alpha: 0.1),
                          theme.scaffoldBackgroundColor,
                        ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color:
                    isDark
                        ? color.withValues(alpha: 0.5)
                        : color.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  lembaga == 'IPNU' ? Icons.group : Icons.group_outlined,
                  size: 50,
                  color: color,
                ),
                const SizedBox(height: 12),
                Text(
                  lembaga,
                  style: AppTextStyles.headlineSmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Pilih jenis administrasi yang akan dibuat',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color:
                        isDark
                            ? theme.colorScheme.onSurface.withValues(alpha: 0.7)
                            : AppColors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Document Cards
          ...documents.map((doc) => DocumentTypeCard(documentItem: doc)),
        ],
      ),
    );
  }
}
