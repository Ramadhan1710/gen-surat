import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/bersama/generate_surat_pemberitahuan_bersama_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/pemberitahuan/surat_pemberitahuan_bersama_viewmodel.dart';
import 'package:get/get.dart';

class SuratPemberitahuanBersamaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuratPemberitahuanBersamaViewmodel>(
      () => SuratPemberitahuanBersamaViewmodel(
        Get.find<GenerateSuratPemberitahuanBersamaUsecase>(),
        Get.find<IGeneratedFileRepository>(),
        Get.find<NotificationService>(),
        Get.find<FileOperationService>(),
      ),
    );
  }
}
