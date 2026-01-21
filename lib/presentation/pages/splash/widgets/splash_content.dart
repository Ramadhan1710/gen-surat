import 'package:flutter/material.dart';

/// Widget untuk menampilkan text content di splash screen dengan animasi
class SplashContent extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final ThemeData theme;
  final bool isDark;

  const SplashContent({
    super.key,
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.theme,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: FadeTransition(opacity: fadeAnimation, child: _buildTextSection()),
    );
  }

  Widget _buildTextSection() {
    return Column(
      children: [
        // App Name
        Text(
          'SuperApp',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),

        // Organization Name
        Text(
          'PAC IPNU-IPPNU Loceret',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.white.withValues(alpha: 0.95),
          ),
        ),
        const SizedBox(height: 16),

        // Tagline
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Administrasi Modern & Digital',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 32),

        // Version Info
        _buildVersionInfo(),
      ],
    );
  }

  Widget _buildVersionInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.auto_awesome,
          size: 16,
          color: Colors.white.withValues(alpha: 0.7),
        ),
        const SizedBox(width: 8),
        Text(
          'Versi 1.0.0',
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
