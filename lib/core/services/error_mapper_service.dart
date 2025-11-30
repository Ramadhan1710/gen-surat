import 'package:dio/dio.dart';

import '../constants/error_messages.dart';

class ErrorMapperService {
  static String mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ErrorMessages.connectionTimeout;
      case DioExceptionType.receiveTimeout:
        return ErrorMessages.serverError;
      case DioExceptionType.unknown:
        return _mapUnknownError(e);
      case DioExceptionType.badResponse:
        return 'Server error (${e.response?.statusCode}): ${e.response?.statusMessage ?? "Unknown"}';
      default:
        return 'Gagal generate surat: ${e.message ?? e.toString()}';
    }
  }
  
  static String _mapUnknownError(DioException e) {
    final errorString = e.error.toString();
    if (errorString.contains('HandshakeException')) {
      return 'Gagal koneksi ke server (SSL Error). Pastikan koneksi internet stabil.';
    } else if (errorString.contains('SocketException')) {
      return 'Tidak dapat terhubung ke server. Periksa koneksi internet Anda.';
    }
    return 'Terjadi kesalahan koneksi: ${e.message ?? "Unknown error"}';
  }
}