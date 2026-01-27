import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_text_styles.dart';
import '../../../viewmodels/auth/auth_viewmodel.dart';

/// Widget tombol Google Sign In yang reusable
/// 
/// PRINSIP: Single Responsibility - hanya handle Google sign in
class GoogleSignInButton extends StatelessWidget {
  final AuthViewModel authViewModel;
  final bool isDark;

  const GoogleSignInButton({
    super.key,
    required this.authViewModel,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (value * 0.2),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            await authViewModel.signInWithGoogle();
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:
                    isDark
                        ? AppColors.greyLight.withValues(alpha: 0.3)
                        : AppColors.greyLight,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.lightPrimary.withValues(alpha: 0.2),
                  blurRadius: 15,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/google_logo.png',
                  height: 24,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.login,
                      size: 24,
                      color: AppColors.lightPrimary,
                    );
                  },
                ),
                const SizedBox(width: 12),
                Text(
                  'Sign in with Google',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.greyDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
