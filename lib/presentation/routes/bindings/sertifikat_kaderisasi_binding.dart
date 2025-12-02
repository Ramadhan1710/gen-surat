import 'package:gen_surat/data/mappers/ipnu/sertifikat_kaderisasi_mapper.dart';
import 'package:gen_surat/domain/usecases/ipnu/generate_sertifikat_kaderisasi_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/sertifikat_kaderisasi/sertifikat_kaderisasi_viewmodel.dart';
import 'package:get/get.dart';

class SertifikatKaderisasiBinding extends Bindings {
  @override
  void dependencies() {
    // Mapper
    Get.lazyPut(() => SertifikatKaderisasiMapper());

    // UseCase
    Get.lazyPut(
      () => GenerateSertifikatKaderisasiUseCase(
        Get.find(),
        Get.find<SertifikatKaderisasiMapper>(),
      ),
    );

    // ViewModel
    Get.lazyPut(
      () => SertifikatKaderisasiViewmodel(
        Get.find<GenerateSertifikatKaderisasiUseCase>(),
        Get.find(), // IGeneratedFileRepository
        Get.find(), // NotificationService
        Get.find(), // FileOperationService
      ),
    );
  }
}
