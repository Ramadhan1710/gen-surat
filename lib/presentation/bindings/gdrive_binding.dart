import 'package:get/get.dart';

import '../../core/services/file_download_service.dart';
import '../viewmodels/webview/gdrive_viewmodel.dart';

/// Route Binding untuk GDrive Page
class GDriveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GDriveViewModel>(
      () => GDriveViewModel(Get.find<FileDownloadService>()),
      fenix: false, // Auto dispose saat leave page
    );
  }
}
