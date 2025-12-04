import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';

/// Widget untuk menampilkan sub-header dalam section review
///
/// Digunakan untuk membagi konten dalam section menjadi sub-bagian
class ReviewSubHeader extends StatelessWidget {
  /// Teks header yang akan ditampilkan
  final String title;

  /// Warna teks header
  final Color color;

  /// Padding bawah (default: AppDimensions.spaceS)
  final double bottomPadding;

  const ReviewSubHeader({
    super.key,
    required this.title,
    required this.color,
    this.bottomPadding = AppDimensions.spaceS,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
