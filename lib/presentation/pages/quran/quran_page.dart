import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

/// Halaman untuk menampilkan Al-Quran dari website quran.nu.or.id
class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
    // Optimasi untuk mencegah crash
    javaScriptEnabled: true,
    useHybridComposition: true,

    // Memory management
    cacheEnabled: true,
    clearCache: false,

    // Media settings untuk stabilitas
    mediaPlaybackRequiresUserGesture: true,
    allowsInlineMediaPlayback: true,

    // Zoom settings
    supportZoom: true,
    builtInZoomControls: true,
    displayZoomControls: false,

    // Disable fitur yang tidak perlu untuk mengurangi beban
    javaScriptCanOpenWindowsAutomatically: false,
    disableContextMenu: false,

    // Performance settings
    minimumFontSize: 0,
    useShouldOverrideUrlLoading: false,
    useOnLoadResource: false,
    useOnDownloadStart: false,

    // Scrollbar
    verticalScrollBarEnabled: true,
    horizontalScrollBarEnabled: true,

    // Debugging (set false di production)
    isInspectable: false,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Al-Quran Digital'),
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
                initialUrlRequest: URLRequest(
                  url: WebUri('https://quran.nu.or.id/'),
                ),
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
                  // Handle renderer crash
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

                    // Auto reload after crash
                    Future.delayed(const Duration(milliseconds: 500), () {
                      if (mounted && webViewController != null) {
                        webViewController?.reload();
                      }
                    });
                  }
                },
                onConsoleMessage: (controller, consoleMessage) {
                  // Handle console messages if needed
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
