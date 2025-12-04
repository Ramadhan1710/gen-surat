import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/ippnu/generate_surat_keputusan_ippnu_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/keputusan/surat_keputusan_ippnu_viewmodel.dart';
import 'package:get/get.dart';

class SuratKeputusanIppnuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuratKeputusanIppnuViewmodel>(
      () => SuratKeputusanIppnuViewmodel(
        Get.find<GenerateSuratKeputusanIppnuUseCase>(),
        Get.find<IGeneratedFileRepository>(),
        Get.find<NotificationService>(),
        Get.find<FileOperationService>(),
      ),
    );
  }
}
