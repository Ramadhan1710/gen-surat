import 'package:gen_surat/core/exception/form_validation_result.dart';
import 'package:gen_surat/core/validator/email_validator.dart';
import 'package:gen_surat/core/validator/phone_validator.dart';
import 'package:gen_surat/core/validator/required_validator.dart';

/// Helper class untuk validasi form
class FieldValidator {
  FieldValidator._();

  /// Validasi field required
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    return null;
  }

  /// Validasi email
  static String? validateEmail(String value) {
    final validator = const EmailValidator();
    final result = validator.validate(value.trim());
    
    if (!result.isValid) {
      return result.errorMessage;
    }
    return null;
  }

  /// Validasi nomor telepon
  static String? validatePhoneNumber(String value) {
    final validator = const PhoneValidator();
    final result = validator.validate(value.trim());
    
    if (!result.isValid) {
      return result.errorMessage;
    }
    return null;
  }
}
