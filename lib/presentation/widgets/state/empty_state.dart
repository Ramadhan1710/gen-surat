import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String message;
  final Color primaryColor;

  const EmptyState({
    super.key,
    required this.title,
    required this.message,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 100,
            color: primaryColor.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: AppTextStyles.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: primaryColor.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
