import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/bersama/generate_surat_permohonan_peminjaman_alat_bersama_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/permohonan_peminjaman_alat/surat_permohonan_peminjaman_alat_bersama_viewmodel.dart';
import 'package:get/get.dart';

class SuratPermohonanPeminjamanAlatBersamaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuratPermohonanPeminjamanAlatBersamaViewmodel>(
      () => SuratPermohonanPeminjamanAlatBersamaViewmodel(
        Get.find<GenerateSuratPermohonanPeminjamanAlatBersamaUsecase>(),
        Get.find<IGeneratedFileRepository>(),
        Get.find<NotificationService>(),
        Get.find<FileOperationService>(),
      ),
    );
  }
}
