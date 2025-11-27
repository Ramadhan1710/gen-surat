import 'package:get/get.dart';

import '../../domain/repositories/i_surat_repository.dart';
import '../../domain/usecases/ipnu/generate_surat_permohonan_pengesahan_ipnu_usecase.dart';

class DomainBindings extends Bindings {
  @override
  void dependencies() {
    // ========== IPNU UseCases ==========
    Get.lazyPut(
      () => GenerateSuratPermohonanPengesahanIpnuUseCase(
        Get.find<ISuratRepository>(),
      ),
      fenix: true,
    );

    // ========== IPPNU UseCases (Coming Soon) ==========
    // TODO: Add IPPNU usecases here
    
    // Tambah usecase baru untuk jenis surat lain di sini
    // Semua menggunakan ISuratRepository yang sama
  }
}