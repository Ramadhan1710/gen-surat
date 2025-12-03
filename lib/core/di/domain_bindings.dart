import 'package:get/get.dart';

import '../../domain/repositories/i_surat_repository.dart';
import '../../domain/usecases/ipnu/generate_berita_acara_pemilihan_ketua_ipnu_usecase.dart';
import '../../domain/usecases/ipnu/generate_berita_acara_rapat_formatur_usecase.dart';
import '../../domain/usecases/ipnu/generate_curriculum_vitae_usecase.dart';
import '../../domain/usecases/ipnu/generate_kartu_identitas_usecase.dart';
import '../../domain/usecases/ipnu/generate_sertifikat_kaderisasi_usecase.dart';
import '../../domain/usecases/ipnu/generate_surat_keputusan_ipnu_usecase.dart';
import '../../domain/usecases/ipnu/generate_surat_permohonan_pengesahan_ipnu_usecase.dart';
import '../../domain/usecases/ipnu/generate_susunan_pengurus_ipnu_usecase.dart';

class DomainBindings extends Bindings {
  @override
  void dependencies() {
    // ========== IPNU UseCases ==========
    // Use Cases harus permanent agar tidak di-dispose
    // ViewModel dari route bindings membutuhkan dependencies ini
    Get.put(
      GenerateSuratPermohonanPengesahanIpnuUseCase(
        Get.find<ISuratRepository>(),
      ),
      permanent: true, // Persistent, tidak di-dispose
    );

    Get.put(
      GenerateSuratKeputusanIpnuUseCase(Get.find<ISuratRepository>()),
      permanent: true, // Persistent, tidak di-dispose
    );

    Get.put(
      GenerateBeritaAcaraPemilihanKetuaIpnuUseCase(
        Get.find<ISuratRepository>(),
      ),
      permanent: true, // Persistent, tidak di-dispose
    );

    Get.put(
      GenerateSusunanPengurusIpnuUseCase(Get.find<ISuratRepository>()),
      permanent: true, // Persistent, tidak di-dispose
    );

    Get.put(
      GenerateCurriculumVitaeUseCase(Get.find<ISuratRepository>()),
      permanent: true, // Persistent, tidak di-dispose
    );

    Get.put(
      GenerateBeritaAcaraRapatFormaturUseCase(Get.find<ISuratRepository>()),
      permanent: true, // Persistent, tidak di-dispose
    );

    Get.put(
      GenerateSertifikatKaderisasiUseCase(Get.find<ISuratRepository>()),
      permanent: true, // Persistent, tidak di-dispose
    );

    Get.put(
      GenerateKartuIdentitasUseCase(Get.find<ISuratRepository>()),
      permanent: true, // Persistent, tidak di-dispose
    );

    // ========== IPPNU UseCases (Coming Soon) ==========
    // TODO: Add IPPNU usecases here

    // Tambah usecase baru untuk jenis surat lain di sini
    // Semua menggunakan ISuratRepository yang sama
  }
}
