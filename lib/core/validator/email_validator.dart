import '../constants/error_messages.dart';
import '../constants/validation_constants.dart';
import '../exception/form_validation_result.dart';
import 'base_validator.dart';

class EmailValidator implements BaseValidator<String> {
  const EmailValidator();
  @override
  FormValidationResult validate(String value) {
    if (!RegExp(ValidationConstants.emailPattern).hasMatch(value.trim())) {
      return const FormValidationResult.error(ErrorMessages.invalidEmail);
    }
    return const FormValidationResult.success();
  }
}
