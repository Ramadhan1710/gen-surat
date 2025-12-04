import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/presentation/pages/document_menu/models/document_item.dart';
import 'package:gen_surat/presentation/pages/document_menu/widgets/document_type_card.dart';

/// Custom clipper untuk bentuk segitiga
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Segitiga yang mengarah ke atas
    path.moveTo(size.width / 2, 0); // Top center
    path.lineTo(size.width, size.height); // Bottom right
    path.lineTo(0, size.height); // Bottom left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class DocumentTypeList extends StatelessWidget {
  final String lembaga;
  final Color color;
  final List<DocumentItem> documents;
  final String logoPath;
  final bool isTriangleLogo;

  const DocumentTypeList({
    super.key,
    required this.lembaga,
    required this.color,
    required this.documents,
    required this.logoPath,
    this.isTriangleLogo = false,
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
          // Modern Header
          Container(
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors:
                    isDark
                        ? [
                          color.withValues(alpha: 0.2),
                          color.withValues(alpha: 0.1),
                        ]
                        : [
                          color.withValues(alpha: 0.15),
                          color.withValues(alpha: 0.05),
                        ],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Decorative circles
                Positioned(
                  top: -30,
                  right: -30,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -20,
                  left: -20,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color.withValues(alpha: 0.08),
                    ),
                  ),
                ),
                // Content
                Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    children: [
                      // Logo with modern styling
                      isTriangleLogo
                          ? ClipPath(
                        clipper: TriangleClipper(),
                        child: Container(
                          width: 120,
                          height: 120,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color:
                                isDark
                                    ? theme.colorScheme.surface
                                    : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: color.withValues(alpha: 0.2),
                                blurRadius: 15,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Image.asset(
                                logoPath,
                                height: 70,
                                width: 70,
                              ),
                            ),
                          ),
                        ),
                      )
                          : Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color:
                              isDark
                                  ? theme.colorScheme.surface
                                  : Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: color.withValues(alpha: 0.2),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          logoPath,
                          height: 70,
                          width: 70,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Organization name with gradient
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            color,
                            color.withValues(alpha: 0.7),
                          ],
                        ).createShader(bounds),
                        child: Text(
                          lembaga,
                          style: AppTextStyles.headlineMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Subtitle with icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.description_outlined,
                            size: 18,
                            color:
                                isDark
                                    ? theme.colorScheme.onSurface
                                        .withValues(alpha: 0.6)
                                    : AppColors.grey,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'Pilih jenis administrasi yang akan dibuat',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color:
                                    isDark
                                        ? theme.colorScheme.onSurface
                                            .withValues(alpha: 0.7)
                                        : AppColors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Document Cards
          ...documents.map((doc) => DocumentTypeCard(documentItem: doc)),
        ],
      ),
    );
  }
}
