import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../viewmodels/auth/auth_viewmodel.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_text_styles.dart';
import 'widgets/auth_background.dart';
import 'widgets/auth_logo.dart';
import 'widgets/auth_error_message.dart';
import 'widgets/auth_loading_state.dart';
import 'widgets/auth_divider.dart';
import 'widgets/email_register_form.dart';
import 'widgets/google_sign_in_button.dart';

/// Halaman Register
/// 
/// PRINSIP YANG SAMA dengan LoginPage:
/// - Menggunakan widget-widget reusable yang sama
/// - Single Responsibility
/// - Easy to maintain
/// 
/// PERHATIKAN: Hampir semua widget di-reuse dari login!
/// Ini adalah contoh REFACTORING yang benar.
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
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

  void _navigateToHome() {
    Get.offAllNamed('/home');
  }

  void _navigateToLogin() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Get.find<AuthViewModel>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Background - REUSED!
          AuthBackground(isDark: isDark),

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
                        // Logo - REUSED!
                        // AuthLogo(isDark: isDark),
                        // const SizedBox(height: 48),

                        // Register Card
                        _buildRegisterCard(context, authViewModel, isDark),
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

  Widget _buildRegisterCard(
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
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                'Buat Akun Baru',
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
                'Daftar untuk mulai menggunakan Smart Suite',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyLarge.copyWith(
                  color:
                      isDark
                          ? AppColors.darkOnSurface.withValues(alpha: 0.7)
                          : AppColors.grey,
                ),
              ),
              const SizedBox(height: 32),

              // Content - Show Loading or Forms
              Obx(() {
                if (authViewModel.isLoading) {
                  return AuthLoadingState(
                    isDark: isDark,
                    message: 'Creating account...',
                  );
                }

                return Column(
                  children: [
                    // Email Register Form
                    EmailRegisterForm(
                      authViewModel: authViewModel,
                      isDark: isDark,
                      onSuccess: _navigateToHome,
                      onLoginTap: _navigateToLogin,
                    ),
                    const SizedBox(height: 24),

                    // Divider - REUSED!
                    AuthDivider(isDark: isDark),
                    const SizedBox(height: 24),

                    // Google Sign In Button - REUSED!
                    GoogleSignInButton(
                      authViewModel: authViewModel,
                      isDark: isDark,
                      onSuccess: _navigateToHome,
                    ),
                  ],
                );
              }),

              const SizedBox(height: 16),

              // Error Message - REUSED!
              Obx(() {
                return AuthErrorMessage(
                  message: authViewModel.errorMessage,
                  isDark: isDark,
                );
              }),

              const SizedBox(height: 16),

              // Footer Text
              Text(
                'Dengan mendaftar, Anda menyetujui syarat & ketentuan',
                textAlign: TextAlign.center,
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
    );
  }
}
