import 'package:flutter/material.dart';

/// Widget untuk menampilkan loading indicator di splash screen
class SplashLoading extends StatelessWidget {
  final Animation<double> fadeAnimation;

  const SplashLoading({super.key, required this.fadeAnimation});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ),
      ),
    );
  }
}
