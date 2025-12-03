import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/ipnu/generate_curriculum_vitae_ipnu_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/curriculum_vitae/curriculum_vitae_ipnu_viewmodel.dart';
import 'package:get/get.dart';

class CurriculumVitaeIpnuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CurriculumVitaeIpnuViewmodel>(
      () => CurriculumVitaeIpnuViewmodel(
        Get.find<GenerateCurriculumVitaeIpnuUseCase>(),
        Get.find<IGeneratedFileRepository>(),
        Get.find<NotificationService>(),
        Get.find<FileOperationService>(),
      ),
    );
  }
}
