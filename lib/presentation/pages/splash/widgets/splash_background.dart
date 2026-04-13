import 'package:flutter/material.dart';

/// Widget untuk background gradient splash screen
class SplashBackground extends StatelessWidget {
  final bool isDark;
  final Widget child;

  const SplashBackground({
    super.key,
    required this.isDark,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _getGradientColors(),
        ),
      ),
      child: child,
    );
  }

  List<Color> _getGradientColors() {
    if (isDark) {
      return [
        const Color(0xFF1B4D3E),
        const Color(0xFF0F3A2E),
        const Color(0xFF0A2822),
      ];
    } else {
      return [
        const Color(0xFF2D6B4F),
        const Color(0xFF1F5A42),
        const Color(0xFF134832),
      ];
    }
  }
}
