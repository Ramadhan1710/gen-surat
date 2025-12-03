import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/ipnu/generate_berita_acara_pemilihan_ketua_ipnu_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/berita_acara_pemilihan_ketua/berita_acara_pemilihan_ketua_ipnu_viewmodel.dart';
import 'package:get/get.dart';

/// Binding untuk Berita Acara Pemilihan Ketua IPNU
/// Auto-dispose saat page ditutup
class BeritaAcaraPemilihanKetuaIpnuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BeritaAcaraPemilihanKetuaIpnuViewmodel>(
      () => BeritaAcaraPemilihanKetuaIpnuViewmodel(
        Get.find<GenerateBeritaAcaraPemilihanKetuaIpnuUseCase>(),
        Get.find<IGeneratedFileRepository>(),
        Get.find<NotificationService>(),
        Get.find<FileOperationService>(),
      ),
    );
  }
}
