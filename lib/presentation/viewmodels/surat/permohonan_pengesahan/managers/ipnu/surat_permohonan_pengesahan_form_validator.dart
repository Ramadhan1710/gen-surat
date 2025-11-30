import 'dart:io';

import '../../../../../../core/exception/form_validation_result.dart';
import '../../../../../../core/validator/email_validator.dart';
import '../../../../../../core/validator/phone_validator.dart';
import '../../../../../../core/validator/required_validator.dart';
import '../../enum/surat_permohonan_pengesahan_form_step.dart';
import 'surat_permohonan_pengesahan_ipnu_form_data_manager.dart';

class SuratPermohonanPengesahanIpnuFormValidator {
  final _emailValidator = const EmailValidator();
  final _phoneValidator = const PhoneValidator();

  FormValidationResult validateLembagaStep({
    required String jenisLembaga,
    required String namaLembaga,
    required String nomorTelepon,
    required String email,
    required String alamat,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Jenis lembaga').validate(jenisLembaga),
      RequiredValidator('Nama lembaga').validate(namaLembaga),
      RequiredValidator('Nomor telepon').validate(nomorTelepon),
      _phoneValidator.validate(nomorTelepon),
      RequiredValidator('Email').validate(email),
      _emailValidator.validate(email),
      RequiredValidator('Alamat lembaga').validate(alamat),
    ]);
  }

  FormValidationResult validateSuratStep({
    required String nomorSurat,
    required String tanggalRapat,
    required String tanggalHijriah,
    required String tanggalMasehi,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Nomor surat').validate(nomorSurat),
      RequiredValidator('Tanggal rapat').validate(tanggalRapat),
      RequiredValidator('Tanggal hijriah').validate(tanggalHijriah),
      RequiredValidator('Tanggal masehi').validate(tanggalMasehi),
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
      return const FormValidationResult.error('Tanda tangan ketua belum dipilih');
    }
    if (ttdSekretaris == null) {
      return const FormValidationResult.error('Tanda tangan sekretaris belum dipilih');
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