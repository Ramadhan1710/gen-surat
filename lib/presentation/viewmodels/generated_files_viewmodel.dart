import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gen_surat/domain/entities/generated_file_entity.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:share_plus/share_plus.dart';

/// ViewModel untuk halaman Generated Files
/// Presentation layer - Depends on Domain (Repository interface)
class GeneratedFilesViewModel extends GetxController {
  final IGeneratedFileRepository repository;

  GeneratedFilesViewModel(this.repository);

  final isLoading = false.obs;
  final allFiles = <GeneratedFileEntity>[].obs;
  final selectedFilter = 'Semua'.obs;

  @override
  void onInit() {
    super.onInit();
    loadFiles();
  }

  /// Get available file types
  Future<List<String>> get availableFileTypes async {
    return await repository.getAllFileTypes();
  }

  /// Get filtered files
  List<GeneratedFileEntity> get filteredFiles {
    if (selectedFilter.value == 'Semua') {
      return allFiles;
    }
    return allFiles.where((file) => file.fileType == selectedFilter.value).toList();
  }

  /// Check if file exists
  bool fileExists(GeneratedFileEntity file) {
    return File(file.filePath).existsSync();
  }

  /// Load all files from Repository
  Future<void> loadFiles() async {
    try {
      isLoading.value = true;
      final files = await repository.getAllFiles();
      // Sort by created date (newest first)
      files.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      allFiles.value = files;
    } catch (e) {
      log('Error loading files: $e');
      Get.snackbar(
        'Error',
        'Gagal memuat file: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Refresh files
  Future<void> refreshFiles() async {
    await loadFiles();
    Get.snackbar(
      'Refresh',
      'Daftar file berhasil di-refresh',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  /// Set filter
  void setFilter(String filter) {
    selectedFilter.value = filter;
  }

  /// Open file
  Future<void> openFile(GeneratedFileEntity file) async {
    final fileExists = File(file.filePath).existsSync();
    
    if (!fileExists) {
      Get.snackbar(
        'Error',
        'File tidak ditemukan di storage',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    try {
      final result = await OpenFilex.open(file.filePath);
      
      if (result.type == ResultType.done) {
        log('File opened successfully: ${file.fileName}');
      } else if (result.type == ResultType.noAppToOpen) {
        Get.snackbar(
          'Info',
          'Tidak ada aplikasi untuk membuka file ini',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange.withOpacity(0.8),
          colorText: Colors.white,
        );
      } else if (result.type == ResultType.fileNotFound) {
        Get.snackbar(
          'Error',
          'File tidak ditemukan',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
      } else if (result.type == ResultType.permissionDenied) {
        Get.snackbar(
          'Error',
          'Izin ditolak untuk membuka file',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      log('Error opening file: $e');
      Get.snackbar(
        'Error',
        'Gagal membuka file: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  /// Share file
  Future<void> shareFile(GeneratedFileEntity file) async {
    final fileExists = File(file.filePath).existsSync();
    
    if (!fileExists) {
      Get.snackbar(
        'Error',
        'File tidak ditemukan di storage',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    try {
      final result = await Share.shareXFiles(
        [XFile(file.filePath)],
        text: file.description ?? file.fileName,
      );
      
      if (result.status == ShareResultStatus.success) {
        log('File shared successfully: ${file.fileName}');
      }
    } catch (e) {
      log('Error sharing file: $e');
      Get.snackbar(
        'Error',
        'Gagal membagikan file: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  /// Delete file
  Future<void> deleteFile(GeneratedFileEntity file) async {
    try {
      await repository.deleteFile(file.id);
      
      // Remove from list
      allFiles.removeWhere((f) => f.id == file.id);
      
      // Delete actual file from storage (optional)
      try {
        final actualFile = File(file.filePath);
        if (actualFile.existsSync()) {
          await actualFile.delete();
          log('Actual file deleted: ${file.filePath}');
        }
      } catch (e) {
        log('Error deleting actual file: $e');
        // Continue even if file deletion fails
      }

      Get.snackbar(
        'Sukses',
        'File berhasil dihapus',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
    } catch (e) {
      log('Error deleting file: $e');
      Get.snackbar(
        'Error',
        'Gagal menghapus file: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  /// Clear all files
  Future<void> clearAllFiles() async {
    try {
      // Delete all actual files from storage
      for (var file in allFiles) {
        try {
          final actualFile = File(file.filePath);
          if (actualFile.existsSync()) {
            await actualFile.delete();
          }
        } catch (e) {
          log('Error deleting actual file: ${file.filePath}, $e');
        }
      }

      // Clear Hive database via repository
      await repository.clearAllFiles();
      
      // Clear list
      allFiles.clear();

      Get.snackbar(
        'Sukses',
        'Semua file berhasil dihapus',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
    } catch (e) {
      log('Error clearing all files: $e');
      Get.snackbar(
        'Error',
        'Gagal menghapus semua file: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }
}
