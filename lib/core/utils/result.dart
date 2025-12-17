/// Result Pattern untuk handling Success/Failure dengan type safety
sealed class Result<T> {
  const Result();
}

/// Success state dengan data
class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

/// Failure state dengan exception
class Failure<T> extends Result<T> {
  final AppException exception;
  const Failure(this.exception);
}

/// Extension untuk mempermudah handling Result
extension ResultExtension<T> on Result<T> {
  /// Check apakah result adalah Success
  bool get isSuccess => this is Success<T>;

  /// Check apakah result adalah Failure
  bool get isFailure => this is Failure<T>;

  /// Get data jika Success, null jika Failure
  T? get dataOrNull => switch (this) {
    Success(data: final data) => data,
    Failure() => null,
  };

  /// Get exception jika Failure, null jika Success
  AppException? get exceptionOrNull => switch (this) {
    Success() => null,
    Failure(exception: final e) => e,
  };

  /// Handle both cases dengan callback
  R when<R>({
    required R Function(T data) success,
    required R Function(AppException exception) failure,
  }) {
    return switch (this) {
      Success(data: final data) => success(data),
      Failure(exception: final e) => failure(e),
    };
  }

  /// Map data jika Success
  Result<R> map<R>(R Function(T data) transform) {
    return switch (this) {
      Success(data: final data) => Success(transform(data)),
      Failure(exception: final e) => Failure(e),
    };
  }
}

/// Base class untuk semua custom exceptions
class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const AppException({required this.message, this.code, this.originalError});

  @override
  String toString() => 'AppException: $message';
}

/// Exception untuk authentication errors
class AppAuthException extends AppException {
  const AppAuthException({
    required super.message,
    super.code,
    super.originalError,
  });

  /// Factory untuk membuat AppAuthException dari Supabase AuthException
  factory AppAuthException.fromSupabase(dynamic error) {
    if (error is Exception) {
      final message = error.toString();

      // Handle specific Supabase errors
      if (message.contains('Invalid login credentials')) {
        return const AppAuthException(
          message: 'Email atau password salah',
          code: 'invalid_credentials',
        );
      }
      if (message.contains('Email not confirmed')) {
        return const AppAuthException(
          message: 'Email belum diverifikasi',
          code: 'email_not_confirmed',
        );
      }
      if (message.contains('User already registered')) {
        return const AppAuthException(
          message: 'Email sudah terdaftar',
          code: 'user_exists',
        );
      }

      return AppAuthException(message: message, originalError: error);
    }

    return AppAuthException(message: error.toString(), originalError: error);
  }
}

/// Exception untuk network errors
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.code,
    super.originalError,
  });
}

/// Exception untuk validation errors
class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  const ValidationException({
    required super.message,
    super.code,
    super.originalError,
    this.fieldErrors,
  });
}

/// Exception untuk server errors
class ServerException extends AppException {
  const ServerException({
    required super.message,
    super.code,
    super.originalError,
  });
}

/// Exception umum yang tidak diketahui
class UnknownException extends AppException {
  const UnknownException({
    super.message = 'Terjadi kesalahan yang tidak diketahui',
    super.code,
    super.originalError,
  });
}
