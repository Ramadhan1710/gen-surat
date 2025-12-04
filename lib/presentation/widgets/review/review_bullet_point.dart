import 'package:flutter/material.dart';

/// Widget untuk menampilkan teks dengan bullet point
///
/// Digunakan untuk menampilkan list item dengan format bullet
class ReviewBulletPoint extends StatelessWidget {
  /// Teks yang akan ditampilkan
  final String text;

  /// Simbol bullet yang digunakan (default: '• ')
  final String bulletSymbol;

  /// Style untuk teks
  final TextStyle? textStyle;

  const ReviewBulletPoint({
    super.key,
    required this.text,
    this.bulletSymbol = '• ',
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(bulletSymbol, style: const TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
