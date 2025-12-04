import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/ippnu/generate_berita_acara_penyusunan_pengurus_ippnu_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_penyusunan_pengurus/berita_acara_penyusunan_pengurus_ippnu_viewmodel.dart';
import 'package:get/get.dart';

/// Binding untuk Berita Acara Penyusunan Pengurus IPPNU
/// Auto-dispose saat page ditutup
class BeritaAcaraPenyusunanPengurusIppnuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BeritaAcaraPenyusunanPengurusIppnuViewmodel>(
      () => BeritaAcaraPenyusunanPengurusIppnuViewmodel(
        Get.find<GenerateBeritaAcaraPenyusunanPengurusIppnuUseCase>(),
        Get.find<IGeneratedFileRepository>(),
        Get.find<NotificationService>(),
        Get.find<FileOperationService>(),
      ),
    );
  }
}
