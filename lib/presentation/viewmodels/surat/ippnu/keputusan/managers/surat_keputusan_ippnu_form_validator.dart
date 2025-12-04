import 'dart:io';
import '../../../../../../core/exception/form_validation_result.dart';
import '../../../../../../core/validator/required_validator.dart';
import '../enum/surat_keputusan_ippnu_form_step.dart';
import 'surat_keputusan_ippnu_form_data_manager.dart';

class SuratKeputusanIppnuFormValidator {
  FormValidationResult validateLembagaStep({
    required String periodeRapta,
    required String jenisLembaga,
    required String namaLembaga,
    required String periodeKepengurusan,
    required String ketuaTerpilih,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Periode RAPTA').validate(periodeRapta),
      RequiredValidator('Jenis Lembaga').validate(jenisLembaga),
      RequiredValidator('Nama Lembaga').validate(namaLembaga),
      RequiredValidator('Periode Kepengurusan').validate(periodeKepengurusan),
      RequiredValidator('Ketua Terpilih').validate(ketuaTerpilih),
    ]);
  }

  FormValidationResult validateSuratStep({
    required String nomorSurat,
    required String tanggalHijriah,
    required String tanggalMasehi,
    required String waktuPenetapan,
    required String namaKetua,
    required String namaSekretaris,
    required String namaAnggota,
    required String namaWilayah,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Nomor Surat').validate(nomorSurat),
      RequiredValidator('Tanggal Hijriah').validate(tanggalHijriah),
      RequiredValidator('Tanggal Masehi').validate(tanggalMasehi),
      RequiredValidator('Waktu Penetapan').validate(waktuPenetapan),
      RequiredValidator('Nama Ketua Sidang').validate(namaKetua),
      RequiredValidator('Nama Sekretaris Sidang').validate(namaSekretaris),
      RequiredValidator('Nama Anggota Sidang').validate(namaAnggota),
      RequiredValidator('Nama Wilayah').validate(namaWilayah),
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
      return const FormValidationResult.error('Tanda tangan ketua belum diunggah');
    }
    if (ttdSekretaris == null) {
      return const FormValidationResult.error('Tanda tangan sekretaris belum diunggah');
    }
    if (ttdAnggota == null) {
      return const FormValidationResult.error('Tanda tangan anggota belum diunggah');
    }
    return const FormValidationResult.success();
  }

  FormValidationResult validateStep(
    SuratKeputusanIppnuFormStep step,
    SuratKeputusanIppnuFormDataManager formData, {
    File? ttdKetua,
    File? ttdSekretaris,
    File? ttdAnggota,
  }) {
    switch (step) {
      case SuratKeputusanIppnuFormStep.lembaga:
        return validateLembagaStep(
          periodeRapta: formData.periodeRapta,
          jenisLembaga: formData.jenisLembaga,
          namaLembaga: formData.namaLembaga,
          periodeKepengurusan: formData.periodeKepengurusan,
          ketuaTerpilih: formData.ketuaTerpilih,
        );
      case SuratKeputusanIppnuFormStep.surat:
        return validateSuratStep(
          nomorSurat: formData.nomorSurat,
          tanggalHijriah: formData.tanggalHijriah,
          tanggalMasehi: formData.tanggalMasehi,
          waktuPenetapan: formData.waktuPenetapan,
          namaKetua: formData.namaKetua,
          namaSekretaris: formData.namaSekretaris,
          namaAnggota: formData.namaAnggota,
          namaWilayah: formData.namaWilayah,
        );
      case SuratKeputusanIppnuFormStep.timFormatur:
        return validationTimFormatur(timFormatur: formData.timFormatur);
      case SuratKeputusanIppnuFormStep.tandaTangan:
        return validateTandaTanganStep(
          ttdKetua: ttdKetua,
          ttdSekretaris: ttdSekretaris,
          ttdAnggota: ttdAnggota,
        );
    }
  }
}
