import 'package:gen_surat/domain/usecases/ipnu/generate_berita_acara_rapat_formatur_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_rapat_formatur/berita_acara_rapat_formatur_viewmodel.dart';
import 'package:get/get.dart';

class BeritaAcaraRapatFormaturBinding extends Bindings {
  @override
  void dependencies() {
    // ViewModel
    Get.lazyPut(
      () => BeritaAcaraRapatFormaturViewmodel(
        Get.find<GenerateBeritaAcaraRapatFormaturUseCase>(),
        Get.find(), // IGeneratedFileRepository
        Get.find(), // NotificationService
        Get.find(), // FileOperationService
      ),
    );
  }
}
