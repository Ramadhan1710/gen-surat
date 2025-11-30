import 'dart:io';

import 'package:dio/dio.dart';

import '../../domain/repositories/i_surat_repository.dart';
import '../datasources/remote/surat_datasource.dart';
import '../models/base_api_request_model.dart';
import 'base_repository.dart';

class SuratRepository<T> extends BaseRepository implements ISuratRepository<T> {
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
      final requestModel = BaseApiRequestModel<T>(
        lembaga: lembaga,
        typeSurat: typeSurat,
        data: data,
      );

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
