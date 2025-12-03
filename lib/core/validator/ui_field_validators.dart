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
}
