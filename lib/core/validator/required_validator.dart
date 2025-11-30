import 'package:gen_surat/core/exception/form_validation_result.dart';
import 'package:gen_surat/core/validator/base_validator.dart';

import '../constants/error_messages.dart';

class RequiredValidator implements BaseValidator<String> {
  final String fieldName;

  const RequiredValidator(this.fieldName);

  @override
  FormValidationResult validate(String value) {
    if (value.isEmpty) {
      return FormValidationResult.error(ErrorMessages.fieldRequired(fieldName));
    }
    return const FormValidationResult.success();
  }
}
