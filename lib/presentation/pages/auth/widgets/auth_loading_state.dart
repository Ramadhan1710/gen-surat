import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_text_styles.dart';

class AuthLoadingState extends StatelessWidget {
  final bool isDark;
  final String message;

  const AuthLoadingState({
    super.key,
    required this.isDark,
    this.message = 'Loading...',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color:
            isDark
                ? AppColors.darkPrimary.withValues(alpha: 0.2)
                : AppColors.lightPrimary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            message,
            style: AppTextStyles.labelLarge.copyWith(
              color: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
