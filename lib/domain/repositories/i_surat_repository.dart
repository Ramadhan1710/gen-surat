import 'dart:io';

import 'package:dio/dio.dart';

/// Generic Repository interface untuk semua jenis surat
/// Mengikuti prinsip Dependency Inversion & Open/Closed Principle (SOLID)
/// 
/// Type parameter [T] adalah tipe data model yang akan dikirim
abstract class ISuratRepository<T> {
  /// Generate surat dengan tipe apapun
  /// 
  /// [data] - Data model yang akan dikirim ke API
  /// [lembaga] - Nama lembaga (ipnu, ippnu, dll)
  /// [typeSurat] - Tipe surat (surat-permohonan-pengesahan, surat-tugas, dll)
  /// [endpoint] - API endpoint untuk generate surat
  /// [toMultipartMap] - Function untuk convert model ke multipart map
  /// [customSavePath] - Custom path untuk menyimpan file (optional)
  /// [onReceiveProgress] - Callback untuk track download progress (optional)
  /// [cancelToken] - Token untuk cancel request (optional)
  /// 
  /// Returns: File yang sudah di-generate dan disimpan
  /// Throws: Exception jika terjadi error
  Future<File> generateSurat({
    required T data,
    required String lembaga,
    required String typeSurat,
    required String endpoint,
    required Future<Map<String, dynamic>> Function(T) toMultipartMap,
    String? customSavePath,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  });
}
