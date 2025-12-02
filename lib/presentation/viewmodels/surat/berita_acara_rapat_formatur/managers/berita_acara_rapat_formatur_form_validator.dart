import 'package:gen_surat/core/validator/field_validator.dart';

class BeritaAcaraRapatFormaturFormValidator {
  BeritaAcaraRapatFormaturFormValidator();

  String? validateJenisLembaga(String? value) {
    return FieldValidator.validateRequired(value, 'Jenis lembaga');
  }

  String? validateNamaLembaga(String? value) {
    return FieldValidator.validateRequired(value, 'Nama lembaga');
  }

  String? validateTanggal(String? value) {
    return FieldValidator.validateRequired(value, 'Tanggal rapat');
  }

  String? validateBulan(String? value) {
    return FieldValidator.validateRequired(value, 'Bulan rapat');
  }

  String? validateTahun(String? value) {
    return FieldValidator.validateRequired(value, 'Tahun rapat');
  }

  String? validateTempatRapat(String? value) {
    return FieldValidator.validateRequired(value, 'Tempat rapat');
  }

  String? validatePeriodeRapta(String? value) {
    return FieldValidator.validateRequired(value, 'Periode RAPTA');
  }

  String? validateNamaWilayah(String? value) {
    return FieldValidator.validateRequired(value, 'Nama wilayah');
  }

  String? validateTanggalRapat(String? value) {
    return FieldValidator.validateRequired(value, 'Tanggal penetapan');
  }

  String? validateNamaTimFormatur(String? value) {
    return FieldValidator.validateRequired(value, 'Nama tim formatur');
  }

  String? validateJabatanTimFormatur(String? value) {
    return FieldValidator.validateRequired(value, 'Jabatan tim formatur');
  }
}
