import 'package:get/get.dart';

import '../../domain/repositories/i_generated_file_repository.dart';
import '../../domain/usecases/ipnu/generate_surat_permohonan_pengesahan_ipnu_usecase.dart';
import '../../presentation/viewmodels/generated_files_viewmodel.dart';
import '../../presentation/viewmodels/surat/surat_permohonan_pengesahan_ipnu_viewmodel.dart';
import '../../presentation/viewmodels/theme/theme_viewmodel.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Theme ViewModel
    Get.put(ThemeViewModel(), permanent: true);

    // ========== File Management ViewModels ==========
    Get.lazyPut(
      () => GeneratedFilesViewModel(
        Get.find<IGeneratedFileRepository>(),
      ),
      fenix: true,
    );

    // ========== IPNU ViewModels ==========
    Get.lazyPut(
      () => SuratPermohonanPengesahanIpnuViewModel(
        Get.find<GenerateSuratPermohonanPengesahanIpnuUseCase>(),
        Get.find<IGeneratedFileRepository>(),
      ),
      fenix: true,
    );

    // ========== IPPNU ViewModels (Coming Soon) ==========
    // TODO: Add IPPNU viewmodels here
  }
}
