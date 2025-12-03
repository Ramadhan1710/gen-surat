import 'dart:io';

import '../../../../../../core/exception/form_validation_result.dart';
import '../../../../../../core/validator/common_step_validators.dart';
import '../../../../../../core/validator/required_validator.dart';
import '../enum/surat_permohonan_pengesahan_ippnu_form_step.dart';
import 'surat_permohonan_pengesahan_ippnu_form_data_manager.dart';

/// Form validator untuk Surat Permohonan Pengesahan IPPNU
/// Handles step-level validation untuk multi-step form
class SuratPermohonanPengesahanIppnuFormValidator {
  /// Validasi Step 1: Informasi Lembaga
  FormValidationResult validateLembagaStep({
    required String jenisLembaga,
    required String namaLembaga,
    required String nomorTelepon,
    required String email,
    required String alamat,
  }) {
    return CommonStepValidators.validateLembagaFields(
      jenisLembaga: jenisLembaga,
      namaLembaga: namaLembaga,
      alamat: alamat,
      nomorTelepon: nomorTelepon,
      email: email,
    );
  }

  /// Validasi Step 2: Informasi Surat
  FormValidationResult validateSuratStep({
    required String nomorSurat,
    required String tanggalRapta,
    required String nomorRapta,
    required String tempatRapta,
    required String tanggalKeputusan,
    required String tanggalHijriah,
    required String tanggalMasehi,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Nomor surat').validate(nomorSurat),
      RequiredValidator('Tanggal RAPTA').validate(tanggalRapta),
      RequiredValidator('Nomor RAPTA').validate(nomorRapta),
      RequiredValidator('Tempat RAPTA').validate(tempatRapta),
      RequiredValidator('Tanggal keputusan').validate(tanggalKeputusan),
      CommonStepValidators.validateTanggalLengkap(
        tanggalHijriah: tanggalHijriah,
        tanggalMasehi: tanggalMasehi,
      ),
    ]);
  }

  FormValidationResult validateKepengurusanStep({
    required String periode,
    required String namaKetua,
    required String namaSekretaris,
    required String namaLembagaInduk,
    required String tingkatLembaga,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Periode kepengurusan').validate(periode),
      RequiredValidator('Nama ketua terpilih').validate(namaKetua),
      RequiredValidator('Nama sekretaris terpilih').validate(namaSekretaris),
      RequiredValidator('Nama lembaga induk').validate(namaLembagaInduk),
      RequiredValidator('Tingkat lembaga').validate(tingkatLembaga),
    ]);
  }

  FormValidationResult validateTandaTanganStep({
    required File? ttdKetua,
    required File? ttdSekretaris,
  }) {
    if (ttdKetua == null) {
      return const FormValidationResult.error(
        'Tanda tangan ketua belum diunggah',
      );
    }
    if (ttdSekretaris == null) {
      return const FormValidationResult.error(
        'Tanda tangan sekretaris belum diunggah',
      );
    }
    return const FormValidationResult.success();
  }

  FormValidationResult validateStep(
    SuratPermohonanPengesahanIppnuFormStep step,
    SuratPermohonanPengesahanIppnuFormDataManager formData, {
    File? ttdKetua,
    File? ttdSekretaris,
  }) {
    switch (step) {
      case SuratPermohonanPengesahanIppnuFormStep.lembaga:
        return validateLembagaStep(
          jenisLembaga: formData.jenisLembaga,
          namaLembaga: formData.namaLembaga,
          nomorTelepon: formData.telepon,
          email: formData.email,
          alamat: formData.alamat,
        );
      case SuratPermohonanPengesahanIppnuFormStep.surat:
        return validateSuratStep(
          nomorSurat: formData.nomorSurat,
          tanggalRapta: formData.tanggalRapta,
          nomorRapta: formData.nomorRapta,
          tempatRapta: formData.tempatRapta,
          tanggalKeputusan: formData.tanggalKeputusan,
          tanggalHijriah: formData.tanggalHijriah,
          tanggalMasehi: formData.tanggalMasehi,
        );
      case SuratPermohonanPengesahanIppnuFormStep.kepengurusan:
        return validateKepengurusanStep(
          periode: formData.periodeKepengurusan,
          namaKetua: formData.namaKetua,
          namaSekretaris: formData.namaSekretaris,
          namaLembagaInduk: formData.namaLembagaInduk,
          tingkatLembaga: formData.tingkatLembaga,
        );
      case SuratPermohonanPengesahanIppnuFormStep.tandaTangan:
        return validateTandaTanganStep(
          ttdKetua: ttdKetua,
          ttdSekretaris: ttdSekretaris,
        );
    }
  }
}
