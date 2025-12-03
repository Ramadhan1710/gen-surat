import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/generate_sertifikat_kaderisasi_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/sertifikat_kaderisasi/sertifikat_kaderisasi_viewmodel.dart';
import 'package:get/get.dart';

class SertifikatKaderisasiBinding extends Bindings {
  @override
  void dependencies() {
    // ViewModel
    Get.lazyPut(
      () => SertifikatKaderisasiViewmodel(
        Get.find<GenerateSertifikatKaderisasiUseCase>(),
        Get.find<IGeneratedFileRepository>(),
        Get.find<NotificationService>(),
        Get.find<FileOperationService>(),
      ),
    );
  }
}
