import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> ensureStoragePermission() async {
    if (await Permission.storage.status.isGranted) {
      return true;
    }

    if (await Permission.manageExternalStorage.status.isGranted) {
      return true;
    }

    final status = await Permission.storage.request();
    final manageStatus = await Permission.manageExternalStorage.request();

    return status.isGranted || manageStatus.isGranted;
  }
}
