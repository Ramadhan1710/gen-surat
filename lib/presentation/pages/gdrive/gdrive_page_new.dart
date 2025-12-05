import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../viewmodels/webview/gdrive_viewmodel.dart';
import '../../widgets/webview_widget.dart';

/// Halaman untuk menampilkan Google Drive folder
/// Menggunakan clean architecture pattern dengan ViewModel
class GDrivePage extends StatelessWidget {
  const GDrivePage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<GDriveViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Drive'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: vm.refresh,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: SafeArea(child: WebViewWidget(viewModel: vm)),
    );
  }
}
