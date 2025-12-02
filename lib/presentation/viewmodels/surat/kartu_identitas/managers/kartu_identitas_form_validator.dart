import 'package:gen_surat/core/validator/field_validator.dart';

class KartuIdentitasFormValidator {
  KartuIdentitasFormValidator();

  String? validateJenisLembaga(String? value) {
    return FieldValidator.validateRequired(value, 'Jenis lembaga');
  }

  String? validateNamaLembaga(String? value) {
    return FieldValidator.validateRequired(value, 'Nama lembaga');
  }

  String? validatePeriodeKepengurusan(String? value) {
    return FieldValidator.validateRequired(value, 'Periode kepengurusan');
  }
}
