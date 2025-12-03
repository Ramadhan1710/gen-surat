import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gen_surat/core/services/error_mapper_service.dart';
import 'package:get/get.dart';

import '../../../core/exception/validation_exception.dart';
import '../../../core/services/file_operation_service.dart';
import '../../../core/services/notification_service.dart';
import '../../../domain/entities/generated_file_entity.dart';
import '../../../domain/repositories/i_generated_file_repository.dart';

abstract class BaseSuratViewModel extends GetxController {
  final IGeneratedFileRepository fileRepository;
  final NotificationService notificationService;
  final FileOperationService fileOperationService;

  BaseSuratViewModel({
    required this.fileRepository,
    required this.notificationService,
    required this.fileOperationService,
  });

  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;
  final uploadProgress = 0.0.obs;
  final errorMessage = RxnString();
  final generatedFile = Rxn<File>();

  CancelToken? _cancelToken;

  bool get isGeneratedSurat => generatedFile.value != null;
  bool get hasError => errorMessage.value != null;

  Future<void> generateSurat({
    String? lembaga,
    String? endpoint,
  });

  String get fileType;

  String get lembagaType;

  String getSuratDescription();

  String getNomorSurat();

  String getNamaLembaga();

  Future<void> openGeneratedFile() async {
    final result = await fileOperationService.openFile(generatedFile.value);
    if (!result.isSuccess) {
      notificationService.showError(result.message);
    }
  }

  Future<void> shareGeneratedFile() async {
    final result = await fileOperationService.shareFile(
      generatedFile.value,
      text: getSuratDescription(),
    );

    if (!result.isSuccess) {
      notificationService.showError(result.message);
    }
  }

  String getFileName() => fileOperationService.getFileName(generatedFile.value);
  String getFileSize() => fileOperationService.getFileSize(generatedFile.value);
  String getFilePath() => fileOperationService.getFilePath(generatedFile.value);

  void cancelGenerate() {
    _cancelToken?.cancel('Generate surat dibatalkan pengguna');
    isLoading.value = false;
    uploadProgress.value = 0.0;
  }

  void clearError() {
    errorMessage.value = null;
  }

  @protected
  void startLoading() {
    isLoading.value = true;
    uploadProgress.value = 0.0;
    errorMessage.value = null;
    generatedFile.value = null;
    _cancelToken = CancelToken();
  }

  @protected
  void stopLoading() {
    isLoading.value = false;
    uploadProgress.value = 0.0;
    _cancelToken = null;
  }

  @protected
  void updateProgress(int received, int total) {
    if (total != -1) {
      uploadProgress.value = received / total;
    }
  }

  @protected
  CancelToken? get cancelToken => _cancelToken;

  @protected
  void handleValidationError(ValidationException e) {
    errorMessage.value = e.message;
  }

  @protected
  void handleDioError(DioException e) {
    final message = ErrorMapperService.mapDioException(e);
    errorMessage.value = message;
    notificationService.showError(message);
    log('DioException: ${e.type}, ${e.message}');
  }

  @protected
  void handleUnexpectedError(Object e) {
    final message = 'Terjadi kesalahan: ${e.toString()}';
    errorMessage.value = message;
    notificationService.showError('Gagal generate surat: ${e.toString()}');
    log('Unexpected error: $e');
  }

  @protected
  Future<void> saveFileToLocal(File file) async {
    try {
      final fileEntity = GeneratedFileEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        fileName: getFileName(),
        filePath: file.path,
        fileType: fileType,
        lembaga: lembagaType,
        fileSize: file.existsSync() ? file.lengthSync() : 0,
        createdAt: DateTime.now(),
        nomorSurat: getNomorSurat(),
        namaLembaga: getNamaLembaga(),
        description: getSuratDescription(),
      );
      await fileRepository.saveFile(fileEntity);
      log('File saved to local database: ${fileEntity.fileName}');
    } catch (e) {
      log('Failed to save file to local database: ${e.toString()}');
    }
  }

  @protected
  void showSuccessNotification() {
    notificationService.showSuccess('Surat berhasil di-generate dan disimpan!');
  }

  @protected
  bool validateForm() {
    if (!formKey.currentState!.validate()) {
      return false;
    }
    return true;
  }

  @override
  void onClose() {
    _cancelToken?.cancel();
    super.onClose();
  }
}
