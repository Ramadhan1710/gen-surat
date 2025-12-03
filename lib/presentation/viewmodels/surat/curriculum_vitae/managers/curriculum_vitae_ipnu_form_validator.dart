import '../../../../../core/exception/form_validation_result.dart';
import '../../../../../core/validator/email_validator.dart';
import '../../../../../core/validator/required_validator.dart';
import '../enum/curriculum_vitae_ipnu_form_step.dart';
import 'curriculum_vitae_ipnu_form_data_manager.dart';

/// Form validator untuk Curriculum Vitae
/// Handles step-level validation untuk multi-step form
class CurriculumVitaeIpnuFormValidator {
  static const _emailValidator = EmailValidator();

  /// Validasi Step 1: Informasi Lembaga
  FormValidationResult validateLembagaStep({
    required String jenisLembaga,
    required String namaLembaga,
    required String periodeKepengurusan,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Tingkatan lembaga').validate(jenisLembaga),
      RequiredValidator('Nama desa/sekolah').validate(namaLembaga),
      RequiredValidator('Periode kepengurusan').validate(periodeKepengurusan),
    ]);
  }

  /// Validasi Step 2: Data Ketua
  FormValidationResult validateDataKetuaStep({
    required String nama,
    required String ttl,
    required String nia,
    required String alamat,
    required String motto,
    required String nomorHp,
    required String email,
    required String? fotoPath,
  }) {
    final validations = [
      RequiredValidator('Nama ketua').validate(nama),
      RequiredValidator('Tempat tanggal lahir ketua').validate(ttl),
      RequiredValidator('NIA ketua').validate(nia),
      RequiredValidator('Alamat ketua').validate(alamat),
      RequiredValidator('Motto ketua').validate(motto),
      RequiredValidator('Nomor HP ketua').validate(nomorHp),
      RequiredValidator('Email ketua').validate(email),
    ];

    if (email.isNotEmpty) {
      validations.add(_emailValidator.validate(email));
    }

    final fieldValidation = FormValidationResult.combine(validations);
    if (!fieldValidation.isValid) {
      return fieldValidation;
    }

    if (fotoPath == null) {
      return const FormValidationResult.error('Foto ketua harus dipilih');
    }

    return const FormValidationResult.success();
  }

  /// Validasi Step 3: Organisasi & Pendidikan Ketua
  FormValidationResult validateOrganisasiPendidikanKetuaStep({
    required bool hasNoOrganization,
    required List<Map<String, dynamic>> organisasiList,
    required List<Map<String, dynamic>> pendidikanList,
  }) {
    if (!hasNoOrganization && organisasiList.isEmpty) {
      return const FormValidationResult.error(
        'Minimal harus ada 1 pengalaman organisasi ketua atau centang "Tidak ada pengalaman organisasi"',
      );
    }

    if (pendidikanList.isEmpty) {
      return const FormValidationResult.error(
        'Minimal harus ada 1 data pendidikan ketua',
      );
    }

    return const FormValidationResult.success();
  }

  /// Validasi Step 4: Data Sekretaris
  FormValidationResult validateDataSekretarisStep({
    required String nama,
    required String ttl,
    required String nia,
    required String alamat,
    required String motto,
    required String nomorHp,
    required String email,
    required String? fotoPath,
  }) {
    final validations = [
      RequiredValidator('Nama sekretaris').validate(nama),
      RequiredValidator('Tempat tanggal lahir sekretaris').validate(ttl),
      RequiredValidator('NIA sekretaris').validate(nia),
      RequiredValidator('Alamat sekretaris').validate(alamat),
      RequiredValidator('Motto sekretaris').validate(motto),
      RequiredValidator('Nomor HP sekretaris').validate(nomorHp),
      RequiredValidator('Email sekretaris').validate(email),
    ];

    if (email.isNotEmpty) {
      validations.add(_emailValidator.validate(email));
    }

    final fieldValidation = FormValidationResult.combine(validations);
    if (!fieldValidation.isValid) {
      return fieldValidation;
    }

    if (fotoPath == null) {
      return const FormValidationResult.error('Foto sekretaris harus dipilih');
    }

    return const FormValidationResult.success();
  }

  /// Validasi Step 5: Organisasi & Pendidikan Sekretaris
  FormValidationResult validateOrganisasiPendidikanSekretarisStep({
    required bool hasNoOrganization,
    required List<Map<String, dynamic>> organisasiList,
    required List<Map<String, dynamic>> pendidikanList,
  }) {
    if (!hasNoOrganization && organisasiList.isEmpty) {
      return const FormValidationResult.error(
        'Minimal harus ada 1 pengalaman organisasi sekretaris atau centang "Tidak ada pengalaman organisasi"',
      );
    }

    if (pendidikanList.isEmpty) {
      return const FormValidationResult.error(
        'Minimal harus ada 1 data pendidikan sekretaris',
      );
    }

    return const FormValidationResult.success();
  }

  /// Validasi Step 6: Data Bendahara
  FormValidationResult validateDataBendaharaStep({
    required String nama,
    required String ttl,
    required String nia,
    required String alamat,
    required String motto,
    required String nomorHp,
    required String email,
    required String? fotoPath,
  }) {
    final validations = [
      RequiredValidator('Nama bendahara').validate(nama),
      RequiredValidator('Tempat tanggal lahir bendahara').validate(ttl),
      RequiredValidator('NIA bendahara').validate(nia),
      RequiredValidator('Alamat bendahara').validate(alamat),
      RequiredValidator('Motto bendahara').validate(motto),
      RequiredValidator('Nomor HP bendahara').validate(nomorHp),
      RequiredValidator('Email bendahara').validate(email),
    ];

    if (email.isNotEmpty) {
      validations.add(_emailValidator.validate(email));
    }

    final fieldValidation = FormValidationResult.combine(validations);
    if (!fieldValidation.isValid) {
      return fieldValidation;
    }

    if (fotoPath == null) {
      return const FormValidationResult.error('Foto bendahara harus dipilih');
    }

    return const FormValidationResult.success();
  }

  /// Validasi Step 7: Organisasi & Pendidikan Bendahara
  FormValidationResult validateOrganisasiPendidikanBendaharaStep({
    required bool hasNoOrganization,
    required List<Map<String, dynamic>> organisasiList,
    required List<Map<String, dynamic>> pendidikanList,
  }) {
    if (!hasNoOrganization && organisasiList.isEmpty) {
      return const FormValidationResult.error(
        'Minimal harus ada 1 pengalaman organisasi bendahara atau centang "Tidak ada pengalaman organisasi"',
      );
    }

    if (pendidikanList.isEmpty) {
      return const FormValidationResult.error(
        'Minimal harus ada 1 data pendidikan bendahara',
      );
    }

    return const FormValidationResult.success();
  }

  /// Validasi per step berdasarkan step saat ini
  FormValidationResult validateStep(
    CurriculumVitaeIpnuFormStep step,
    CurriculumVitaeIpnuFormDataManager formData,
  ) {
    switch (step) {
      case CurriculumVitaeIpnuFormStep.lembaga:
        return validateLembagaStep(
          jenisLembaga: formData.jenisLembaga,
          namaLembaga: formData.namaLembaga,
          periodeKepengurusan: formData.periodeKepengurusan,
        );
      case CurriculumVitaeIpnuFormStep.dataKetua:
        return validateDataKetuaStep(
          nama: formData.namaKetuaController.text.trim(),
          ttl: formData.ttlKetuaController.text.trim(),
          nia: formData.niaKetuaController.text.trim(),
          alamat: formData.alamatKetuaController.text.trim(),
          motto: formData.mottoKetuaController.text.trim(),
          nomorHp: formData.nomorHpKetuaController.text.trim(),
          email: formData.emailKetuaController.text.trim(),
          fotoPath: formData.fotoKetuaPath,
        );
      case CurriculumVitaeIpnuFormStep.organisasiPendidikanKetua:
        return validateOrganisasiPendidikanKetuaStep(
          hasNoOrganization: formData.hasNoOrganizationKetua,
          organisasiList: formData.organisasiKetuaList,
          pendidikanList: formData.pendidikanKetuaList,
        );
      case CurriculumVitaeIpnuFormStep.dataSekretaris:
        return validateDataSekretarisStep(
          nama: formData.namaSekretarisController.text.trim(),
          ttl: formData.ttlSekretarisController.text.trim(),
          nia: formData.niaSekretarisController.text.trim(),
          alamat: formData.alamatSekretarisController.text.trim(),
          motto: formData.mottoSekretarisController.text.trim(),
          nomorHp: formData.nomorHpSekretarisController.text.trim(),
          email: formData.emailSekretarisController.text.trim(),
          fotoPath: formData.fotoSekretarisPath,
        );
      case CurriculumVitaeIpnuFormStep.organisasiPendidikanSekretaris:
        return validateOrganisasiPendidikanSekretarisStep(
          hasNoOrganization: formData.hasNoOrganizationSekretaris,
          organisasiList: formData.organisasiSekretarisList,
          pendidikanList: formData.pendidikanSekretarisList,
        );
      case CurriculumVitaeIpnuFormStep.dataBendahara:
        return validateDataBendaharaStep(
          nama: formData.namaBendaharaController.text.trim(),
          ttl: formData.ttlBendaharaController.text.trim(),
          nia: formData.niaBendaharaController.text.trim(),
          alamat: formData.alamatBendaharaController.text.trim(),
          motto: formData.mottoBendaharaController.text.trim(),
          nomorHp: formData.nomorHpBendaharaController.text.trim(),
          email: formData.emailBendaharaController.text.trim(),
          fotoPath: formData.fotoBendaharaPath,
        );
      case CurriculumVitaeIpnuFormStep.organisasiPendidikanBendahara:
        return validateOrganisasiPendidikanBendaharaStep(
          hasNoOrganization: formData.hasNoOrganizationBendahara,
          organisasiList: formData.organisasiBendaharaList,
          pendidikanList: formData.pendidikanBendaharaList,
        );
    }
  }
}
