import 'package:gen_surat/domain/usecases/ipnu/generate_sertifikat_kaderisasi_ipnu_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/sertifikat_kaderisasi_ipnu/sertifikat_kaderisasi_ipnu_viewmodel.dart';
import 'package:get/get.dart';

class SertifikatKaderisasiIpnuBinding extends Bindings {
  @override
  void dependencies() {
    // ViewModel
    Get.lazyPut(
      () => SertifikatKaderisasiIpnuViewmodel(
        Get.find<GenerateSertifikatKaderisasiIpnuUseCase>(),
        Get.find(), // IGeneratedFileRepository
        Get.find(), // NotificationService
        Get.find(), // FileOperationService
      ),
    );
  }
}
