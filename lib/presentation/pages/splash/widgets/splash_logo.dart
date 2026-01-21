import 'package:flutter/material.dart';
import 'package:gen_surat/core/constants/image_constants.dart';

/// Widget untuk menampilkan logo di splash screen dengan animasi
class SplashLogo extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Animation<double> scaleAnimation;
  final bool isDark;

  const SplashLogo({
    super.key,
    required this.fadeAnimation,
    required this.scaleAnimation,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: _buildLogoContainer(),
      ),
    );
  }

  Widget _buildLogoContainer() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Image.asset(
          ImageConstants.logo,
          width: 120,
          height: 120,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
