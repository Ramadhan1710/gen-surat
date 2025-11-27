import 'dart:io';

class FileHelper {
  // Membuat folder jika belum ada
  static Future<Directory> ensureDirectory(String path) async {
    final dir = Directory(path);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  // Membuat file path
  static String buildFilePath(String directory, String fileName){
    return '$directory/$fileName';
  }

  // Ekstrak nama file dari header Content-Disposition
  static String extractFileName(String? contentDisposition) {
    if (contentDisposition == null) return 'file_default.pdf';

    final regex = RegExp(r'filename="?([^"]+)"?');
    final match = regex.firstMatch(contentDisposition);

    return match != null ? match.group(1)! : 'file_default.pdf';
  }

  static Future<String> getUniqueFileName(String directory, String fileName) async {
    final dir = await ensureDirectory(directory);
    String baseName = fileName;
    String extension = '';
    int dotIndex = fileName.lastIndexOf('.');

    if (dotIndex != -1) {
      baseName = fileName.substring(0, dotIndex);
      extension = fileName.substring(dotIndex);
    }

    String uniqueFileName = fileName; 
    int counter = 1;

    while (await File('${dir.path}/$uniqueFileName').exists()) {
      uniqueFileName = '${baseName}_$counter$extension';
      counter++;
    }

    return uniqueFileName;
  }
}
