import 'package:gen_surat/domain/usecases/ipnu/generate_kartu_identitas_ipnu_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/kartu_identitas_ipnu/kartu_identitas_ipnu_viewmodel.dart';
import 'package:get/get.dart';

class KartuIdentitasIpnuBinding extends Bindings {
  @override
  void dependencies() {
    // ViewModel
    Get.lazyPut(
      () => KartuIdentitasIpnuViewmodel(
        Get.find<GenerateKartuIdentitasIpnuUseCase>(),
        Get.find(), // IGeneratedFileRepository
        Get.find(), // NotificationService
        Get.find(), // FileOperationService
      ),
    );
  }
}
