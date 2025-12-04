import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';

/// Widget untuk menampilkan empty state dengan styling konsisten
/// Digunakan ketika belum ada data dalam list
class EmptyStateContainer extends StatelessWidget {
  /// Pesan yang ditampilkan
  final String message;

  /// Padding container
  final EdgeInsetsGeometry? padding;

  const EmptyStateContainer({
    super.key,
    required this.message,
    this.padding = const EdgeInsets.all(AppDimensions.spaceL),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Center(
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
