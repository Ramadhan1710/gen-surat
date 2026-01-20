import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

/// Widget untuk logo app dengan animation
/// 
/// PRINSIP: Reusability - dipakai di semua auth pages
class AuthLogo extends StatelessWidget {
  final bool isDark;

  const AuthLogo({
    super.key,
    required this.isDark,
  });

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
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Icon(
              Icons.description_rounded,
              size: 80,
              color: isDark ? AppColors.darkPrimary : Colors.white,
            ),
          ),
        );
      },
    );
  }
}
