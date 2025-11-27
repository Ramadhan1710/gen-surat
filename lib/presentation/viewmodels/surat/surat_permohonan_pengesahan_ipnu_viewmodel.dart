import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gen_surat/domain/entities/generated_file_entity.dart';
import 'package:gen_surat/domain/entities/surat_permohonan_pengesahan_ipnu_entity.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/ipnu/generate_surat_permohonan_pengesahan_ipnu_usecase.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:share_plus/share_plus.dart';

/// ViewModel untuk Surat Permohonan Pengesahan IPNU
/// Menggunakan GetX untuk state management
class SuratPermohonanPengesahanIpnuViewModel extends GetxController {
  final GenerateSuratPermohonanPengesahanIpnuUseCase generateSuratUseCase;
  final IGeneratedFileRepository fileRepository;

  SuratPermohonanPengesahanIpnuViewModel(
    this.generateSuratUseCase,
    this.fileRepository,
  );

  // ========== Form Controllers ==========
  final jenisLembagaController = TextEditingController();
  final namaLembagaController = TextEditingController();
  final nomorTeleponLembagaController = TextEditingController();
  final alamatLembagaController = TextEditingController();
  final emailLembagaController = TextEditingController();
  final nomorSuratController = TextEditingController();
  final tanggalRapatController = TextEditingController();
  final tanggalHijriahController = TextEditingController();
  final tanggalMasehiController = TextEditingController();  
  final periodeKepengurusanController = TextEditingController();
  final namaKetuaTerpilihController = TextEditingController();
  final namaSekretarisTerpilihController = TextEditingController();
  final jenisLembagaIndukController = TextEditingController();

  // ========== Form Keys ==========
  final formKey = GlobalKey<FormState>();

  // ========== Observable States ==========
  final isLoading = false.obs;
  final uploadProgress = 0.0.obs;
  final errorMessage = RxnString();
  final generatedFile = Rxn<File>();

  // File signatures
  final ttdKetuaFile = Rxn<File>();
  final ttdSekretarisFile = Rxn<File>();

  // Cancel token untuk cancel request
  CancelToken? _cancelToken;

  @override
  void onClose() {
    // Cleanup controllers
    jenisLembagaController.dispose();
    namaLembagaController.dispose();
    nomorTeleponLembagaController.dispose();
    alamatLembagaController.dispose();
    emailLembagaController.dispose();
    nomorSuratController.dispose();
    tanggalRapatController.dispose();
    tanggalHijriahController.dispose();
    tanggalMasehiController.dispose();
    periodeKepengurusanController.dispose();
    namaKetuaTerpilihController.dispose();
    namaSekretarisTerpilihController.dispose();
    jenisLembagaIndukController.dispose();

    // Cancel ongoing request if any
    _cancelToken?.cancel();

    super.onClose();
  }

  /// Set file tanda tangan ketua
  void setTtdKetua(File file) {
    ttdKetuaFile.value = file;
    errorMessage.value = null; // Clear error
  }

  /// Set file tanda tangan sekretaris
  void setTtdSekretaris(File file) {
    ttdSekretarisFile.value = file;
    errorMessage.value = null; // Clear error
  }

  /// Remove tanda tangan ketua
  void removeTtdKetua() {
    ttdKetuaFile.value = null;
  }

  /// Remove tanda tangan sekretaris
  void removeTtdSekretaris() {
    ttdSekretarisFile.value = null;
  }

  /// Validate form dan generate surat
  Future<void> generateSurat() async {
    // Clear previous states
    errorMessage.value = null;
    generatedFile.value = null;

    // Validate form
    if (!formKey.currentState!.validate()) {
      errorMessage.value = 'Mohon lengkapi semua field yang diperlukan';
      return;
    }

    // Validate files
    if (ttdKetuaFile.value == null) {
      errorMessage.value = 'Tanda tangan ketua belum dipilih';
      return;
    }

    if (ttdSekretarisFile.value == null) {
      errorMessage.value = 'Tanda tangan sekretaris belum dipilih';
      return;
    }

    try {
      isLoading.value = true;
      uploadProgress.value = 0.0;

      // Create cancel token
      _cancelToken = CancelToken();

      // Create entity from form data
      final entity = SuratPermohonanPengesahanIpnuEntity(
        jenisLembaga: jenisLembagaController.text.trim(),
        namaLembaga: namaLembagaController.text.trim(),
        nomorTeleponLembaga: nomorTeleponLembagaController.text.trim(),
        alamatLembaga: alamatLembagaController.text.trim(),
        emailLembaga: emailLembagaController.text.trim(),
        nomorSurat: nomorSuratController.text.trim(),
        tanggalRapat: tanggalRapatController.text.trim(),
        tanggalHijriah: tanggalHijriahController.text.trim(),
        tanggalMasehi: tanggalMasehiController.text.trim(),
        periodeKepengurusan: periodeKepengurusanController.text.trim(),
        namaKetuaTerpilih: namaKetuaTerpilihController.text.trim(),
        namaSekretarisTerpilih: namaSekretarisTerpilihController.text.trim(),
        jenisLembagaInduk: jenisLembagaIndukController.text.trim(),
        ttdKetuaPath: ttdKetuaFile.value!.path,
        ttdSekretarisPath: ttdSekretarisFile.value!.path,
      );

      // Generate surat via usecase
      final file = await generateSuratUseCase.execute(
        entity,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            uploadProgress.value = received / total;
          }
        },
        cancelToken: _cancelToken,
      );

