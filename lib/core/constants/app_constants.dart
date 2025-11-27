abstract class AppConstants {
  const AppConstants._();

  static const String baseUrlApi = "https://generator-surat-api.fly.dev/api/surat";
  static const String baseStoragePath = "/storage/emulated/0/Download/";
  
  // Storage paths per lembaga
  static String baseStorageIpnuPath = "${baseStoragePath}IPNU/";
  static String baseStorageIppnuPath = "${baseStoragePath}IPPNU/";
  // Tambahkan path lembaga lain di sini
}
