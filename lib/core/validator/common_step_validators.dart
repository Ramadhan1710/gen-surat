import 'dart:io';

import 'package:gen_surat/core/exception/form_validation_result.dart';
import 'package:gen_surat/core/validator/email_validator.dart';
import 'package:gen_surat/core/validator/required_validator.dart';

class CommonStepValidators {
  CommonStepValidators._();

  static const _emailValidator = EmailValidator();

  static FormValidationResult validateLembagaFields({
    required String jenisLembaga,
    required String namaLembaga,
    String? alamat,
    String? nomorTelepon,
    String? email,
  }) {
    final validations = <FormValidationResult>[
      RequiredValidator('Tingkatan Pimpinan').validate(jenisLembaga),
      RequiredValidator('Nama desa/sekolah').validate(namaLembaga),
      if (nomorTelepon != null)
        RequiredValidator('Nomor telepon').validate(nomorTelepon),
      if (email != null) ...[
        RequiredValidator('Email').validate(email),
        _emailValidator.validate(email),
      ],
      if (alamat != null) RequiredValidator('Alamat lembaga').validate(alamat),
    ];

    return FormValidationResult.combine(validations);
  }

  static FormValidationResult validateTandaTangan2({
    required File? ttdKetua,
    required File? ttdSekretaris,
  }) {
    if (ttdKetua == null) {
      return const FormValidationResult.error(
        'Tanda tangan ketua belum dipilih',
      );
    }
    if (ttdSekretaris == null) {
      return const FormValidationResult.error(
        'Tanda tangan sekretaris belum dipilih',
      );
    }
    return const FormValidationResult.success();
  }

  static FormValidationResult validateTandaTangan3({
    required File? ttdKetua,
    required File? ttdSekretaris,
    required File? ttdAnggota,
  }) {
    final result2 = validateTandaTangan2(
      ttdKetua: ttdKetua,
      ttdSekretaris: ttdSekretaris,
    );

    if (!result2.isValid) {
      return result2;
    }

    if (ttdAnggota == null) {
      return const FormValidationResult.error(
        'Tanda tangan anggota belum dipilih',
      );
    }

    return const FormValidationResult.success();
  }

  static FormValidationResult validateTanggalLengkap({
    required String tanggalHijriah,
    required String tanggalMasehi,
    String? waktu,
  }) {
    final validations = <FormValidationResult>[
      RequiredValidator('Tanggal hijriah').validate(tanggalHijriah),
      RequiredValidator('Tanggal masehi').validate(tanggalMasehi),
    ];

    if (waktu != null) {
      validations.add(RequiredValidator('Waktu').validate(waktu));
    }

    return FormValidationResult.combine(validations);
  }

  static FormValidationResult validatePengurusData({
    required String nama,
    required String alamat,
    required String role,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Nama $role').validate(nama),
      RequiredValidator('Alamat $role').validate(alamat),
    ]);
  }

  static FormValidationResult validateKontakData({
    required String nomorHp,
    required String email,
    required String role,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Nomor HP $role').validate(nomorHp),
      RequiredValidator('Email $role').validate(email),
      _emailValidator.validate(email),
    ]);
  }
}
