import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';

/// Reusable card widget dengan header dan tombol delete
/// Digunakan untuk menampilkan item dalam list dengan styling konsisten
class ItemCard extends StatelessWidget {
  /// Judul yang ditampilkan di header card
  final String title;

  /// Widget konten utama yang ditampilkan di dalam card
  final Widget child;

  /// Callback ketika tombol delete ditekan
  final VoidCallback? onDelete;

  /// Tooltip untuk tombol delete
  final String deleteTooltip;

  /// Margin bawah card
  final double bottomMargin;

  /// Widget tambahan yang ditampilkan di sebelah kiri title (opsional)
  final Widget? leadingWidget;

  /// Key untuk card (berguna untuk animasi list)
  final Key? cardKey;

  const ItemCard({
    super.key,
    required this.title,
    required this.child,
    this.onDelete,
    this.deleteTooltip = 'Hapus',
    this.bottomMargin = AppDimensions.spaceM,
    this.leadingWidget,
    this.cardKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: cardKey,
      margin: EdgeInsets.only(bottom: bottomMargin),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spaceM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (leadingWidget != null) ...[
                      leadingWidget!,
                      const SizedBox(width: AppDimensions.spaceS),
                    ],
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                if (onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: onDelete,
                    tooltip: deleteTooltip,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
              ],
            ),
            const SizedBox(height: AppDimensions.spaceM),
            child,
          ],
        ),
      ),
    );
  }
}
