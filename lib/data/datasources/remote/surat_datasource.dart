import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/constants/app_constants.dart';
import '../../models/base_api_request_model.dart';
import 'base_remote_datasource.dart';

/// Interface untuk semua operasi surat
abstract class ISuratDatasource {
  /// Generate surat apapun dengan endpoint dan data yang diberikan
  Future<File> generateSurat<T>({
    required String endpoint,
    required BaseApiRequestModel<T> model,
    required Future<Map<String, dynamic>> Function(T) toMultipartMap,
    String? customSavePath,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  });
}

/// Implementasi datasource untuk semua jenis surat
/// Menggunakan generic untuk support berbagai tipe model
class SuratDatasource extends BaseRemoteDatasource implements ISuratDatasource {
  SuratDatasource(super.dio);

  @override
  Future<File> generateSurat<T>({
    required String endpoint,
    required BaseApiRequestModel<T> model,
    required Future<Map<String, dynamic>> Function(T) toMultipartMap,
    String? customSavePath,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    // Gunakan custom path atau default berdasarkan lembaga
    final String savePath = customSavePath ?? 
        _getDefaultSavePath(model.lembaga, model.typeSurat);

    return await multipartFileUsingDownload<T>(
      endpoint,
      savePath,
      model,
      toMultipartMap,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  /// Generate default save path berdasarkan lembaga dan tipe surat
  String _getDefaultSavePath(String lembaga, String typeSurat) {
    final basePath = lembaga.toLowerCase() == 'ipnu' 
        ? AppConstants.baseStorageIpnuPath
        : "${AppConstants.baseStoragePath}${lembaga.toUpperCase()}/";
    
    // Capitalize tipe surat untuk nama folder yang rapi
    final formattedType = typeSurat.split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
    
    return "$basePath$formattedType";
  }
}
