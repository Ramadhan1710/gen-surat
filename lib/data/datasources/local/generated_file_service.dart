import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/generated_file_model.dart';

/// Service untuk mengelola database file yang sudah di-generate
class GeneratedFileService {
  static const String _boxName = 'generated_files';
  Box<GeneratedFileModel>? _box;

  /// Initialize Hive dan buka box
  Future<void> init() async {
    try {
      await Hive.initFlutter();
      
      // Register adapter jika belum
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(GeneratedFileModelAdapter());
      }

      _box = await Hive.openBox<GeneratedFileModel>(_boxName);
      log('GeneratedFileService initialized successfully');
    } catch (e) {
      log('Error initializing GeneratedFileService: $e');
      rethrow;
    }
  }

  /// Get box instance
  Box<GeneratedFileModel> get box {
    if (_box == null || !_box!.isOpen) {
      throw Exception('Box is not initialized. Call init() first.');
    }
    return _box!;
  }

  /// Check if Hive is initialized and ready
  bool get isInitialized => _box != null && _box!.isOpen;

  /// Simpan file yang baru di-generate
  Future<void> saveGeneratedFile(GeneratedFileModel file) async {
    try {
      await box.put(file.id, file);
      log('File saved to Hive: ${file.fileName}');
    } catch (e) {
      log('Error saving file to Hive: $e');
      rethrow;
    }
  }

  /// Get semua file yang sudah di-generate
  List<GeneratedFileModel> getAllFiles() {
    try {
      if (!isInitialized) {
        log('Hive not initialized yet, returning empty list');
        return [];
      }
      return box.values.toList();
    } catch (e) {
      log('Error getting all files: $e');
      return [];
    }
  }

  /// Get file berdasarkan ID
  GeneratedFileModel? getFileById(String id) {
    try {
      return box.get(id);
    } catch (e) {
      log('Error getting file by id: $e');
      return null;
    }
  }

  /// Get file berdasarkan tipe surat
  List<GeneratedFileModel> getFilesByType(String fileType) {
    try {
      return box.values.where((file) => file.fileType == fileType).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      log('Error getting files by type: $e');
      return [];
    }
  }

  /// Get file berdasarkan lembaga
  List<GeneratedFileModel> getFilesByLembaga(String lembaga) {
    try {
      return box.values.where((file) => file.lembaga == lembaga).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      log('Error getting files by lembaga: $e');
      return [];
    }
  }

  /// Get semua tipe surat yang tersedia (unique)
  List<String> getAllFileTypes() {
    try {
      final types = box.values.map((file) => file.fileType).toSet().toList();
      types.sort();
      return types;
    } catch (e) {
      log('Error getting all file types: $e');
      return [];
    }
  }

  /// Delete file berdasarkan ID
  Future<void> deleteFile(String id) async {
    try {
      await box.delete(id);
      log('File deleted from Hive: $id');
    } catch (e) {
      log('Error deleting file: $e');
      rethrow;
    }
  }

  /// Clear semua file
  Future<void> clearAllFiles() async {
    try {
      await box.clear();
      log('All files cleared from Hive');
    } catch (e) {
      log('Error clearing all files: $e');
      rethrow;
    }
  }

  /// Get total file count
  int getTotalFileCount() {
    try {
      return box.length;
    } catch (e) {
      log('Error getting total file count: $e');
      return 0;
    }
  }

  /// Get total file count by type
  int getFileCountByType(String fileType) {
    try {
      return box.values.where((file) => file.fileType == fileType).length;
    } catch (e) {
      log('Error getting file count by type: $e');
      return 0;
    }
  }

  /// Search files by keyword (nama file, nomor surat, nama lembaga)
  List<GeneratedFileModel> searchFiles(String keyword) {
    try {
      final lowerKeyword = keyword.toLowerCase();
      return box.values.where((file) {
        return file.fileName.toLowerCase().contains(lowerKeyword) ||
            (file.nomorSurat?.toLowerCase().contains(lowerKeyword) ?? false) ||
            (file.namaLembaga?.toLowerCase().contains(lowerKeyword) ?? false) ||
            (file.description?.toLowerCase().contains(lowerKeyword) ?? false);
      }).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      log('Error searching files: $e');
      return [];
    }
  }

  /// Close box
  Future<void> close() async {
    try {
      await _box?.close();
      log('GeneratedFileService box closed');
    } catch (e) {
      log('Error closing GeneratedFileService box: $e');
    }
  }
}
