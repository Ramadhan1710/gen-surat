import 'package:flutter/material.dart';
import 'package:gen_surat/presentation/pages/document_menu/models/document_item.dart';
import 'package:gen_surat/presentation/pages/document_menu/widgets/document_type_card.dart';

class DocumentTypeList extends StatelessWidget {
  final String lembaga;
  final Color color;
  final List<DocumentItem> documents;
  final String logoPath;

  const DocumentTypeList({
    super.key,
    required this.lembaga,
    required this.color,
    required this.documents,
    required this.logoPath,
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
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        children: [
          // Container(
          //   clipBehavior: Clip.hardEdge,
          //   width: double.infinity,
          //   margin: const EdgeInsets.only(bottom: 24),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(16),
          //     gradient: LinearGradient(
          //       colors:
          //           isDark
          //               ? [
          //                 color.withValues(alpha: 0.8),
          //                 theme.colorScheme.secondary.withValues(alpha: 0.8),
          //               ]
          //               : [color, color.withValues(alpha: 0.7)],
          //       begin: Alignment.topLeft,
          //       end: Alignment.bottomRight,
          //     ),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.black.withOpacity(0.15),
          //         blurRadius: 12,
          //         offset: const Offset(0, 6),
          //       ),
          //     ],
          //   ),
          //   child: Stack(
          //     children: [
          //       Positioned(
          //         left: -40,
          //         bottom: -30,
          //         child: Opacity(
          //           opacity: 0.1,
          //           child: Icon(
          //             Icons.description,
          //             size: 140,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),

          //       Positioned(
          //         right: -20,
          //         top: -10,
          //         child: Opacity(
          //           opacity: 0.25,
          //           child: Image.asset(logoPath, width: 120, height: 120),
          //         ),
          //       ),

          //       Padding(
          //         padding: const EdgeInsets.all(20),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               "Administrasi $lembaga",
          //               style: AppTextStyles.headlineSmall.copyWith(
          //                 color: Colors.white,
          //               ),
          //             ),
          //             const SizedBox(height: 8),
          //             Text(
          //               "Pilih jenis administrasi yang akan dibuat",
          //               style: AppTextStyles.bodyMedium.copyWith(
          //                 color: Colors.white.withOpacity(0.8),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          ...documents.map((doc) => DocumentTypeCard(documentItem: doc)),
        ],
      ),
    );
  }
}
