import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/ipnu/generate_susunan_pengurus_ipnu_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/susunan_pengurus/susunan_pengurus_ipnu_viewmodel.dart';
import 'package:get/get.dart';

/// Binding untuk Susunan Pengurus IPNU
/// Auto-dispose saat page ditutup
class SusunanPengurusIpnuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SusunanPengurusIpnuViewmodel>(
      () => SusunanPengurusIpnuViewmodel(
        Get.find<GenerateSusunanPengurusIpnuUseCase>(),
        Get.find<IGeneratedFileRepository>(),
        Get.find<NotificationService>(),
        Get.find<FileOperationService>(),
      ),
    );
  }
}
