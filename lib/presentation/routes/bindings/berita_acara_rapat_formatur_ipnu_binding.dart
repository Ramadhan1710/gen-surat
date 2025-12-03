import 'package:gen_surat/domain/usecases/ipnu/generate_berita_acara_rapat_formatur_ipnu_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_rapat_formatur_ipnu/berita_acara_rapat_formatur_ipnu_viewmodel.dart';
import 'package:get/get.dart';

class BeritaAcaraRapatFormaturIpnuBinding extends Bindings {
  @override
  void dependencies() {
    // ViewModel
    Get.lazyPut(
      () => BeritaAcaraRapatFormaturIpnuViewmodel(
        Get.find<GenerateBeritaAcaraRapatFormaturIpnuUseCase>(),
        Get.find(), // IGeneratedFileRepository
        Get.find(), // NotificationService
        Get.find(), // FileOperationService
      ),
    );
  }
}
