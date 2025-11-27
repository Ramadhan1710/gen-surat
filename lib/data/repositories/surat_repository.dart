import 'dart:io';

import 'package:dio/dio.dart';

import '../../domain/repositories/i_surat_repository.dart';
import '../datasources/remote/surat_datasource.dart';
import '../models/base_api_request_model.dart';
import 'base_repository.dart';

/// Generic Repository Implementation untuk semua jenis surat
/// 
/// Mengikuti prinsip Dependency Inversion & Single Responsibility (SOLID)
/// Repository bertanggung jawab untuk coordinate antara datasource dan domain layer
/// 
/// Type parameter [T] adalah tipe data model yang akan dikirim
class SuratRepository<T> extends BaseRepository
    implements ISuratRepository<T> {
  final ISuratDatasource datasource;

  SuratRepository(this.datasource);

  @override
  Future<File> generateSurat({
    required T data,
    required String lembaga,
    required String typeSurat,
    required String endpoint,
    required Future<Map<String, dynamic>> Function(T) toMultipartMap,
    String? customSavePath,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    return await executeWithErrorHandling(() async {
      // Wrap data dengan BaseApiRequestModel
      final requestModel = BaseApiRequestModel<T>(
        lembaga: lembaga,
        typeSurat: typeSurat,
        data: data,
      );

      // Call datasource untuk generate surat
      return await datasource.generateSurat<T>(
        endpoint: endpoint,
        model: requestModel,
        toMultipartMap: toMultipartMap,
        customSavePath: customSavePath,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );
    });
  }
}
