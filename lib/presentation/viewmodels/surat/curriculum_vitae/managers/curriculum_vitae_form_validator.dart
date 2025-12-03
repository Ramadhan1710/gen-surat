import 'package:gen_surat/core/validator/field_validator.dart';

class CurriculumVitaeFormValidator {
  // ========== Validasi Informasi Lembaga ==========
  String? validateJenisLembaga(String? value) {
    return FieldValidator.validateRequired(value, 'Jenis lembaga');
  }

  String? validateNamaLembaga(String? value) {
    return FieldValidator.validateRequired(value, 'Nama lembaga');
  }

  String? validatePeriodeKepengurusan(String? value) {
    return FieldValidator.validateRequired(value, 'Periode kepengurusan');
  }

  // ========== Validasi Data Ketua ==========
  String? validateNamaKetua(String? value) {
    return FieldValidator.validateRequired(value, 'Nama ketua');
  }

  String? validateTtlKetua(String? value) {
    return FieldValidator.validateRequired(value, 'Tempat tanggal lahir ketua');
  }

  String? validateNiaKetua(String? value) {
    return FieldValidator.validateRequired(value, 'NIA ketua');
  }

  String? validateAlamatKetua(String? value) {
    return FieldValidator.validateRequired(value, 'Alamat ketua');
  }

  String? validateMottoKetua(String? value) {
    return FieldValidator.validateRequired(value, 'Motto ketua');
  }

  String? validateNomorHpKetua(String? value) {
    return FieldValidator.validateRequired(value, 'Nomor HP ketua');
  }

  String? validateEmailKetua(String? value) {
    final requiredCheck = FieldValidator.validateRequired(value, 'Email ketua');
    if (requiredCheck != null) return requiredCheck;

    return FieldValidator.validateEmail(value!);
  }

  String? validateNoOrganizationKetua(String? value) {
    return FieldValidator.validateRequired(
      value,
      'Status pengalaman organisasi ketua',
    );
  }

  // ========== Validasi Data Sekretaris ==========
  String? validateNamaSekretaris(String? value) {
    return FieldValidator.validateRequired(value, 'Nama sekretaris');
  }

  String? validateTtlSekretaris(String? value) {
    return FieldValidator.validateRequired(
      value,
      'Tempat tanggal lahir sekretaris',
    );
  }

  String? validateNiaSekretaris(String? value) {
    return FieldValidator.validateRequired(value, 'NIA sekretaris');
  }

  String? validateAlamatSekretaris(String? value) {
    return FieldValidator.validateRequired(value, 'Alamat sekretaris');
  }

  String? validateMottoSekretaris(String? value) {
    return FieldValidator.validateRequired(value, 'Motto sekretaris');
  }

  String? validateNomorHpSekretaris(String? value) {
    return FieldValidator.validateRequired(value, 'Nomor HP sekretaris');
  }

  String? validateEmailSekretaris(String? value) {
    final requiredCheck = FieldValidator.validateRequired(
      value,
      'Email sekretaris',
    );
    if (requiredCheck != null) return requiredCheck;

    return FieldValidator.validateEmail(value!);
  }

  String? validateNoOrganizationSekretaris(String? value) {
    return FieldValidator.validateRequired(
      value,
      'Status pengalaman organisasi sekretaris',
    );
  }

  // ========== Validasi Data Bendahara ==========
  String? validateNamaBendahara(String? value) {
    return FieldValidator.validateRequired(value, 'Nama bendahara');
  }

  String? validateTtlBendahara(String? value) {
    return FieldValidator.validateRequired(
      value,
      'Tempat tanggal lahir bendahara',
    );
  }

  String? validateNiaBendahara(String? value) {
    return FieldValidator.validateRequired(value, 'NIA bendahara');
  }

  String? validateAlamatBendahara(String? value) {
    return FieldValidator.validateRequired(value, 'Alamat bendahara');
  }

  String? validateMottoBendahara(String? value) {
    return FieldValidator.validateRequired(value, 'Motto bendahara');
  }

  String? validateNomorHpBendahara(String? value) {
    return FieldValidator.validateRequired(value, 'Nomor HP bendahara');
  }

  String? validateEmailBendahara(String? value) {
    final requiredCheck = FieldValidator.validateRequired(
      value,
      'Email bendahara',
    );
    if (requiredCheck != null) return requiredCheck;

    return FieldValidator.validateEmail(value!);
  }

  String? validateNoOrganizationBendahara(String? value) {
    return FieldValidator.validateRequired(
      value,
      'Status pengalaman organisasi bendahara',
    );
  }

  // ========== Validasi Dynamic Fields ==========
  String? validateNamaOrganisasi(String? value) {
    return FieldValidator.validateRequired(value, 'Nama organisasi');
  }

  String? validateTingkatPendidikan(String? value) {
    return FieldValidator.validateRequired(value, 'Tingkat pendidikan');
  }

  String? validateNamaPendidikan(String? value) {
    return FieldValidator.validateRequired(value, 'Nama institusi pendidikan');
  }
}
