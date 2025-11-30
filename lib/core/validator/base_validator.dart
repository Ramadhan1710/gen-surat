import 'package:gen_surat/core/exception/form_validation_result.dart';

abstract class BaseValidator<T> {
  FormValidationResult validate(T value); 
}