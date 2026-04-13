import 'package:gen_surat/core/constants/validation_constants.dart';
import 'package:gen_surat/core/constants/error_messages.dart';

/// UI-level field validators untuk TextFormField
/// Digunakan untuk validasi dasar di widget layer
class UiFieldValidators {
  UiFieldValidators._();

  // ========== Basic Validators ==========

  /// Validator untuk field required (wajib diisi)
  ///
  /// Example:
  /// ```dart
  /// TextFormField(
  ///   validator: UiFieldValidators.required('Nama'),
  /// )
  /// ```
  static String? Function(String?) required(String fieldName) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return '$fieldName tidak boleh kosong';
      }
      return null;
    };
  }

  /// Validator untuk email
  /// Validasi required + format email
  static String? Function(String?) email(String fieldName) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return '$fieldName tidak boleh kosong';
      }
      if (!RegExp(ValidationConstants.emailPattern).hasMatch(value.trim())) {
        return ErrorMessages.invalidEmail;
      }
      return null;
    };
  }

  /// Validator opsional untuk email (boleh kosong)
  static String? optionalEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Valid jika kosong
    }
    if (!RegExp(ValidationConstants.emailPattern).hasMatch(value.trim())) {
      return ErrorMessages.invalidEmail;
    }
    return null;
  }

  /// Validator opsional untuk phone (boleh kosong)
  static String? optionalPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Valid jika kosong
    }
    if (!RegExp(ValidationConstants.phonePattern).hasMatch(value.trim())) {
      return ErrorMessages.invalidPhone;
    }
    return null;
  }

  /// Validator untuk angka saja
  static String? Function(String?) numeric(String fieldName) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return '$fieldName tidak boleh kosong';
      }
      if (!RegExp(r'^[0-9]+$').hasMatch(value.trim())) {
        return '$fieldName harus berupa angka';
      }
      return null;
    };
  }

  /// Validator opsional numeric (boleh kosong)
  static String? optionalNumeric(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value.trim())) {
      return 'Harus berupa angka';
    }
    return null;
  }

  // validator name only
  static String? Function(String?) nameOnly(String fieldName) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Nama tidak boleh kosong';
      }
      if (value.length < 3) {
        return 'Nama minimal 3 karakter';
      }
      return null;
    };
  }

  // validator untuk password minimal 8 karakter
  static String? Function(String?) passwordMin6(String fieldName) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Password tidak boleh kosong';
      }
      if (value.length < 6) {
        return 'Password minimal 6 karakter';
      }
      return null;
    };
  }

  // validator untuk konfirmasi password
  static String? Function(String?) confirmPassword(
      String password, String fieldName) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Konfirmasi password tidak boleh kosong';
      }
      if (value != password) {
        return 'Konfirmasi password tidak sesuai';
      }
      return null;
    };
  }
}
