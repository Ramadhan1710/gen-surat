import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';

/// Widget kartu untuk menampilkan section dalam halaman review
///
/// Widget ini reusable dan bisa digunakan di berbagai fitur untuk
/// menampilkan data dalam bentuk kartu dengan header yang bisa di-edit
class ReviewSectionCard extends StatelessWidget {
  /// Judul section yang ditampilkan di header
  final String title;

  /// Icon yang ditampilkan di sebelah judul
  final IconData icon;

  /// Warna tema untuk section (header background dan border)
  final Color color;

  /// Callback ketika tombol edit ditekan
  final VoidCallback onEdit;

  /// Widget-widget yang ditampilkan sebagai konten card
  final List<Widget> children;

  const ReviewSectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onEdit,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spaceM,
              vertical: AppDimensions.spaceS,
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: AppDimensions.spaceS),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onEdit,
                  icon: Icon(Icons.edit, color: color, size: 20),
                  tooltip: 'Edit $title',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(AppDimensions.spaceM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
