import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/ippnu/generate_susunan_pengurus_ippnu_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/susunan_pengurus/susunan_pengurus_ippnu_viewmodel.dart';
import 'package:get/get.dart';

class SusunanPengurusIppnuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SusunanPengurusIppnuViewmodel>(
      () => SusunanPengurusIppnuViewmodel(
        Get.find<GenerateSusunanPengurusIppnuUseCase>(),
        Get.find<IGeneratedFileRepository>(),
        Get.find<NotificationService>(),
        Get.find<FileOperationService>(),
      ),
    );
  }
}
