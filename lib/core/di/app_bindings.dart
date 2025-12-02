import 'package:gen_surat/presentation/viewmodels/theme/theme_viewmodel.dart';
import 'package:get/get.dart';

/// App-level bindings untuk dependencies yang perlu persistent
/// ViewModels spesifik page dipindahkan ke route bindings untuk auto-dispose
class AppBindings extends Bindings {
  @override
  void dependencies() {
    // ========== Persistent ViewModels ==========
    // Theme ViewModel - perlu persist karena digunakan di seluruh app
    Get.put(ThemeViewModel(), permanent: true);

    // ========== Page-specific ViewModels ==========
    // DIHAPUS dari sini, dipindahkan ke route bindings:
    // - GeneratedFilesViewModel -> generated_files_binding.dart
    // - SuratPermohonanPengesahanIpnuViewmodel -> surat_permohonan_pengesahan_ipnu_binding.dart
    // - SuratKeputusanIpnuViewmodel -> surat_keputusan_ipnu_binding.dart
    // - BeritaAcaraPemilihanKetuaIpnuViewmodel -> berita_acara_pemilihan_ketua_ipnu_binding.dart
    // - SusunanPengurusIpnuViewmodel -> susunan_pengurus_ipnu_binding.dart
    //
    // Keuntungan:
    // 1. ViewModel auto-dispose saat page ditutup (no memory leak)
    // 2. Faster startup (tidak load semua ViewModel di awal)
    // 3. Tidak perlu fenix: true
    // 4. Memory efficient

    // ========== IPPNU ViewModels (Coming Soon) ==========
    // TODO: Add IPPNU viewmodels via route bindings
  }
}
