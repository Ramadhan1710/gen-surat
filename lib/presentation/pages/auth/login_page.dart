import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../viewmodels/auth/auth_viewmodel.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_text_styles.dart';

/// Halaman Login dengan desain modern dan indah
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Get.find<AuthViewModel>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Animated Gradient Background
          _buildAnimatedBackground(isDark),

          // Main Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo with Hero Animation
                        _buildLogo(isDark),
                        const SizedBox(height: 48),

                        // Login Card with Glassmorphism
                        _buildLoginCard(context, authViewModel, isDark),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground(bool isDark) {
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

  Widget _buildLogo(bool isDark) {
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

  Widget _buildLoginCard(
    BuildContext context,
    AuthViewModel authViewModel,
    bool isDark,
  ) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color:
            isDark
                ? AppColors.darkSurface.withValues(alpha: 0.7)
                : Colors.white.withValues(alpha: 0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 30,
            spreadRadius: 0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter:
              isDark
                  ? ColorFilter.mode(Colors.transparent, BlendMode.src)
                  : ColorFilter.mode(
                    Colors.white.withValues(alpha: 0.1),
                    BlendMode.src,
                  ),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  'Smart Suite',
                  style: AppTextStyles.headlineLarge.copyWith(
                    color:
                        isDark
                            ? AppColors.darkOnSurface
                            : AppColors.lightPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // Subtitle
                Text(
                  'Generate surat dengan mudah',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color:
                        isDark
                            ? AppColors.darkOnSurface.withValues(alpha: 0.7)
                            : AppColors.grey,
                  ),
                ),
                const SizedBox(height: 40),

                // Google Sign In Button
                Obx(() {
                  if (authViewModel.isLoading) {
                    return _buildLoadingState(isDark);
                  }

                  return _buildGoogleSignInButton(authViewModel, isDark);
                }),
                const SizedBox(height: 16),

                // Error Message
                Obx(() {
                  if (authViewModel.errorMessage.isNotEmpty) {
                    return _buildErrorMessage(
                      authViewModel.errorMessage,
                      isDark,
                    );
                  }
                  return const SizedBox.shrink();
                }),

                const SizedBox(height: 24),

                // Footer Text
                Text(
                  'Masuk untuk melanjutkan',
                  style: AppTextStyles.bodySmall.copyWith(
                    color:
                        isDark
                            ? AppColors.darkOnSurface.withValues(alpha: 0.5)
                            : AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleSignInButton(AuthViewModel authViewModel, bool isDark) {
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
            final success = await authViewModel.signInWithGoogle();
            if (success) {
              Get.offAllNamed('/home');
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: isDark ? Colors.white : Colors.white,
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

  Widget _buildLoadingState(bool isDark) {
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
            'Signing in...',
            style: AppTextStyles.labelLarge.copyWith(
              color: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage(String message, bool isDark) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, -10 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color:
              isDark
                  ? AppColors.error.withOpacity(0.2)
                  : AppColors.error.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.error.withOpacity(0.5), width: 1),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: AppColors.error, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.bodySmall.copyWith(
                  color: isDark ? AppColors.error : AppColors.error,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
