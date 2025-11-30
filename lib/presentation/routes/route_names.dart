/// Kelas untuk menyimpan semua nama route dalam aplikasi
/// Menggunakan static const untuk performa yang lebih baik
class RouteNames {
  // Private constructor untuk mencegah instansiasi
  RouteNames._();

  // Home Routes
  static const String home = '/';
  static const String documentMenu = '/document-menu';
  static const String generatedFiles = '/generated-files';

  // IPNU Document Routes
  static const String suratPermohonanPengesahanIpnu =
      '/surat-permohonan-pengesahan-ipnu';
  static const String suratKeputusanIpnu = '/surat-keputusan-ipnu';
  static const String suratKeteranganIpnu = '/surat-keterangan-ipnu';
  static const String suratTugasIpnu = '/surat-tugas-ipnu';
  static const String proposalIpnu = '/proposal-ipnu';

  // IPPNU Document Routes
  static const String suratPermohonanPengesahanIppnu =
      '/surat-permohonan-pengesahan-ippnu';
  static const String suratKeteranganIppnu = '/surat-keterangan-ippnu';
  static const String suratTugasIppnu = '/surat-tugas-ippnu';
  static const String proposalIppnu = '/proposal-ippnu';

  /// Mendapatkan semua route names sebagai list
  /// Berguna untuk debugging atau validasi
  static List<String> get allRoutes => [
        home,
        documentMenu,
        generatedFiles,
        suratPermohonanPengesahanIpnu,
        suratKeteranganIpnu,
        suratTugasIpnu,
        proposalIpnu,
        suratPermohonanPengesahanIppnu,
        suratKeteranganIppnu,
        suratTugasIppnu,
        proposalIppnu,
      ];
}
