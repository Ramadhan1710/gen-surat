import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:get/get.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationService>(
      () => GetXNotificationService(),
      fenix: true,
    );

    Get.lazyPut<FileOperationService>(
      () => FileOperationService(),
      fenix: true,
    );
  }
}
