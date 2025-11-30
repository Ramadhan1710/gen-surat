import 'package:gen_surat/domain/usecases/ipnu/generate_surat_keputusan_ipnu_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/keputusan/surat_keputusan_ipnu_viewmodel.dart';
import 'package:get/get.dart';

import '../../domain/repositories/i_generated_file_repository.dart';
import '../../domain/usecases/ipnu/generate_surat_permohonan_pengesahan_ipnu_usecase.dart';
import '../../presentation/viewmodels/generated_files_viewmodel.dart';
import '../../presentation/viewmodels/surat/permohonan_pengesahan/surat_permohonan_pengesahan_ipnu_viewmodel.dart';
import '../../presentation/viewmodels/theme/theme_viewmodel.dart';
import '../services/file_operation_service.dart';
import '../services/notification_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Theme ViewModel
    Get.put(ThemeViewModel(), permanent: true);

    // ========== File Management ViewModels ==========
    Get.lazyPut(
      () => GeneratedFilesViewModel(Get.find<IGeneratedFileRepository>()),
      fenix: true,
    );

    // ========== IPNU ViewModels ==========
    Get.lazyPut(
      () => SuratPermohonanPengesahanIpnuViewmodel(
        Get.find<GenerateSuratPermohonanPengesahanIpnuUseCase>(),
        Get.find<IGeneratedFileRepository>(),
        Get.find<NotificationService>(),
        Get.find<FileOperationService>(),
      ),
      fenix: true,
    );

    Get.lazyPut(
      () => SuratKeputusanIpnuViewmodel(
        Get.find<GenerateSuratKeputusanIpnuUseCase>(),
        Get.find<IGeneratedFileRepository>(),
        Get.find<NotificationService>(),
        Get.find<FileOperationService>(),
      ),
      fenix: true,
    );

    // ========== IPPNU ViewModels (Coming Soon) ==========
    // TODO: Add IPPNU viewmodels here
  }
}
