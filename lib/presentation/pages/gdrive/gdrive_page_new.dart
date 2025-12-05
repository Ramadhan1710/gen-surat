import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../viewmodels/webview/gdrive_viewmodel.dart';
import '../../widgets/webview_widget.dart';

class GDrivePage extends StatelessWidget {
  const GDrivePage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<GDriveViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrasi'),
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
