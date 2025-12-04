import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';

/// Card dengan konten yang dapat diperluas/dikecilkan
/// Berguna untuk item dengan banyak field atau nested items
class ExpandableItemCard extends StatelessWidget {
  /// Judul yang ditampilkan di header card
  final String title;

  /// Widget konten utama yang ditampilkan di dalam card
  final Widget child;

  /// Callback ketika tombol delete ditekan
  final VoidCallback? onDelete;

  /// Tooltip untuk tombol delete
  final String deleteTooltip;

  /// Warna background card
  final Color? backgroundColor;

  /// Widget tambahan yang ditampilkan di sebelah kiri title (opsional)
  final Widget? leadingWidget;

  /// Key untuk card (berguna untuk animasi list)
  final Key? cardKey;

  const ExpandableItemCard({
    super.key,
    required this.title,
    required this.child,
    this.onDelete,
    this.deleteTooltip = 'Hapus',
    this.backgroundColor,
    this.leadingWidget,
    this.cardKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: cardKey,
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
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
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).colorScheme.error,
                    tooltip: deleteTooltip,
                  ),
              ],
            ),
            const Divider(),
            const SizedBox(height: AppDimensions.spaceS),
            child,
          ],
        ),
      ),
    );
  }
}
