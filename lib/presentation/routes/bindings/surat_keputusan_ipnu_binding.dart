import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/ipnu/generate_surat_keputusan_ipnu_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/keputusan/surat_keputusan_ipnu_viewmodel.dart';
import 'package:get/get.dart';

/// Binding untuk Surat Keputusan IPNU
/// Auto-dispose saat page ditutup
class SuratKeputusanIpnuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuratKeputusanIpnuViewmodel>(
      () => SuratKeputusanIpnuViewmodel(
        Get.find<GenerateSuratKeputusanIpnuUseCase>(),
        Get.find<IGeneratedFileRepository>(),
        Get.find<NotificationService>(),
        Get.find<FileOperationService>(),
      ),
    );
  }
}
