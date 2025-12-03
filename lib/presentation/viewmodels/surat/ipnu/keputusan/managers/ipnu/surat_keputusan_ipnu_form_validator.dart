import 'dart:io';

import 'package:gen_surat/presentation/viewmodels/surat/ipnu/keputusan/enum/surat_keputusan_form_step.dart';

import '../../../../../../../core/exception/form_validation_result.dart';
import '../../../../../../../core/validator/required_validator.dart';

import 'surat_keputusan_ipnu_form_data_manager.dart';

class SuratKeputusanIpnuFormValidator {
  FormValidationResult validateLembagaStep({
    required String jenisLembaga,
    required String namaLembaga,
    required String periodeKepengurusan,
    required String ketuaTerpilih,
    required String periodeRapta,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Tingkatan lembaga').validate(jenisLembaga),
      RequiredValidator('Nama desa/sekolah').validate(namaLembaga),
      RequiredValidator('Periode kepengurusan').validate(periodeKepengurusan),
      RequiredValidator('Ketua terpilih').validate(ketuaTerpilih),
      RequiredValidator('Periode rapat').validate(periodeRapta),
    ]);
  }

  FormValidationResult validateSuratStep({
    required String nomorSurat,
    required String tanggalHijriah,
    required String tanggalMasehi,
    required String waktuPenetapan,
    required String namaWilayah,
    required String namaKetua,
    required String namaSekretaris,
    required String namaAnggota,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Nomor surat').validate(nomorSurat),
      RequiredValidator('Tanggal hijriah').validate(tanggalHijriah),
      RequiredValidator('Tanggal masehi').validate(tanggalMasehi),
      RequiredValidator('Waktu penetapan').validate(waktuPenetapan),
      RequiredValidator('Nama wilayah').validate(namaWilayah),
      RequiredValidator('Nama ketua').validate(namaKetua),
      RequiredValidator('Nama sekretaris').validate(namaSekretaris),
      RequiredValidator('Nama anggota').validate(namaAnggota),
    ]);
  }

  FormValidationResult validationTimFormatur({
    required List<TimFormaturData> timFormatur,
  }) {
    if (timFormatur.isEmpty) {
      return const FormValidationResult.error(
        'Tim formatur harus diisi minimal satu anggota',
      );
    }
    for (var i = 0; i < timFormatur.length; i++) {
      final anggota = timFormatur[i];
      final nama = anggota.namaController.text.trim();
      final daerahPengkaderan = anggota.daerahPengkaderanController.text.trim();

      final namaValidation = RequiredValidator(
        'Nama anggota no. ${i + 1}',
      ).validate(nama);
      if (!namaValidation.isValid) {
        return namaValidation;
      }

      final daerahValidation = RequiredValidator(
        'Daerah pengkaderan anggota no. ${i + 1}',
      ).validate(daerahPengkaderan);
      if (!daerahValidation.isValid) {
        return daerahValidation;
      }
    }
    return const FormValidationResult.success();
  }

  FormValidationResult validateTandaTanganStep({
    required File? ttdKetua,
    required File? ttdSekretaris,
    required File? ttdAnggota,
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
    if (ttdAnggota == null) {
      return const FormValidationResult.error(
        'Tanda tangan anggota belum diunggah',
      );
    }
    return const FormValidationResult.success();
  }

  FormValidationResult validateStep(
    SuratKeputusanFormStep step,
    SuratKeputusanIpnuFormDataManager formData, {
    File? ttdKetua,
    File? ttdSekretaris,
    File? ttdAnggota,
  }) {
    switch (step) {
      case SuratKeputusanFormStep.lembaga:
        return validateLembagaStep(
          jenisLembaga: formData.jenisLembaga,
          namaLembaga: formData.namaLembaga,
          periodeKepengurusan: formData.periodeKepengurusan,
          ketuaTerpilih: formData.ketuaTerpilih,
          periodeRapta: formData.periodeRapta,
        );
      case SuratKeputusanFormStep.surat:
        return validateSuratStep(
          nomorSurat: formData.nomorSurat,
          tanggalHijriah: formData.tanggalHijriah,
          tanggalMasehi: formData.tanggalMasehi,
          namaAnggota: formData.namaAnggota,
          namaKetua: formData.namaKetua,
          namaSekretaris: formData.namaSekretaris,
          namaWilayah: formData.namaWilayah,
          waktuPenetapan: formData.waktuPenetapan,
        );
      case SuratKeputusanFormStep.timFormatur:
        return validationTimFormatur(timFormatur: formData.timFormatur);
      case SuratKeputusanFormStep.tandaTangan:
        return validateTandaTanganStep(
          ttdKetua: ttdKetua,
          ttdSekretaris: ttdSekretaris,
          ttdAnggota: ttdAnggota,
        );
    }
  }
}
