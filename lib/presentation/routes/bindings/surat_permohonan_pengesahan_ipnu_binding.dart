import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/ipnu/generate_surat_permohonan_pengesahan_ipnu_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/permohonan_pengesahan/surat_permohonan_pengesahan_ipnu_viewmodel.dart';
import 'package:get/get.dart';

/// Binding untuk Surat Permohonan Pengesahan IPNU
/// Auto-dispose saat page ditutup
class SuratPermohonanPengesahanIpnuBinding extends Bindings {
  @override
  void dependencies() {
    // ViewModel akan otomatis di-dispose saat page ditutup
    Get.lazyPut<SuratPermohonanPengesahanIpnuViewmodel>(
      () => SuratPermohonanPengesahanIpnuViewmodel(
        Get.find<GenerateSuratPermohonanPengesahanIpnuUseCase>(),
        Get.find<IGeneratedFileRepository>(),
        Get.find<NotificationService>(),
        Get.find<FileOperationService>(),
      ),
    );
  }
}
