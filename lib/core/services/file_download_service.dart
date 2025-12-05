import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import 'download_notification_service.dart';

/// Service untuk handle download file dengan berbagai metode
class FileDownloadService {
  final DownloadNotificationService _notificationService;
  final Dio _dio;

  FileDownloadService()
      : _notificationService = DownloadNotificationService(),
        _dio = Dio();

  /// Initialize notification service
  Future<void> initialize() async {
    await _notificationService.initialize();
  }

  /// Download file menggunakan Dio dengan notification progress
  /// Returns file path jika berhasil
  Future<String?> downloadWithDio(
    String url, {
    Function(String message)? onSuccess,
    Function(String error)? onError,
  }) async {
    await initialize();

    final notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    String? filePath;
    String displayFileName = 'file';

    try {
      // Dapatkan directory untuk save file
      final directory = await getApplicationDocumentsDirectory();

      // Download dengan Dio
      final response = await _dio.get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
          validateStatus: (status) => status! < 500,
        ),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = (received / total * 100).toInt();

            // Update notification progress
            _notificationService.showDownloadProgress(
              id: notificationId,
              fileName: displayFileName,
              progress: progress,
              maxProgress: 100,
            );
          }
        },
      );

      // Extract filename dari header Content-Disposition
      final fileName = _extractFileName(
        response.headers.value('content-disposition'),
        url,
      );

      displayFileName = fileName;
      filePath = '${directory.path}/$fileName';

      // Simpan bytes ke file
      final file = File(filePath);
      await file.writeAsBytes(response.data);

      // Download selesai
      await _notificationService.showDownloadComplete(
        id: notificationId,
        fileName: fileName,
      );

      onSuccess?.call(fileName);

      return filePath;
    } catch (e) {
      debugPrint('Download error: $e');

      await _notificationService.showDownloadError(
        id: notificationId,
        fileName: 'File',
        error: 'Download gagal',
      );

      onError?.call(e.toString());
      return null;
    }
  }

  /// Extract filename dari Content-Disposition header atau URL
  String _extractFileName(String? contentDisposition, String url) {
    if (contentDisposition != null &&
        contentDisposition.contains('filename')) {
      // Extract filename dari header
      final regex = RegExp(r'filename="?([^"]+)"?');
      final match = regex.firstMatch(contentDisposition);

      if (match != null && match.group(1) != null) {
        return match.group(1)!.trim();
      }
    }

    // Fallback: extract dari URL
    if (url.contains('id=')) {
      final id = Uri.parse(url).queryParameters['id'];
      return 'file_$id';
    }

    return 'download_${DateTime.now().millisecondsSinceEpoch}';
  }

  /// Open file setelah download
  Future<void> openFile(String filePath) async {
    try {
      await OpenFilex.open(filePath);
    } catch (e) {
      debugPrint('Error opening file: $e');
      Get.snackbar(
        'Error',
        'Gagal membuka file',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
