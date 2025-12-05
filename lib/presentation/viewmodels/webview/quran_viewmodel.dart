import 'base_webview_viewmodel.dart';

/// ViewModel untuk Quran WebView page
class QuranViewModel extends BaseWebViewViewModel {
  @override
  String get initialUrl => 'https://quran.nu.or.id/';

  // Quran page tidak perlu download handler
  // Jadi tidak perlu override onDownloadStartRequest
}
