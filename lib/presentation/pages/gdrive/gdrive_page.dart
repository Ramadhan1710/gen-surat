import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gen_surat/core/services/download_notification_service.dart';

class GDrivePage extends StatefulWidget {
  const GDrivePage({super.key});

  @override
  State<GDrivePage> createState() => _GDrivePageState();
}

class _GDrivePageState extends State<GDrivePage> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;

  static const String gdriveUrl =
      'https://drive.google.com/drive/folders/13q0WrRmPnaEqtvTYbtSIcaB1AIQjFSHg?usp=drive_link';

  InAppWebViewSettings settings = InAppWebViewSettings(
    javaScriptEnabled: true,
    useHybridComposition: true,
    userAgent:
        'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36',
    cacheEnabled: true,
    clearCache: false,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    supportZoom: true,
    builtInZoomControls: true,
    displayZoomControls: false,
    javaScriptCanOpenWindowsAutomatically: true,
    disableContextMenu: false,
    minimumFontSize: 0,
    useShouldOverrideUrlLoading: false,
    useOnLoadResource: false,
    useOnDownloadStart: true,
    verticalScrollBarEnabled: true,
    horizontalScrollBarEnabled: true,
    isInspectable: false,
    mixedContentMode: MixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
  );

  PullToRefreshController? pullToRefreshController;
  String url = "";
  double progress = 0;

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      settings: PullToRefreshSettings(color: Colors.blue),
      onRefresh: () async {
        await webViewController?.reload();
      },
    );
  }

  @override
  void dispose() {
    try {
      pullToRefreshController?.dispose();
    } catch (e) {
      debugPrint('Error disposing pullToRefreshController: $e');
    } finally {
      pullToRefreshController = null;
      webViewController = null;
    }
    super.dispose();
  }

  /// Download file menggunakan Dio dengan notification background
  Future<void> _downloadFile(String url) async {
    final notificationService = DownloadNotificationService();
    await notificationService.initialize();

    final notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    String? filePath;
    String displayFileName = 'file';

    try {
      // Dapatkan directory untuk save file
      final directory = await getApplicationDocumentsDirectory();

      // Download dengan Dio dan tampilkan progress di notification
      final dio = Dio();

      // Gunakan ResponseType.bytes untuk mendapatkan response sebagai bytes
      final response = await dio.get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
          validateStatus: (status) => status! < 500,
        ),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = (received / total * 100).toInt();
            debugPrint('Progress: $progress%');

            // Update notification progress
            notificationService.showDownloadProgress(
              id: notificationId,
              fileName: displayFileName,
              progress: progress,
              maxProgress: 100,
            );
          }
        },
      );

      // Extract filename dari header Content-Disposition
      final contentDisposition = response.headers.value('content-disposition');
      debugPrint('Content-Disposition: $contentDisposition');

      String fileName;
      if (contentDisposition != null &&
          contentDisposition.contains('filename')) {
        // Extract filename dari header
        // Pattern: filename="nama file.ext" atau filename=nama_file.ext
        final regex = RegExp(r'filename="?([^"]+)"?');
        final match = regex.firstMatch(contentDisposition);

        if (match != null && match.group(1) != null) {
          fileName = match.group(1)!.trim();
        } else {
          fileName = 'download_${DateTime.now().millisecondsSinceEpoch}';
        }
      } else {
        // Fallback: extract dari URL atau buat default
        if (url.contains('id=')) {
          final id = Uri.parse(url).queryParameters['id'];
          fileName = 'file_$id';
        } else {
          fileName = 'download_${DateTime.now().millisecondsSinceEpoch}';
        }
      }

      displayFileName = fileName;
      filePath = '${directory.path}/$fileName';

      // Simpan bytes ke file
      final file = File(filePath);
      await file.writeAsBytes(response.data);

      debugPrint('File saved: $filePath');
      debugPrint('File name: $fileName');

      // Download selesai - tampilkan notification sukses
      await notificationService.showDownloadComplete(
        id: notificationId,
        fileName: fileName,
      );

      // Tampilkan snackbar dengan opsi buka file
      if (mounted) {
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
              if (filePath != null) {
                await OpenFilex.open(filePath);
                Get.closeCurrentSnackbar();
              }
            },
            child: const Text('Buka', style: TextStyle(color: Colors.white)),
          ),
        );
      }
    } catch (e) {
      debugPrint('Download error: $e');

      // Tampilkan error di notification
      await notificationService.showDownloadError(
        id: notificationId,
        fileName: 'File',
        error: 'Download gagal',
      );

      // Tampilkan snackbar error
      if (mounted) {
        Get.snackbar(
          'Error',
          'Gagal mengunduh file: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
        );
      }
    }
  }

  /// Download file menggunakan url_launcher (browser download manager)
  Future<void> _downloadFileWithBrowser(String url) async {
    try {
      final uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        // Launch URL untuk download via browser/download manager
        final launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );

        if (launched) {
          if (mounted) {
            Get.snackbar(
              'Download Dimulai',
              'File akan diunduh melalui download manager',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.blue,
              colorText: Colors.white,
              duration: const Duration(seconds: 3),
              icon: const Icon(Icons.download, color: Colors.white),
            );
          }
        } else {
          throw Exception('Gagal membuka URL download');
        }
      } else {
        throw Exception('URL tidak dapat dibuka');
      }
    } catch (e) {
      debugPrint('Download error: $e');
      if (mounted) {
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
              leading: const Icon(
                Icons.notifications_active,
                color: Colors.blue,
              ),
              title: const Text('Dio (Dengan Notifikasi)'),
              subtitle: const Text('Progress di notification panel'),
              onTap: () {
                Get.back();
                _downloadFile(url);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.web, color: Colors.green),
              title: const Text('Browser Download Manager'),
              subtitle: const Text('Download via browser default'),
              onTap: () {
                Get.back();
                _downloadFileWithBrowser(url);
              },
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Batal')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Drive'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              webViewController?.reload();
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (progress < 1.0)
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
            Expanded(
              child: InAppWebView(
                key: webViewKey,
                initialUrlRequest: URLRequest(url: WebUri(gdriveUrl)),
                initialSettings: settings,
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onLoadStart: (controller, url) {
                  if (mounted) {
                    setState(() {
                      this.url = url.toString();
                    });
                  }
                },
                onPermissionRequest: (controller, request) async {
                  return PermissionResponse(
                    resources: request.resources,
                    action: PermissionResponseAction.GRANT,
                  );
                },
                onLoadStop: (controller, url) async {
                  if (mounted && pullToRefreshController != null) {
                    try {
                      pullToRefreshController?.endRefreshing();
                    } catch (e) {
                      debugPrint('Error ending refresh: $e');
                    }
                  }
                  if (mounted) {
                    setState(() {
                      this.url = url.toString();
                    });
                  }
                },
                onReceivedError: (controller, request, error) {
                  if (mounted && pullToRefreshController != null) {
                    try {
                      pullToRefreshController?.endRefreshing();
                    } catch (e) {
                      debugPrint('Error ending refresh on error: $e');
                    }
                  }

                  if (!request.isForMainFrame!) {
                    debugPrint("Minor resource error: ${request.url}");
                    return;
                  }

                  if (mounted) {
                    Get.snackbar(
                      'Error Koneksi',
                      'Gagal memuat Google Drive. Tap refresh untuk coba lagi.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      duration: const Duration(seconds: 3),
                      mainButton: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: const Size(80, 36),
                          maximumSize: const Size(100, 48),
                        ),
                        onPressed: () {
                          if (mounted) {
                            webViewController?.reload();
                            Get.closeCurrentSnackbar();
                          }
                        },
                        child: const Text(
                          'Refresh',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }
                },
                onProgressChanged: (controller, progress) {
                  if (mounted &&
                      progress == 100 &&
                      pullToRefreshController != null) {
                    try {
                      pullToRefreshController?.endRefreshing();
                    } catch (e) {
                      debugPrint('Error ending refresh on progress: $e');
                    }
                  }
                  if (mounted) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  }
                },
                onUpdateVisitedHistory: (controller, url, androidIsReload) {
                  if (mounted) {
                    setState(() {
                      this.url = url.toString();
                    });
                  }
                },
                onRenderProcessGone: (controller, detail) {
                  debugPrint('WebView Renderer crashed: $detail');
                  if (mounted) {
                    Get.snackbar(
                      'Peringatan',
                      'Halaman perlu dimuat ulang',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.orange,
                      colorText: Colors.white,
                      duration: const Duration(seconds: 2),
                    );

                    Future.delayed(const Duration(milliseconds: 500), () {
                      if (mounted && webViewController != null) {
                        webViewController?.reload();
                      }
                    });
                  }
                },
                onDownloadStartRequest: (controller, request) async {
                  // Handle download dari Google Drive
                  final downloadUrl = request.url.toString();
                  debugPrint('Download requested: $downloadUrl');

                  // Tampilkan dialog pilihan mode download
                  await _showDownloadModeDialog(downloadUrl);
                },
                onConsoleMessage: (controller, consoleMessage) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
