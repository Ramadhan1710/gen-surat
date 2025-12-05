import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../viewmodels/webview/quran_viewmodel.dart';
import '../../widgets/webview_widget.dart';

/// Halaman untuk menampilkan Al-Quran dari website quran.nu.or.id
/// Menggunakan clean architecture pattern dengan ViewModel
class QuranPage extends StatelessWidget {
  const QuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<QuranViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Al-Quran Digital'),
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
