import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/ippnu/generate_surat_permohonan_pengesahan_ippnu_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/permohonan_pengesahan/surat_permohonan_pengesahan_ippnu_viewmodel.dart';
import 'package:get/get.dart';

/// Binding untuk Surat Permohonan Pengesahan IPPNU
/// Auto-dispose saat page ditutup
class SuratPermohonanPengesahanIppnuBinding extends Bindings {
  @override
  void dependencies() {
    // ViewModel akan otomatis di-dispose saat page ditutup
    Get.lazyPut<SuratPermohonanPengesahanIppnuViewmodel>(
      () => SuratPermohonanPengesahanIppnuViewmodel(
        Get.find<GenerateSuratPermohonanPengesahanIppnuUseCase>(),
        Get.find<IGeneratedFileRepository>(),
        Get.find<NotificationService>(),
        Get.find<FileOperationService>(),
      ),
    );
  }
}
