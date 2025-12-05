import 'package:flutter/material.dart';
import 'package:gen_surat/core/constants/image_constants.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      height: 180,
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient:  LinearGradient(
          colors: isDark ? [
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
            Theme.of(context).colorScheme.secondary.withValues(alpha: 0.8),
          ] : [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.2,
              child: Row(
                children: [
                  Image.asset(
                    ImageConstants.logoIpnu,
                    width: 100,
                    height: 100,
                  ),
                  Image.asset(
                    ImageConstants.logoIppnu,
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: -20,
            top: -10,
            child: Opacity(
              opacity: 0.25,
              child: Icon(
                Icons.auto_awesome,
                size: 140,
                color: Colors.white,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SuperApp",
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  "PAC IPNU–IPPNU Loceret",
                  style: AppTextStyles.titleLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Semua kebutuhan organisasi dalam satu aplikasi.",
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
