import '../../domain/entities/generated_file_entity.dart';

/// Helper untuk formatting dan business logic terkait Generated File
/// Domain layer - Pure Dart logic
class GeneratedFileHelper {
  /// Format file size ke readable string
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  }

  /// Format date ke relative time
  static String formatRelativeDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Baru saja';
        }
        return '${difference.inMinutes} menit yang lalu';
      }
      return '${difference.inHours} jam yang lalu';
    } else if (difference.inDays == 1) {
      return 'Kemarin';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari yang lalu';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  /// Format type name untuk display
  static String formatTypeName(String fileType) {
    return fileType
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  /// Get file extension from filename
  static String getFileExtension(String fileName) {
    final parts = fileName.split('.');
    return parts.length > 1 ? parts.last.toLowerCase() : '';
  }

  /// Check if file is PDF
  static bool isPdfFile(String fileName) {
    return getFileExtension(fileName) == 'pdf';
  }

  /// Get formatted file size from entity
  static String getFormattedSize(GeneratedFileEntity entity) {
    return formatFileSize(entity.fileSize);
  }

  /// Get formatted date from entity
  static String getFormattedDate(GeneratedFileEntity entity) {
    return formatRelativeDate(entity.createdAt);
  }

  /// Get display type name from entity
  static String getDisplayTypeName(GeneratedFileEntity entity) {
    return formatTypeName(entity.fileType);
  }
}
