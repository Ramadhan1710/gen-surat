import 'package:gen_surat/presentation/viewmodels/webview/quran_viewmodel.dart';
import 'package:get/get.dart';


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
