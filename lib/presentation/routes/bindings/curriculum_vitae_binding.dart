import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/ipnu/generate_curriculum_vitae_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/curriculum_vitae/curriculum_vitae_viewmodel.dart';
import 'package:get/get.dart';

class CurriculumVitaeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CurriculumVitaeViewmodel>(
      () => CurriculumVitaeViewmodel(
        Get.find<GenerateCurriculumVitaeUseCase>(),
        Get.find<IGeneratedFileRepository>(),
        Get.find<NotificationService>(),
        Get.find<FileOperationService>(),
      ),
    );
  }
}
