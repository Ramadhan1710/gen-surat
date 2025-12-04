import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';

/// Widget untuk menampilkan pesan ketika data kosong
///
/// Digunakan untuk memberikan feedback visual ketika
/// tidak ada data yang tersedia dalam section review
class ReviewEmptyState extends StatelessWidget {
  /// Pesan yang akan ditampilkan
  final String message;

  /// Padding vertikal (default: AppDimensions.spaceS)
  final double verticalPadding;

  const ReviewEmptyState({
    super.key,
    required this.message,
    this.verticalPadding = AppDimensions.spaceS,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Text(
        message,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
