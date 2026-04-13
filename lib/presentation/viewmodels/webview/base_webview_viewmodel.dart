import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

/// Base ViewModel untuk semua WebView pages
/// Mengikuti pattern yang sama dengan BaseSuratViewModel
abstract class BaseWebViewViewModel extends GetxController {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  PullToRefreshController? pullToRefreshController;

  final url = ''.obs;
  final progress = 0.0.obs;
  final isLoading = false.obs;

  /// Override untuk mendapatkan initial URL
  String get initialUrl;

  /// Override untuk mendapatkan WebView settings
  InAppWebViewSettings get settings => InAppWebViewSettings(
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

  @override
  void onInit() {
    super.onInit();
    _initializePullToRefresh();
  }

  void _initializePullToRefresh() {
    pullToRefreshController = PullToRefreshController(
      settings: PullToRefreshSettings(color: Colors.blue),
      onRefresh: () async {
        await webViewController?.reload();
      },
    );
  }

  @override
  void onClose() {
    _dispose();
    super.onClose();
  }

  void _dispose() {
    try {
      pullToRefreshController?.dispose();
    } catch (e) {
      debugPrint('Error disposing pullToRefreshController: $e');
    } finally {
      pullToRefreshController = null;
      webViewController = null;
    }
  }

  /// Callback saat WebView dibuat
  void onWebViewCreated(InAppWebViewController controller) {
    webViewController = controller;
  }

  /// Callback saat load dimulai
  void onLoadStart(InAppWebViewController controller, WebUri? webUri) {
    if (webUri != null) {
      url.value = webUri.toString();
    }
  }

  /// Callback saat load selesai
  void onLoadStop(InAppWebViewController controller, WebUri? webUri) {
    _endRefreshing();
    if (webUri != null) {
      url.value = webUri.toString();
    }
  }

  /// Callback saat progress berubah
  void onProgressChanged(InAppWebViewController controller, int progressValue) {
    if (progressValue == 100) {
      _endRefreshing();
    }
    progress.value = progressValue / 100;
  }

  /// Callback saat terjadi error
  void onReceivedError(
    InAppWebViewController controller,
    WebResourceRequest request,
    WebResourceError error,
  ) {
    _endRefreshing();

    if (!request.isForMainFrame!) {
      debugPrint("Minor resource error: ${request.url}");
      return;
    }

    Get.snackbar(
      'Error Koneksi',
      'Gagal memuat halaman. Tap refresh untuk coba lagi.',
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
          webViewController?.reload();
          Get.closeCurrentSnackbar();
        },
        child: const Text(
          'Refresh',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  /// Callback saat renderer crash
  void onRenderProcessGone(
    InAppWebViewController controller,
    RenderProcessGoneDetail detail,
  ) {
    debugPrint('WebView Renderer crashed: $detail');

    Get.snackbar(
      'Peringatan',
      'Halaman perlu dimuat ulang',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      webViewController?.reload();
    });
  }

  /// Callback saat update visited history
  void onUpdateVisitedHistory(
    InAppWebViewController controller,
    WebUri? url,
    bool? androidIsReload,
  ) {
    if (url != null) {
      this.url.value = url.toString();
    }
  }

  /// Callback untuk handle download (override di child jika perlu)
  Future<void> onDownloadStartRequest(
    InAppWebViewController controller,
    DownloadStartRequest request,
  ) async {
    debugPrint('Download requested: ${request.url}');
    // Override di child class
  }

  /// Helper untuk refresh WebView
  @override
  void refresh() {
    webViewController?.reload();
  }

  /// Helper untuk end refreshing
  void _endRefreshing() {
    try {
      pullToRefreshController?.endRefreshing();
    } catch (e) {
      debugPrint('Error ending refresh: $e');
    }
  }

  /// Permission request handler
  Future<PermissionResponse> onPermissionRequest(
    InAppWebViewController controller,
    PermissionRequest request,
  ) async {
    return PermissionResponse(
      resources: request.resources,
      action: PermissionResponseAction.GRANT,
    );
  }
}
