import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gen_surat/core/helper/file_helper.dart';
import 'package:gen_surat/data/models/base_api_request_model.dart';

abstract class BaseRemoteDatasource {
  final Dio dio;

  BaseRemoteDatasource(this.dio);

  /// Download file dengan multipart/form-data request
  /// Returns: File yang sudah di-download

  Future<File> multipartFileUsingDownload<T>(
    String endpoint,
    String savePath,
    BaseApiRequestModel<T> model,
    Future<Map<String, dynamic>> Function(T) toJsonData, {
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    // Convert model to JSON (await because it's async now)
    final jsonData = await model.toJson(toJsonData);

    Response response;
    int retries = 0;
    const maxRetries = 3;

    // Retry logic for handshake errors
    while (retries < maxRetries) {
      try {
        // 1. POST multipart
        response = await dio.post(
          endpoint,
          data: FormData.fromMap(jsonData),
          options: Options(responseType: ResponseType.bytes),
          onSendProgress: onReceiveProgress,
          cancelToken: cancelToken,
        );

        // 2. Baca file name dari header
        final fileName = FileHelper.extractFileName(
          response.headers.value('content-disposition'),
        );

        final uniqueFileName = await FileHelper.getUniqueFileName(
          savePath,
          fileName,
        );
        final filePath = FileHelper.buildFilePath(savePath, uniqueFileName);

        // 3. Simpan file
        final file = File(filePath);
        await file.writeAsBytes(response.data);

        return file;
      } on DioException catch (e) {
        if (e.type == DioExceptionType.unknown &&
            e.error.toString().contains('HandshakeException')) {
          retries++;
          log('Handshake failed, retry $retries/$maxRetries');

          if (retries >= maxRetries) {
            log('Max retries reached, throwing error');
            rethrow;
          }

          // Wait before retry with exponential backoff
          await Future.delayed(Duration(seconds: retries * 2));
          continue;
        }

        // For other errors, rethrow immediately
        rethrow;
      }
    }

    throw Exception('Failed to download file after $maxRetries retries');
  }

  /// GET request generic
  Future<Response<Map<String, dynamic>>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await dio.get<Map<String, dynamic>>(
      endpoint,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// POST request generic
  Future<Response<Map<String, dynamic>>> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await dio.post<Map<String, dynamic>>(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// PUT request generic
  Future<Response<Map<String, dynamic>>> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await dio.put<Map<String, dynamic>>(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// DELETE request generic
  Future<Response<Map<String, dynamic>>> delete(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await dio.delete<Map<String, dynamic>>(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
}
