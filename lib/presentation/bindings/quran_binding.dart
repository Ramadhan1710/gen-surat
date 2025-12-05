import 'package:get/get.dart';

import '../viewmodels/webview/quran_viewmodel.dart';

/// Route Binding untuk Quran Page
class QuranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuranViewModel>(
      () => QuranViewModel(),
      fenix: false, // Auto dispose saat leave page
    );
  }
}
