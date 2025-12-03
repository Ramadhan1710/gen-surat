import '../../../../../core/exception/form_validation_result.dart';
import '../../../../../core/validator/required_validator.dart';

/// Form validator untuk Kartu Identitas
/// Handles validation untuk form kartu identitas
class KartuIdentitasIpnuFormValidator {
  /// Validasi informasi lembaga
  FormValidationResult validateLembagaInfo({
    required String jenisLembaga,
    required String namaLembaga,
    required String periodeKepengurusan,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Tingkatan lembaga').validate(jenisLembaga),
      RequiredValidator('Nama desa/madrasah').validate(namaLembaga),
      RequiredValidator('Periode kepengurusan').validate(periodeKepengurusan),
    ]);
  }

  /// Validasi file kartu identitas
  FormValidationResult validateKartuIdentitasFiles({
    required String? kartuKetuaPath,
    required String? kartuSekretarisPath,
    required String? kartuBendaharaPath,
  }) {
    if (kartuKetuaPath == null) {
      return const FormValidationResult.error(
        'Foto kartu identitas ketua harus diunggah',
      );
    }
    if (kartuSekretarisPath == null) {
      return const FormValidationResult.error(
        'Foto kartu identitas sekretaris harus diunggah',
      );
    }
    if (kartuBendaharaPath == null) {
      return const FormValidationResult.error(
        'Foto kartu identitas bendahara harus diunggah',
      );
    }
    return const FormValidationResult.success();
  }
}
