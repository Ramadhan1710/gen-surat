import 'package:flutter/material.dart';

class FileLocationDialog extends StatelessWidget {
  final String filePath;

  const FileLocationDialog({
    super.key,
    required this.filePath,
  });

  static void show(BuildContext context, String filePath) {
    showDialog(
      context: context,
      builder: (context) => FileLocationDialog(filePath: filePath),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.folder_outlined, color: Colors.blue),
          SizedBox(width: 8),
          Text('Lokasi File'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'File tersimpan di:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
            ),
            child: SelectableText(
              filePath,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.info_outline,
                size: 16,
                color: Colors.grey,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Tekan dan tahan teks untuk menyalin',
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Tutup'),
        ),
      ],
    );
  }
}
