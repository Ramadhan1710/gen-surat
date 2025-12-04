import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';

/// Widget kartu untuk menampilkan informasi person/orang
///
/// Digunakan untuk menampilkan daftar orang dengan nomor urut,
/// nama, peran, dan status (misal: apakah sudah ada tanda tangan)
class ReviewPersonCard extends StatelessWidget {
  /// Nomor urut person
  final int number;

  /// Nama person
  final String name;

  /// Peran/jabatan person
  final String role;

  /// Status apakah person memiliki signature/tanda tangan
  final bool hasSignature;

  /// Warna untuk avatar dan border (default: AppColors.ippnuAccent)
  final Color color;

  /// Icon untuk status true (default: Icons.check_circle)
  final IconData statusTrueIcon;

  /// Icon untuk status false (default: Icons.cancel)
  final IconData statusFalseIcon;

  /// Warna untuk status true (default: AppColors.success)
  final Color statusTrueColor;

  /// Warna untuk status false (default: AppColors.error)
  final Color statusFalseColor;

  const ReviewPersonCard({
    super.key,
    required this.number,
    required this.name,
    required this.role,
    required this.hasSignature,
    this.color = AppColors.ippnuAccent,
    this.statusTrueIcon = Icons.check_circle,
    this.statusFalseIcon = Icons.cancel,
    this.statusTrueColor = AppColors.success,
    this.statusFalseColor = AppColors.error,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceS),
      padding: const EdgeInsets.all(AppDimensions.spaceS),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 16,
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.spaceS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  role,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
          Icon(
            hasSignature ? statusTrueIcon : statusFalseIcon,
            color: hasSignature ? statusTrueColor : statusFalseColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}
