import 'dart:io';

import 'package:open_filex/open_filex.dart';
import 'package:share_plus/share_plus.dart';

import '../utils/format_utils.dart';

class FileOperationService {
  Future<FileOperationResult> openFile(File? file) async {
    if (file == null) {
      return FileOperationResult.error('Belum ada file yang di-generate');
    }
    
    try {
      final result = await OpenFilex.open(file.path);
      return _mapOpenFileResult(result);
    } catch (e) {
      return FileOperationResult.error('Gagal membuka file: ${e.toString()}');
    }
  }
  
  Future<FileOperationResult> shareFile(File? file, {String? text}) async {
    if (file == null) {
      return FileOperationResult.error('Belum ada file yang di-generate');
    }
    
    try {
      final result = await Share.shareXFiles([XFile(file.path)], text: text);
      if (result.status == ShareResultStatus.success) {
        return FileOperationResult.success('File berhasil dibagikan');
      }
      return FileOperationResult.error('Gagal membagikan file');
    } catch (e) {
      return FileOperationResult.error('Gagal membagikan file: ${e.toString()}');
    }
  }
  
  String getFileName(File? file) {
    if (file == null) return '';
    return file.path.split('/').last;
  }
  
  String getFileSize(File? file) {
    if (file == null || !file.existsSync()) return 'Unknown';
    return FormatUtils.formatBytes(file.lengthSync());
  }
  
  String getFilePath(File? file) {
    if (file == null) return '';
    return file.path;
  }
  
  FileOperationResult _mapOpenFileResult(OpenResult result) {
    switch (result.type) {
      case ResultType.done:
        return FileOperationResult.success('File berhasil dibuka');
      case ResultType.noAppToOpen:
        return FileOperationResult.error('Tidak ada aplikasi untuk membuka file ini');
      case ResultType.fileNotFound:
        return FileOperationResult.error('File tidak ditemukan');
      case ResultType.permissionDenied:
        return FileOperationResult.error('Izin ditolak untuk membuka file');
      default:
        return FileOperationResult.error('Gagal membuka file');
    }
  }
}

class FileOperationResult {
  final bool isSuccess;
  final String message;
  
  const FileOperationResult.success(this.message) : isSuccess = true;
  const FileOperationResult.error(this.message) : isSuccess = false;
}