import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';

class LoadingProgressWidget extends StatelessWidget {
  final double progress;
  final VoidCallback onCancel;

  const LoadingProgressWidget({
    super.key,
    required this.progress,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: progress,
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
        const SizedBox(height: 8),
        Text(
          '${(progress * 100).toStringAsFixed(0)}%',
          style: AppTextStyles.bodySmall,
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: onCancel,
          child: const Text('Batalkan'),
        ),
      ],
    );
  }
}
