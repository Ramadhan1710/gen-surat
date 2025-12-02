import 'package:dio/dio.dart';
import 'package:gen_surat/core/constants/app_constants.dart';
import 'package:gen_surat/core/services/logging_interceptor.dart';

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
    // Menggunakan Custom Logging Interceptor untuk logging yang lebih detail
    dio.interceptors.add(CustomLoggingInterceptor());
  }
}