      generatedFile.value = file;

      // Simpan informasi file ke Hive
      await _saveFileToHive(file, entity);

      // Show success message
      Get.snackbar(
        'Sukses',
        'Surat berhasil di-generate dan disimpan!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } on ValidationException catch (e) {
      errorMessage.value = e.message;
      Get.snackbar(
        'Validasi Gagal',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withOpacity(0.8),
        colorText: Colors.white,
      );
    } on DioException catch (e) {
      String errorMsg;
      
      if (e.type == DioExceptionType.connectionTimeout) {
        errorMsg = 'Koneksi timeout. Pastikan internet Anda stabil.';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMsg = 'Server terlalu lama merespon. Coba lagi nanti.';
      } else if (e.type == DioExceptionType.unknown) {
        if (e.error.toString().contains('HandshakeException')) {
          errorMsg = 'Gagal koneksi ke server (SSL Error). Pastikan koneksi internet Anda stabil dan coba lagi.';
        } else if (e.error.toString().contains('SocketException')) {
          errorMsg = 'Tidak dapat terhubung ke server. Periksa koneksi internet Anda.';
        } else {
          errorMsg = 'Terjadi kesalahan koneksi: ${e.message ?? "Unknown error"}';
        }
      } else if (e.type == DioExceptionType.badResponse) {
        errorMsg = 'Server error (${e.response?.statusCode}): ${e.response?.statusMessage ?? "Unknown"}';
      } else {
        errorMsg = 'Gagal generate surat: ${e.message ?? e.toString()}';
      }
      
      errorMessage.value = errorMsg;
      Get.snackbar(
        'Error Koneksi',
        errorMsg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 7),
      );
      
      log('DioException: ${e.type}, ${e.message}, ${e.error}');
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan: ${e.toString()}';
      Get.snackbar(
        'Error',
        'Gagal generate surat: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
      
      log('Unexpected error: $e');
    } finally {
      isLoading.value = false;
      uploadProgress.value = 0.0;
    }
  }

  /// Cancel ongoing request
  void cancelGenerate() {
    _cancelToken?.cancel('Dibatalkan oleh user');
    isLoading.value = false;
    uploadProgress.value = 0.0;
  }

  /// Reset form
  void resetForm() {
    // Clear all controllers
    jenisLembagaController.clear();
    namaLembagaController.clear();
    nomorTeleponLembagaController.clear();
    alamatLembagaController.clear();
    emailLembagaController.clear();
    nomorSuratController.clear();
    tanggalRapatController.clear();
    tanggalHijriahController.clear();
    tanggalMasehiController.clear();
    periodeKepengurusanController.clear();
    namaKetuaTerpilihController.clear();
    namaSekretarisTerpilihController.clear();
    jenisLembagaIndukController.clear();

    // Clear files
    ttdKetuaFile.value = null;
    ttdSekretarisFile.value = null;

    // Clear states
    errorMessage.value = null;
    generatedFile.value = null;
    uploadProgress.value = 0.0;

    // Reset form validation
    formKey.currentState?.reset();
  }

  /// Open generated file using native viewer
  Future<void> openGeneratedFile() async {
    if (generatedFile.value == null) {
      Get.snackbar(
        'Info',
        'Belum ada file yang di-generate',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      // Open file using native viewer/app
      final result = await OpenFilex.open(generatedFile.value!.path);
      
      log('Open file result: ${result.type} - ${result.message}');
      
      // Handle result
      if (result.type == ResultType.done) {
        log('File opened successfully');
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

  /// Share generated file via share dialog
  Future<void> shareGeneratedFile() async {
    if (generatedFile.value == null) {
      Get.snackbar(
        'Info',
        'Belum ada file yang di-generate',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      // Share file using native share dialog
      final result = await Share.shareXFiles(
        [XFile(generatedFile.value!.path)],
        text: 'Surat Permohonan Pengesahan IPNU',
      );
      
      if (result.status == ShareResultStatus.success) {
        log('File shared successfully');
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

  /// Get file info
  String getFileName() {
    if (generatedFile.value == null) return '';
    return generatedFile.value!.path.split('/').last;
  }

  /// Get file size in readable format
  String getFileSize() {
    if (generatedFile.value == null || !generatedFile.value!.existsSync()) {
      return 'Unknown';
    }
    final bytes = generatedFile.value!.lengthSync();
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  }

  /// Get file path
  String getFilePath() {
    if (generatedFile.value == null) return '';
    return generatedFile.value!.path;
  }

  /// Save file information to Hive via Repository
  Future<void> _saveFileToHive(
    File file,
    SuratPermohonanPengesahanIpnuEntity entity,
  ) async {
    try {
      final fileEntity = GeneratedFileEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        fileName: file.path.split('/').last,
        filePath: file.path,
        fileType: 'permohonan_pengesahan',
        lembaga: 'IPNU',
        fileSize: file.existsSync() ? file.lengthSync() : 0,
        createdAt: DateTime.now(),
        nomorSurat: entity.nomorSurat,
        namaLembaga: entity.namaLembaga,
        description: 'Surat Permohonan Pengesahan ${entity.namaLembaga}',
      );

      await fileRepository.saveFile(fileEntity);
      log('File information saved to Hive via Repository');
    } catch (e) {
      log('Error saving file to Hive: $e');
      // Don't throw error, just log it
    }
  }
}
