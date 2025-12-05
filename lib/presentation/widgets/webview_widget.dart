import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../viewmodels/webview/base_webview_viewmodel.dart';

/// Reusable WebView widget untuk semua WebView pages
/// Mengikuti pattern composition yang sama dengan project
class WebViewWidget extends StatelessWidget {
  final BaseWebViewViewModel viewModel;

  const WebViewWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Progress indicator
        Obx(() {
          if (viewModel.progress.value < 1.0) {
            return LinearProgressIndicator(
              value: viewModel.progress.value,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            );
          }
          return const SizedBox.shrink();
        }),

        // WebView
        Expanded(
          child: InAppWebView(
            key: viewModel.webViewKey,
            initialUrlRequest: URLRequest(
              url: WebUri(viewModel.initialUrl),
            ),
            initialSettings: viewModel.settings,
            pullToRefreshController: viewModel.pullToRefreshController,
            onWebViewCreated: viewModel.onWebViewCreated,
            onLoadStart: viewModel.onLoadStart,
            onLoadStop: viewModel.onLoadStop,
            onProgressChanged: viewModel.onProgressChanged,
            onReceivedError: viewModel.onReceivedError,
            onRenderProcessGone: viewModel.onRenderProcessGone,
            onUpdateVisitedHistory: viewModel.onUpdateVisitedHistory,
            onDownloadStartRequest: viewModel.onDownloadStartRequest,
            onPermissionRequest: viewModel.onPermissionRequest,
            onConsoleMessage: (controller, consoleMessage) {
              // Handle console messages if needed
            },
          ),
        ),
      ],
    );
  }
}
