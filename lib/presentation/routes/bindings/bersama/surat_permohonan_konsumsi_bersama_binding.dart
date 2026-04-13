import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/bersama/generate_surat_permohonan_konsumsi_bersama_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/permohonan_konsumsi/surat_permohonan_konsumsi_bersama_viewmodel.dart';
import 'package:get/get.dart';

class SuratPermohonanKonsumsiBersamaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuratPermohonanKonsumsiBersamaViewmodel>(
      () => SuratPermohonanKonsumsiBersamaViewmodel(
        Get.find<GenerateSuratPermohonanKonsumsiBersamaUsecase>(),
        Get.find<IGeneratedFileRepository>(),
        Get.find<NotificationService>(),
        Get.find<FileOperationService>(),
      ),
    );
  }
}
