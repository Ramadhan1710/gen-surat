import 'package:flutter/material.dart';
import 'package:gen_surat/core/constants/image_constants.dart';
import '../../../../core/themes/app_colors.dart';

class AuthLogo extends StatelessWidget {
  final bool isDark;

  const AuthLogo({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors:
                    isDark
                        ? [
                          AppColors.darkSecondary.withValues(alpha: 0.7),
                          AppColors.darkPrimary.withValues(alpha: 0.6),
                        ]
                        : [
                          AppColors.lightPrimaryVariant.withValues(alpha: 0.6),
                          AppColors.lightSecondary.withValues(alpha: 0.7),
                        ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Image.asset(ImageConstants.logo, width: 120, height: 120),
          ),
        );
      },
    );
  }
}
