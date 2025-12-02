import 'package:gen_surat/data/mappers/ipnu/kartu_identitas_mapper.dart';
import 'package:gen_surat/domain/usecases/ipnu/generate_kartu_identitas_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/kartu_identitas/kartu_identitas_viewmodel.dart';
import 'package:get/get.dart';

class KartuIdentitasBinding extends Bindings {
  @override
  void dependencies() {
    // Mapper
    Get.lazyPut(() => KartuIdentitasMapper());

    // UseCase
    Get.lazyPut(() => GenerateKartuIdentitasUseCase(
          Get.find(),
          Get.find<KartuIdentitasMapper>(),
        ));

    // ViewModel
    Get.lazyPut(() => KartuIdentitasViewmodel(
          Get.find<GenerateKartuIdentitasUseCase>(),
          Get.find(), // IGeneratedFileRepository
          Get.find(), // NotificationService
          Get.find(), // FileOperationService
        ));
  }
}
