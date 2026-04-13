import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_text_styles.dart';

class AuthDivider extends StatelessWidget {
  final bool isDark;
  final String text;

  const AuthDivider({super.key, required this.isDark, this.text = 'atau'});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color:
                isDark
                    ? AppColors.darkOnSurface.withValues(alpha: 0.2)
                    : AppColors.grey.withValues(alpha: 0.3),
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text,
            style: AppTextStyles.bodySmall.copyWith(
              color:
                  isDark
                      ? AppColors.darkOnSurface.withValues(alpha: 0.5)
                      : AppColors.grey,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color:
                isDark
                    ? AppColors.darkOnSurface.withValues(alpha: 0.2)
                    : AppColors.grey.withValues(alpha: 0.3),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
