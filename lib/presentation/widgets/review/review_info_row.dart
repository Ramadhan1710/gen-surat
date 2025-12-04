import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';

/// Widget untuk menampilkan baris informasi dengan format label: value
///
/// Cocok digunakan untuk menampilkan data dalam format key-value
/// pada halaman review
class ReviewInfoRow extends StatelessWidget {
  /// Label yang ditampilkan di sebelah kiri
  final String label;

  /// Nilai yang ditampilkan di sebelah kanan
  final String value;

  /// Flex untuk bagian label (default: 2)
  final int labelFlex;

  /// Flex untuk bagian value (default: 3)
  final int valueFlex;

  const ReviewInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.labelFlex = 2,
    this.valueFlex = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.spaceS),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: labelFlex,
            child: Text(
              label,
              style: AppTextStyles.labelMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          Text(
            ':',
            style: AppTextStyles.labelMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: AppDimensions.spaceS),
          Expanded(
            flex: valueFlex,
            child: Text(
              value.isEmpty ? '-' : value,
              style: AppTextStyles.labelMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
