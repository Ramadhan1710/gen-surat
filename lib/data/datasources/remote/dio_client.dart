import 'package:dio/dio.dart';
import 'package:gen_surat/core/constants/app_constants.dart';

class DioClient {
  final Dio dio;

  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: AppConstants.baseUrlApi,
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
          sendTimeout: const Duration(seconds: 60),
          headers: {"Accept": "*/*"},
        ),
      ) {
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
        error: true,
      ),
    );
  }
}
