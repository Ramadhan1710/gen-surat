import '../entities/generated_file_entity.dart';

/// Repository interface untuk Generated Files
/// Domain layer - Abstract contract
abstract class IGeneratedFileRepository {
  /// Save file information
  Future<void> saveFile(GeneratedFileEntity file);

  /// Get all files
  Future<List<GeneratedFileEntity>> getAllFiles();

  /// Get file by ID
  Future<GeneratedFileEntity?> getFileById(String id);

  /// Get files by type
  Future<List<GeneratedFileEntity>> getFilesByType(String fileType);

  /// Get files by lembaga
  Future<List<GeneratedFileEntity>> getFilesByLembaga(String lembaga);

  /// Get all unique file types
  Future<List<String>> getAllFileTypes();

  /// Delete file by ID
  Future<void> deleteFile(String id);

  /// Clear all files
  Future<void> clearAllFiles();

  /// Get total file count
  Future<int> getTotalFileCount();

  /// Get file count by type
  Future<int> getFileCountByType(String fileType);

  /// Search files by keyword
  Future<List<GeneratedFileEntity>> searchFiles(String keyword);
}
