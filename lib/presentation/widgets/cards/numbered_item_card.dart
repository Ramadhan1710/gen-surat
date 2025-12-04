import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'item_card.dart';

/// Card item dengan nomor urut di header
/// Berguna untuk item yang memiliki penomoran seperti Pelindung, Pembina, dll
class NumberedItemCard extends StatelessWidget {
  /// Nomor urut item (1-based index)
  final int number;

  /// Label jenis item (contoh: "Pelindung", "Pembina", "Anggota")
  final String label;

  /// Widget konten utama yang ditampilkan di dalam card
  final Widget child;

  /// Callback ketika tombol delete ditekan
  final VoidCallback? onDelete;

  /// Tooltip untuk tombol delete
  final String deleteTooltip;

  /// Margin bawah card
  final double bottomMargin;

  /// Key untuk card (berguna untuk animasi list)
  final Key? cardKey;

  const NumberedItemCard({
    super.key,
    required this.number,
    required this.label,
    required this.child,
    this.onDelete,
    this.deleteTooltip = 'Hapus',
    this.bottomMargin = AppDimensions.spaceM,
    this.cardKey,
  });

  @override
  Widget build(BuildContext context) {
    return ItemCard(
      cardKey: cardKey,
      title: '$label $number',
      onDelete: onDelete,
      deleteTooltip: deleteTooltip,
      bottomMargin: bottomMargin,
      leadingWidget: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spaceS,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          'No. $number',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      child: child,
    );
  }
}
