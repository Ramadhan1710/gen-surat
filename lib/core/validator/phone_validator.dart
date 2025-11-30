import 'package:gen_surat/core/exception/form_validation_result.dart';

import '../constants/error_messages.dart';
import '../constants/validation_constants.dart';
import 'base_validator.dart';

class PhoneValidator implements BaseValidator<String> {
  const PhoneValidator();

  @override
  FormValidationResult validate(String value) {
    if (!RegExp(ValidationConstants.phonePattern).hasMatch(value.trim())) {
      return const FormValidationResult.error(ErrorMessages.invalidPhone);
    }
    return const FormValidationResult.success();
  }
}
