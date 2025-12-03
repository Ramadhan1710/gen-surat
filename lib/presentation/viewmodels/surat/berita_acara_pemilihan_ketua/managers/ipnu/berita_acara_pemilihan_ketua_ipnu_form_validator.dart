import 'dart:io';

import '../../../../../../core/exception/form_validation_result.dart';
import '../../../../../../core/validator/required_validator.dart';
import '../../enum/berita_acara_pemilihan_ketua_form_step.dart';
import 'berita_acara_pemilihan_ketua_ipnu_form_data_manager.dart';

class BeritaAcaraPemilihanKetuaIpnuFormValidator {
  FormValidationResult validateLembagaStep({
    required String jenisLembaga,
    required String namaLembaga,
    required String periodeKepengurusan,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Tingkatan Organisasi').validate(jenisLembaga),
      RequiredValidator('Nama Desa/Sekolah').validate(namaLembaga),
      RequiredValidator('Periode kepengurusan').validate(periodeKepengurusan),
    ]);
  }

  FormValidationResult validatePemilihanKetuaStep({
    required String tanggal,
    required String bulan,
    required String tahun,
    required String waktuPemilihanKetua,
    required String tempatPemilihanKetua,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Tanggal').validate(tanggal),
      RequiredValidator('Bulan').validate(bulan),
      RequiredValidator('Tahun').validate(tahun),
      RequiredValidator('Waktu pemilihan ketua').validate(waktuPemilihanKetua),
      RequiredValidator(
        'Tempat pemilihan ketua',
      ).validate(tempatPemilihanKetua),
    ]);
  }

  FormValidationResult validatePencalonanKetuaStep({
    required List<PencalonanKetuaData> pencalonanKetua,
    required String totalSuaraSahPencalonanKetua,
    required String totalSuaraTidakSahPencalonanKetua,
  }) {
    if (pencalonanKetua.isEmpty) {
      return const FormValidationResult.error(
        'Data pencalonan ketua harus diisi minimal satu calon',
      );
    }

    for (var i = 0; i < pencalonanKetua.length; i++) {
      final calon = pencalonanKetua[i];
      final nama = calon.namaController.text.trim();
      final alamat = calon.alamatController.text.trim();
      final jmlSuaraSah = calon.jmlSuaraSahController.text.trim();

      final namaValidation = RequiredValidator(
        'Nama calon no. ${i + 1}',
      ).validate(nama);
      if (!namaValidation.isValid) {
        return namaValidation;
      }

      final alamatValidation = RequiredValidator(
        'Alamat calon no. ${i + 1}',
      ).validate(alamat);
      if (!alamatValidation.isValid) {
        return alamatValidation;
      }

      final jmlSuaraSahValidation = RequiredValidator(
        'Jumlah suara sah calon no. ${i + 1}',
      ).validate(jmlSuaraSah);
      if (!jmlSuaraSahValidation.isValid) {
        return jmlSuaraSahValidation;
      }

      final jmlSuaraSahInt = int.tryParse(jmlSuaraSah);
      if (jmlSuaraSahInt == null || jmlSuaraSahInt < 0) {
        return FormValidationResult.error(
          'Jumlah suara sah calon no. ${i + 1} harus berupa angka valid',
        );
      }
    }

    // total suara sah is computed from individual candidate votes,
    // only require total suara tidak sah (manual input)
    return FormValidationResult.combine([
      RequiredValidator(
        'Total suara tidak sah pencalonan ketua',
      ).validate(totalSuaraTidakSahPencalonanKetua),
    ]);
  }

  FormValidationResult validatePemilihanStep({
    required List<PemilihanKetuaData> pemilihanKetua,
    required String totalSuaraSahPemilihanKetua,
    required String totalSuaraTidakSahPemilihanKetua,
  }) {
    if (pemilihanKetua.isEmpty) {
      return const FormValidationResult.error(
        'Data pemilihan ketua harus diisi minimal satu calon',
      );
    }

    for (var i = 0; i < pemilihanKetua.length; i++) {
      final calon = pemilihanKetua[i];
      final nama = calon.namaController.text.trim();
      final alamat = calon.alamatController.text.trim();
      final jmlSuaraSah = calon.jmlSuaraSahController.text.trim();

      final namaValidation = RequiredValidator(
        'Nama calon no. ${i + 1}',
      ).validate(nama);
      if (!namaValidation.isValid) {
        return namaValidation;
      }

      final alamatValidation = RequiredValidator(
        'Alamat calon no. ${i + 1}',
      ).validate(alamat);
      if (!alamatValidation.isValid) {
        return alamatValidation;
      }

      final jmlSuaraSahValidation = RequiredValidator(
        'Jumlah suara sah calon no. ${i + 1}',
      ).validate(jmlSuaraSah);
      if (!jmlSuaraSahValidation.isValid) {
        return jmlSuaraSahValidation;
      }

      final jmlSuaraSahInt = int.tryParse(jmlSuaraSah);
      if (jmlSuaraSahInt == null || jmlSuaraSahInt < 0) {
        return FormValidationResult.error(
          'Jumlah suara sah calon no. ${i + 1} harus berupa angka valid',
        );
      }
    }

    // total suara sah is computed from individual candidate votes,
    // only require total suara tidak sah (manual input)
    return FormValidationResult.combine([
      RequiredValidator(
        'Total suara tidak sah pemilihan ketua',
      ).validate(totalSuaraTidakSahPemilihanKetua),
    ]);
  }

  FormValidationResult validateKetuaTerpilihStep({
    required String namaKetuaTerpilih,
    required String alamatKetuaTerpilih,
    required String totalSuaraKetuaTerpilih,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Nama ketua terpilih').validate(namaKetuaTerpilih),
      RequiredValidator('Alamat ketua terpilih').validate(alamatKetuaTerpilih),
      RequiredValidator(
        'Total suara ketua terpilih',
      ).validate(totalSuaraKetuaTerpilih),
    ]);
  }

  FormValidationResult validateFormaturStep({
    required List<FormaturData> formatur,
  }) {
    if (formatur.isEmpty) {
      return const FormValidationResult.error(
        'Tim formatur harus diisi minimal satu anggota',
      );
    }

    for (var i = 0; i < formatur.length; i++) {
      final anggota = formatur[i];
      final nama = anggota.namaController.text.trim();
      final alamat = anggota.alamatController.text.trim();
      final daerahPengkaderan = anggota.daerahPengkaderanController.text.trim();

      final namaValidation = RequiredValidator(
        'Nama anggota formatur no. ${i + 1}',
      ).validate(nama);
      if (!namaValidation.isValid) {
        return namaValidation;
      }

      final alamatValidation = RequiredValidator(
        'Alamat anggota formatur no. ${i + 1}',
      ).validate(alamat);
      if (!alamatValidation.isValid) {
        return alamatValidation;
      }

      final daerahValidation = RequiredValidator(
        'Daerah pengkaderan anggota formatur no. ${i + 1}',
      ).validate(daerahPengkaderan);
      if (!daerahValidation.isValid) {
        return daerahValidation;
      }
    }

    return const FormValidationResult.success();
  }

  FormValidationResult validatePenetapanStep({
    required String namaWilayah,
    required String tanggalHijriah,
    required String tanggalMasehi,
    required String waktuPenetapan,
    required String namaKetua,
    required String namaSekretaris,
    required String namaAnggota,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Nama wilayah').validate(namaWilayah),
      RequiredValidator('Tanggal hijriah').validate(tanggalHijriah),
      RequiredValidator('Tanggal masehi').validate(tanggalMasehi),
      RequiredValidator('Waktu penetapan').validate(waktuPenetapan),
      RequiredValidator('Nama ketua').validate(namaKetua),
      RequiredValidator('Nama sekretaris').validate(namaSekretaris),
      RequiredValidator('Nama anggota').validate(namaAnggota),
    ]);
  }

  FormValidationResult validateTandaTanganStep({
    required File? ttdKetua,
    required File? ttdSekretaris,
    required File? ttdAnggota,
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
    if (ttdAnggota == null) {
      return const FormValidationResult.error(
        'Tanda tangan anggota belum dipilih',
      );
    }
    return const FormValidationResult.success();
  }

  FormValidationResult validateStep(
    BeritaAcaraPemilihanKetuaFormStep step,
    BeritaAcaraPemilihanKetuaIpnuFormDataManager formData, {
    File? ttdKetua,
    File? ttdSekretaris,
    File? ttdAnggota,
  }) {
    switch (step) {
      case BeritaAcaraPemilihanKetuaFormStep.lembaga:
        return validateLembagaStep(
          jenisLembaga: formData.jenisLembaga,
          namaLembaga: formData.namaLembaga,
          periodeKepengurusan: formData.periodeKepengurusan,
        );
      case BeritaAcaraPemilihanKetuaFormStep.pemilihanKetua:
        return validatePemilihanKetuaStep(
          tanggal: formData.tanggal,
          bulan: formData.bulan,
          tahun: formData.tahun,
          waktuPemilihanKetua: formData.waktuPemilihanKetua,
          tempatPemilihanKetua: formData.tempatPemilihanKetua,
        );
      case BeritaAcaraPemilihanKetuaFormStep.pencalonanKetua:
        return validatePencalonanKetuaStep(
          pencalonanKetua: formData.pencalonanKetua,
          totalSuaraSahPencalonanKetua:
              formData.totalSuaraSahPencalonanKetuaController.text.trim(),
          totalSuaraTidakSahPencalonanKetua:
              formData.totalSuaraTidakSahPencalonanKetuaController.text.trim(),
        );
      case BeritaAcaraPemilihanKetuaFormStep.pemilihan:
        return validatePemilihanStep(
          pemilihanKetua: formData.pemilihanKetua,
          totalSuaraSahPemilihanKetua:
              formData.totalSuaraSahPemilihanKetuaController.text.trim(),
          totalSuaraTidakSahPemilihanKetua:
              formData.totalSuaraTidakSahPemilihanKetuaController.text.trim(),
        );
      case BeritaAcaraPemilihanKetuaFormStep.ketuaTerpilih:
        return validateKetuaTerpilihStep(
          namaKetuaTerpilih: formData.namaKetuaTerpilih,
          alamatKetuaTerpilih: formData.alamatKetuaTerpilih,
          totalSuaraKetuaTerpilih:
              formData.totalSuaraKetuaTerpilihController.text.trim(),
        );
      case BeritaAcaraPemilihanKetuaFormStep.formatur:
        return validateFormaturStep(formatur: formData.formatur);
      case BeritaAcaraPemilihanKetuaFormStep.penetapan:
        return validatePenetapanStep(
          namaWilayah: formData.namaWilayah,
          tanggalHijriah: formData.tanggalHijriah,
          tanggalMasehi: formData.tanggalMasehi,
          waktuPenetapan: formData.waktuPenetapan,
          namaKetua: formData.namaKetua,
          namaSekretaris: formData.namaSekretaris,
          namaAnggota: formData.namaAnggota,
        );
      case BeritaAcaraPemilihanKetuaFormStep.tandaTangan:
        return validateTandaTanganStep(
          ttdKetua: ttdKetua,
          ttdSekretaris: ttdSekretaris,
          ttdAnggota: ttdAnggota,
        );
    }
  }
}
