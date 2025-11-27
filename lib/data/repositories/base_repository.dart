import 'dart:io';

import 'package:dio/dio.dart';

/// Base Repository untuk handle common operations dan error handling
abstract class BaseRepository {
  /// Handle error dari DioException
  Exception handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException('Connection timeout. Please try again.');
      
      case DioExceptionType.badResponse:
        return ServerException(
          _getErrorMessage(error.response),
          statusCode: error.response?.statusCode,
        );
      
      case DioExceptionType.cancel:
        return CancelledException('Request was cancelled');
      
      case DioExceptionType.connectionError:
        return NetworkException('No internet connection');
      
      default:
        return UnknownException('An unexpected error occurred');
    }
  }

  /// Extract error message dari response
  String _getErrorMessage(Response? response) {
    if (response == null) return 'Unknown error occurred';
    
    try {
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return data['message'] ?? data['error'] ?? 'Server error occurred';
      }
      return response.statusMessage ?? 'Server error occurred';
    } catch (e) {
      return 'Server error occurred';
    }
  }

  /// Execute dengan error handling
  Future<T> executeWithErrorHandling<T>(
    Future<T> Function() operation,
  ) async {
    try {
      return await operation();
    } on DioException catch (e) {
      throw handleDioError(e);
    } on FileSystemException catch (e) {
      throw StorageException('File system error: ${e.message}');
    } catch (e) {
      throw UnknownException('An unexpected error occurred: $e');
    }
  }
}

/// Custom Exceptions
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException(this.message, {this.statusCode});

  @override
  String toString() => 'ServerException: $message (Status: $statusCode)';
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

class TimeoutException implements Exception {
  final String message;

  TimeoutException(this.message);

  @override
  String toString() => 'TimeoutException: $message';
}

class CancelledException implements Exception {
  final String message;

  CancelledException(this.message);

  @override
  String toString() => 'CancelledException: $message';
}

class StorageException implements Exception {
  final String message;

  StorageException(this.message);

  @override
  String toString() => 'StorageException: $message';
}

class UnknownException implements Exception {
  final String message;

  UnknownException(this.message);

  @override
  String toString() => 'UnknownException: $message';
}
