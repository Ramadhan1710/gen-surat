import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:get/get.dart';

/// Global bindings untuk services yang perlu persistent di seluruh app lifecycle
class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    // Services ini di-register permanent karena digunakan di banyak tempat
    // Tidak perlu fenix karena permanent = true sudah membuat singleton
    Get.put<NotificationService>(
      GetXNotificationService(),
      permanent: true,
    );

    Get.put<FileOperationService>(
      FileOperationService(),
      permanent: true,
    );
  }
}
