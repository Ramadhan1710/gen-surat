import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const ResetConfirmationDialog({
    super.key,
    required this.onConfirm,
  });

  static void show(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => ResetConfirmationDialog(onConfirm: onConfirm),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Reset Form'),
      content: const Text(
        'Apakah Anda yakin ingin mereset semua data form?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
            Get.snackbar(
              'Success',
              'Form berhasil direset',
              snackPosition: SnackPosition.BOTTOM,
            );
          },
          child: const Text('Reset'),
        ),
      ],
    );
  }
}
