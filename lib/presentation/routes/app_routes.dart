import 'package:gen_surat/presentation/pages/document_menu/document_menu_page.dart';
import 'package:gen_surat/presentation/pages/generated_files_page.dart';
import 'package:gen_surat/presentation/pages/home/home_page.dart';
import 'package:gen_surat/presentation/pages/surat/surat_permohonan_pengesahan_ipnu_page.dart';
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
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // IPNU Document Routes
    GetPage(
      name: RouteNames.suratPermohonanPengesahanIpnu,
      page: () => const SuratPermohonanPengesahanIpnuPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // IPPNU Document Routes - akan ditambahkan ketika page sudah dibuat
    // GetPage(
    //   name: RouteNames.suratPermohonanPengesahanIppnu,
    //   page: () => const SuratPermohonanPengesahanIppnuPage(),
    //   transition: Transition.rightToLeft,
    // ),
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
  static Future<T?>? offAllNamed<T>(
    String routeName, {
    dynamic arguments,
  }) {
    return Get.offAllNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  /// Helper method untuk kembali ke route sebelumnya
  static void back<T>({T? result}) {
    Get.back<T>(result: result);
  }

  /// Helper method untuk navigasi dengan mengganti route saat ini
  static Future<T?>? offNamed<T>(
    String routeName, {
    dynamic arguments,
  }) {
    return Get.offNamed<T>(
      routeName,
      arguments: arguments,
    );
  }
}
