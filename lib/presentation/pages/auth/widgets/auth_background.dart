import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class AuthBackground extends StatelessWidget {
  final bool isDark;

  const AuthBackground({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(seconds: 3),
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors:
                  isDark
                      ? [
                        AppColors.darkBackground,
                        AppColors.darkSurface,
                        AppColors.darkPrimary.withValues(alpha: 0.3),
                      ]
                      : [
                        AppColors.lightPrimary.withValues(alpha: 0.8),
                        AppColors.ipnuPrimaryLight,
                        AppColors.ipnuAccent,
                      ],
              stops: [0.0, 0.5 + (math.sin(value * math.pi * 2) * 0.1), 1.0],
            ),
          ),
        );
      },
    );
  }
}
