import 'dart:io';

import '../../../../../../core/exception/form_validation_result.dart';
import '../../../../../../core/validator/common_step_validators.dart';
import '../../../../../../core/validator/required_validator.dart';
import '../enum/surat_permohonan_pengesahan_form_step.dart';
import 'surat_permohonan_pengesahan_ipnu_form_data_manager.dart';

/// Form validator untuk Surat Permohonan Pengesahan IPNU
/// Handles step-level validation untuk multi-step form
class SuratPermohonanPengesahanIpnuFormValidator {
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
    required String tanggalRapat,
    required String tanggalHijriah,
    required String tanggalMasehi,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Nomor surat').validate(nomorSurat),
      RequiredValidator('Tanggal rapat').validate(tanggalRapat),
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
    required String jenisLembagaInduk,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Periode kepengurusan').validate(periode),
      RequiredValidator('Nama ketua terpilih').validate(namaKetua),
      RequiredValidator('Nama sekretaris terpilih').validate(namaSekretaris),
      RequiredValidator('Jenis lembaga induk').validate(jenisLembagaInduk),
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
    SuratPermohonanPengesahanFormStep step,
    SuratPermohonanPengesahanIpnuFormDataManager formData, {
    File? ttdKetua,
    File? ttdSekretaris,
  }) {
    switch (step) {
      case SuratPermohonanPengesahanFormStep.lembaga:
        return validateLembagaStep(
          jenisLembaga: formData.jenisLembaga,
          namaLembaga: formData.namaLembaga,
          nomorTelepon: formData.nomorTelepon,
          email: formData.email,
          alamat: formData.alamat,
        );
      case SuratPermohonanPengesahanFormStep.surat:
        return validateSuratStep(
          nomorSurat: formData.nomorSurat,
          tanggalRapat: formData.tanggalRapat,
          tanggalHijriah: formData.tanggalHijriah,
          tanggalMasehi: formData.tanggalMasehi,
        );
      case SuratPermohonanPengesahanFormStep.kepengurusan:
        return validateKepengurusanStep(
          periode: formData.periodeKepengurusan,
          namaKetua: formData.namaKetua,
          namaSekretaris: formData.namaSekretaris,
          jenisLembagaInduk: formData.jenisLembagaInduk,
        );
      case SuratPermohonanPengesahanFormStep.tandaTangan:
        return validateTandaTanganStep(
          ttdKetua: ttdKetua,
          ttdSekretaris: ttdSekretaris,
        );
    }
  }
}
