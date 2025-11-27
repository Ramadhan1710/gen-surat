import 'package:flutter/material.dart';

class FormatUtils {
  FormatUtils._();

  static String formatTypeName(String type) {
    return type
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  static String formatBytes(int bytes) {
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
  }

  static IconData getIconForFileType(String fileType) {
    if (fileType.contains('pengesahan')) return Icons.verified_outlined;
    if (fileType.contains('keterangan')) return Icons.assignment_outlined;
    if (fileType.contains('tugas')) return Icons.work_outline;
    if (fileType.contains('proposal')) return Icons.event_note_outlined;
    return Icons.description_outlined;
  }
}
