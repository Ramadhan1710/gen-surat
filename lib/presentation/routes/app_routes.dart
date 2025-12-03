import 'package:gen_surat/presentation/pages/document_menu/document_menu_page.dart';
import 'package:gen_surat/presentation/pages/generated_file/generated_files_page.dart';
import 'package:gen_surat/presentation/pages/home/home_page.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/berita_acara_pemilihan_ketua/berita_acara_pemilihan_ketua_ipnu_page.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/curriculum_vitae/curriculum_vitae_ipnu_page.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/kartu_identitas/kartu_identitas_ipnu_page.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/sertifikat_kaderisasi/sertifikat_kaderisasi_ipnu_page.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/berita_acara_rapat_formatur/berita_acara_rapat_formatur_ipnu_page.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/keputusan/surat_keputusan_ipnu_page.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/surat_permohonan_pengesahan_ipnu_page.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/susunan_pengurus/susunan_pengurus_ipnu_page.dart';
import 'package:gen_surat/presentation/pages/surat/ippnu/permohonan_pengesahan/surat_permohonan_pengesahan_ippnu_page.dart';
import 'package:gen_surat/presentation/routes/bindings/berita_acara_pemilihan_ketua_ipnu_binding.dart';
import 'package:gen_surat/presentation/routes/bindings/curriculum_vitae_ipnu_binding.dart';
import 'package:gen_surat/presentation/routes/bindings/kartu_identitas_ipnu_binding.dart';
import 'package:gen_surat/presentation/routes/bindings/sertifikat_kaderisasi_ipnu_binding.dart';
import 'package:gen_surat/presentation/routes/bindings/berita_acara_rapat_formatur_ipnu_binding.dart';
import 'package:gen_surat/presentation/routes/bindings/generated_files_binding.dart';
import 'package:gen_surat/presentation/routes/bindings/surat_keputusan_ipnu_binding.dart';
import 'package:gen_surat/presentation/routes/bindings/surat_permohonan_pengesahan_ipnu_binding.dart';
import 'package:gen_surat/presentation/routes/bindings/susunan_pengurus_ipnu_binding.dart';
import 'package:gen_surat/presentation/routes/bindings/surat_permohonan_pengesahan_ippnu_binding.dart';
import 'package:gen_surat/presentation/routes/route_names.dart';
import 'package:get/get.dart';

/// Konfigurasi route untuk aplikasi Gen Surat
/// Menggunakan GetX untuk navigasi yang lebih mudah
class AppRoutes {
  // Private constructor untuk mencegah instansiasi
  AppRoutes._();

  /// Daftar semua route yang tersedia di aplikasi
  /// Setiap route memiliki:
  /// - name: nama route yang unik
  /// - page: widget/page yang akan ditampilkan
  /// - transition: animasi transisi (optional)
  static final routes = [
    // Home Routes
    GetPage(
      name: RouteNames.home,
      page: () => const HomePage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: RouteNames.documentMenu,
      page: () => const DocumentMenuPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: RouteNames.generatedFiles,
      page: () => const GeneratedFilesPage(),
      binding: GeneratedFilesBinding(), // Auto-dispose saat leave
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // IPNU Document Routes
    GetPage(
      name: RouteNames.suratPermohonanPengesahanIpnu,
      page: () => const SuratPermohonanPengesahanIpnuPage(),
      binding:
          SuratPermohonanPengesahanIpnuBinding(), // Auto-dispose saat leave
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: RouteNames.suratKeputusanIpnu,
      page: () => const SuratKeputusanIpnuPage(),
      binding: SuratKeputusanIpnuBinding(), // Auto-dispose saat leave
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: RouteNames.beritaAcaraPemilihanKetuaIpnu,
      page: () => const BeritaAcaraPemilihanKetuaIpnuPage(),
      binding:
          BeritaAcaraPemilihanKetuaIpnuBinding(), // Auto-dispose saat leave
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: RouteNames.susunanPengurusIpnu,
      page: () => const SusunanPengurusIpnuPage(),
      binding: SusunanPengurusIpnuBinding(), // Auto-dispose saat leave
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteNames.curriculumVitaeIpnu,
      page: () => const CurriculumVitaeIpnuPage(),
      binding: CurriculumVitaeIpnuBinding(), // Auto-dispose saat leave
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: RouteNames.kartuIdentitasIpnu,
      page: () => const KartuIdentitasIpnuPage(),
      binding: KartuIdentitasIpnuBinding(), // Auto-dispose saat leave
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: RouteNames.sertifikatKaderisasiIpnu,
      page: () => const SertifikatKaderisasiIpnuPage(),
      binding: SertifikatKaderisasiIpnuBinding(), // Auto-dispose saat leave
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: RouteNames.beritaAcaraRapatFormaturIpnu,
      page: () => const BeritaAcaraRapatFormaturIpnuPage(),
      binding: BeritaAcaraRapatFormaturIpnuBinding(), // Auto-dispose saat leave
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // IPPNU Document Routes
    GetPage(
      name: RouteNames.suratPermohonanPengesahanIppnu,
      page: () => const SuratPermohonanPengesahanIppnuPage(),
      binding: SuratPermohonanPengesahanIppnuBinding(), // Auto-dispose saat leave
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];

  /// Route awal aplikasi
  static const String initialRoute = RouteNames.home;

  /// Helper method untuk navigasi ke route tertentu
  /// Contoh: AppRoutes.toNamed(RouteNames.documentMenu)
  static Future<T?>? toNamed<T>(
    String routeName, {
    dynamic arguments,
    Map<String, String>? parameters,
  }) {
    return Get.toNamed<T>(
      routeName,
      arguments: arguments,
      parameters: parameters,
    );
  }

  /// Helper method untuk navigasi dan menghapus semua route sebelumnya
  /// Berguna untuk logout atau reset navigation stack
  static Future<T?>? offAllNamed<T>(String routeName, {dynamic arguments}) {
    return Get.offAllNamed<T>(routeName, arguments: arguments);
  }

  /// Helper method untuk kembali ke route sebelumnya
  static void back<T>({T? result}) {
    Get.back<T>(result: result);
  }

  /// Helper method untuk navigasi dengan mengganti route saat ini
  static Future<T?>? offNamed<T>(String routeName, {dynamic arguments}) {
    return Get.offNamed<T>(routeName, arguments: arguments);
  }
}
