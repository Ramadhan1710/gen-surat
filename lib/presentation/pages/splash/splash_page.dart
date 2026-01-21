import 'package:flutter/material.dart';
import 'package:gen_surat/presentation/pages/splash/widgets/splash_background.dart';
import 'package:gen_surat/presentation/pages/splash/widgets/splash_content.dart';
import 'package:gen_surat/presentation/pages/splash/widgets/splash_loading.dart';
import 'package:gen_surat/presentation/pages/splash/widgets/splash_logo.dart';
import 'package:gen_surat/presentation/viewmodels/auth/auth_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/splash/splash_viewmodel.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final SplashViewModel _viewModel;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initViewModel();
    _initAnimations();
    _startSplash();
  }

  void _initViewModel() {
    final authViewModel = Get.find<AuthViewModel>();
    _viewModel = SplashViewModel(authViewModel: authViewModel);
  }

  void _initAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutBack),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();
  }

  void _startSplash() {
    _viewModel.initialize();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SplashBackground(
        isDark: isDark,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              SplashLogo(
                fadeAnimation: _fadeAnimation,
                scaleAnimation: _scaleAnimation,
                isDark: isDark,
              ),

              const Spacer(),

              SplashContent(
                fadeAnimation: _fadeAnimation,
                slideAnimation: _slideAnimation,
                theme: theme,
                isDark: isDark,
              ),

              const Spacer(flex: 2),

              SplashLoading(fadeAnimation: _fadeAnimation),
            ],
          ),
        ),
      ),
    );
  }
}
