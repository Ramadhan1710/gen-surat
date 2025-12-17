/// Kelas untuk menyimpan semua nama route dalam aplikasi
/// Menggunakan static const untuk performa yang lebih baik
class RouteNames {
  // Private constructor untuk mencegah instansiasi
  RouteNames._();

  // Auth Routes
  static const String login = '/login';
  static const String profile = '/profile';

  // Splash & Home Routes
  static const String splash = '/splash';
  static const String home = '/';
  static const String documentMenu = '/document-menu';
  static const String generatedFiles = '/generated-files';

  // IPNU Document Routes
  static const String suratPermohonanPengesahanIpnu =
      '/surat-permohonan-pengesahan-ipnu';
  static const String suratKeputusanIpnu = '/surat-keputusan-ipnu';
  static const String beritaAcaraPemilihanKetuaIpnu =
      '/berita-acara-pemilihan-ketua-ipnu';
  static const String susunanPengurusIpnu = '/susunan-pengurus-ipnu';
  static const String curriculumVitaeIpnu = '/curriculum-vitae-ipnu';
  static const String kartuIdentitasIpnu = '/kartu-identitas-ipnu';
  static const String sertifikatKaderisasiIpnu = '/sertifikat-kaderisasi-ipnu';
  static const String beritaAcaraRapatFormaturIpnu =
      '/berita-acara-rapat-formatur-ipnu';
  static const String suratKeteranganIpnu = '/surat-keterangan-ipnu';
  static const String suratTugasIpnu = '/surat-tugas-ipnu';
  static const String proposalIpnu = '/proposal-ipnu';

  // IPPNU Document Routes
  static const String suratPermohonanPengesahanIppnu =
      '/surat-permohonan-pengesahan-ippnu';
  static const String suratKeputusanIppnu = '/surat-keputusan-ippnu';
  static const String beritaAcaraPemilihanKetuaIppnu =
      '/berita-acara-pemilihan-ketua-ippnu';
  static const String susunanPengurusIppnu = '/susunan-pengurus-ippnu';
  static const String curriculumVitaeIppnu = '/curriculum-vitae-ippnu';
  static const String kartuIdentitasIppnu = '/kartu-identitas-ippnu';
  static const String sertifikatKaderisasiIppnu =
      '/sertifikat-kaderisasi-ippnu';
  static const String beritaAcaraFormaturPembentukanPengurusHarianIppnu =
      '/berita-acara-formatur-pembentukan-pengurus-harian-ippnu';
  static const String beritaAcaraPenyusunanPengurusIppnu =
      '/berita-acara-penyusunan-pengurus-ippnu';
  static const String suratKeteranganIppnu = '/surat-keterangan-ippnu';
  static const String suratTugasIppnu = '/surat-tugas-ippnu';
  static const String proposalIppnu = '/proposal-ippnu';

  // Other Routes
  static const String quran = '/quran';
  static const String gdrive = '/gdrive';

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
