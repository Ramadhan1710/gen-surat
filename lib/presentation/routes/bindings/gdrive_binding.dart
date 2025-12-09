import 'package:gen_surat/core/services/file_download_service.dart';
import 'package:gen_surat/presentation/viewmodels/webview/gdrive_viewmodel.dart';
import 'package:get/get.dart';

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
