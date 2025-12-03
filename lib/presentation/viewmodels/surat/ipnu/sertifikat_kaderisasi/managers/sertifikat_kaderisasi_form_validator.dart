import '../../../../../../core/exception/form_validation_result.dart';
import '../../../../../../core/validator/required_validator.dart';

/// Form validator untuk Sertifikat Kaderisasi
/// Handles validation untuk form sertifikat kaderisasi
class SertifikatKaderisasiIpnuFormValidator {
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

  /// Validasi file sertifikat kaderisasi
  FormValidationResult validateSertifikatFiles({
    required String? sertifikatKetuaPath,
    required String? sertifikatSekretarisPath,
    required String? sertifikatBendaharaPath,
  }) {
    if (sertifikatKetuaPath == null) {
      return const FormValidationResult.error(
        'Foto sertifikat kaderisasi ketua harus diunggah',
      );
    }
    if (sertifikatSekretarisPath == null) {
      return const FormValidationResult.error(
        'Foto sertifikat kaderisasi sekretaris harus diunggah',
      );
    }
    if (sertifikatBendaharaPath == null) {
      return const FormValidationResult.error(
        'Foto sertifikat kaderisasi bendahara harus diunggah',
      );
    }
    return const FormValidationResult.success();
  }
}
