import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/presentation/pages/document_menu/models/document_item.dart';
import 'package:gen_surat/presentation/routes/app_routes.dart';

class DocumentTypeCard extends StatelessWidget {
  final DocumentItem documentItem;

  const DocumentTypeCard({super.key, required this.documentItem});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        elevation: documentItem.isAvailable ? 2 : 1,
        borderRadius: BorderRadius.circular(16),
        color: Colors.transparent,
        child: InkWell(
          onTap:
              documentItem.isAvailable
                  ? () {
                    // Navigate to the document page
                    if (documentItem.route.isNotEmpty) {
                      AppRoutes.toNamed(documentItem.route);
                    } else {
                      _showComingSoonDialog(context, documentItem.title);
                    }
                  }
                  : () => _showComingSoonDialog(context, documentItem.title),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient:
                  documentItem.isAvailable
                      ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: documentItem.gradient,
                      )
                      : LinearGradient(
                        colors:
                            isDark
                                ? [
                                  AppColors.greyDark,
                                  AppColors.greyDark.withValues(alpha: 0.8),
                                ]
                                : [AppColors.greyLight, AppColors.grey],
                      ),
            ),
            child: Stack(
              children: [
                // Background Pattern
                Positioned(
                  right: -20,
                  top: -20,
                  child: Icon(
                    documentItem.icon,
                    size: 120,
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      // Icon
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          documentItem.icon,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Text
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    documentItem.title,
                                    style: AppTextStyles.titleMedium.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                if (!documentItem.isAvailable)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'Segera',
                                      style: AppTextStyles.labelSmall.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              documentItem.description,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Arrow Icon
                      Icon(
                        documentItem.isAvailable
                            ? Icons.arrow_forward_ios
                            : Icons.lock_outline,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
}
