import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/services/file_download_service.dart';
import 'base_webview_viewmodel.dart';

/// ViewModel untuk Google Drive WebView page
class GDriveViewModel extends BaseWebViewViewModel {
  final FileDownloadService _downloadService;

  GDriveViewModel(this._downloadService);

  /// URL Google Drive yang akan ditampilkan
  /// Bisa di-override untuk folder lain
  String gdriveUrl =
      'https://drive.google.com/drive/folders/13q0WrRmPnaEqtvTYbtSIcaB1AIQjFSHg?usp=drive_link';

  @override
  String get initialUrl => gdriveUrl;

  /// Set custom Google Drive URL
  void setGDriveUrl(String url) {
    gdriveUrl = url;
  }

  @override
  Future<void> onDownloadStartRequest(
    InAppWebViewController controller,
    DownloadStartRequest request,
  ) async {
    final downloadUrl = request.url.toString();
    debugPrint('Download requested: $downloadUrl');

    // Tampilkan dialog pilihan mode download
    await _showDownloadModeDialog(downloadUrl);
  }

  /// Tampilkan dialog pilihan mode download
  Future<void> _showDownloadModeDialog(String url) async {
    return Get.dialog(
      AlertDialog(
        title: const Text('Pilih Mode Download'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Pilih metode download yang Anda inginkan:',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading:
                  const Icon(Icons.notifications_active, color: Colors.blue),
              title: const Text('Dio (Dengan Notifikasi)'),
              subtitle: const Text('Progress di notification panel'),
              onTap: () {
                Get.back();
                _downloadWithDio(url);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.web, color: Colors.green),
              title: const Text('Browser Download Manager'),
              subtitle: const Text('Download via browser default'),
              onTap: () {
                Get.back();
                _downloadWithBrowser(url);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal'),
          ),
        ],
      ),
    );
  }

  /// Download dengan Dio dan notification
  Future<void> _downloadWithDio(String url) async {
    String? downloadedFilePath;

    downloadedFilePath = await _downloadService.downloadWithDio(
      url,
      onSuccess: (fileName) {
        Get.snackbar(
          'Download Berhasil',
          fileName,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          mainButton: TextButton(
            style: TextButton.styleFrom(
              minimumSize: const Size(60, 36),
              maximumSize: const Size(80, 48),
            ),
            onPressed: () async {
              if (downloadedFilePath != null) {
                await _downloadService.openFile(downloadedFilePath);
                Get.closeCurrentSnackbar();
              }
            },
            child: const Text('Buka', style: TextStyle(color: Colors.white)),
          ),
        );
      },
      onError: (error) {
        Get.snackbar(
          'Error',
          'Gagal mengunduh file: $error',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
        );
      },
    );
  }

  /// Download dengan browser download manager
  Future<void> _downloadWithBrowser(String url) async {
    try {
      final uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        final launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );

        if (launched) {
          Get.snackbar(
            'Download Dimulai',
            'File akan diunduh melalui download manager',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.blue,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
            icon: const Icon(Icons.download, color: Colors.white),
          );
        } else {
          throw Exception('Gagal membuka URL download');
        }
      } else {
        throw Exception('URL tidak dapat dibuka');
      }
    } catch (e) {
      debugPrint('Download error: $e');
      Get.snackbar(
        'Error',
        'Gagal memulai download: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    }
  }
}
