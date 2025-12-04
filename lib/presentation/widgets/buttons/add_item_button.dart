import 'package:flutter/material.dart';

/// Tombol untuk menambah item baru dengan styling konsisten
class AddItemButton extends StatelessWidget {
  /// Label tombol
  final String label;

  /// Callback ketika tombol ditekan
  final VoidCallback onPressed;

  /// Ikon tombol (default: Icons.add)
  final IconData icon;

  /// Apakah tombol menggunakan lebar penuh
  final bool fullWidth;

  const AddItemButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon = Icons.add,
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    final button = OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );

    if (fullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }
}
