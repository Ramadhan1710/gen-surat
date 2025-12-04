import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/ippnu/generate_berita_acara_formatur_pembentukan_pengurus_harian_ippnu_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_formatur_pembentukan_pengurus_harian/berita_acara_formatur_pembentukan_pengurus_harian_ippnu_viewmodel.dart';
import 'package:get/get.dart';

/// Binding untuk Berita Acara Formatur Pembentukan Pengurus Harian IPPNU
/// Auto-dispose saat page ditutup
class BeritaAcaraFormaturPembentukanPengurusHarianIppnuBinding
    extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BeritaAcaraFormaturPembentukanPengurusHarianIppnuViewmodel>(
      () => BeritaAcaraFormaturPembentukanPengurusHarianIppnuViewmodel(
        Get.find<
            GenerateBeritaAcaraFormaturPembentukanPengurusHarianIppnuUseCase>(),
        Get.find<IGeneratedFileRepository>(),
        Get.find<NotificationService>(),
        Get.find<FileOperationService>(),
      ),
    );
  }
}
