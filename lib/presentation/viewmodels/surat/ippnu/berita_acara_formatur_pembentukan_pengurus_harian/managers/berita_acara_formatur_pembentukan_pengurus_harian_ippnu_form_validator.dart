import 'package:gen_surat/core/exception/form_validation_result.dart';
import 'package:gen_surat/core/validator/required_validator.dart';

import '../enum/berita_acara_formatur_pembentukan_pengurus_harian_form_step.dart';
import 'berita_acara_formatur_pembentukan_pengurus_harian_ippnu_form_data_manager.dart';

class BeritaAcaraFormaturPembentukanPengurusHarianIppnuFormValidator {
  FormValidationResult validateInformasiLembagaStep({
    required String jenisLembaga,
    required String namaLembaga,
    required String periodeKepengurusan,
    required String tingkatLembaga,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Tingkatan Pimpinan').validate(jenisLembaga),
      RequiredValidator('Nama Desa/Sekolah').validate(namaLembaga),
      RequiredValidator('Periode Kepengurusan').validate(periodeKepengurusan),
      RequiredValidator('Tingkat Lembaga').validate(tingkatLembaga),
    ]);
  }

  FormValidationResult validateDataFormaturStep({
    required List<FormaturData> formatur,
  }) {
    if (formatur.isEmpty) {
      return const FormValidationResult.error(
        'Data formatur harus diisi minimal satu anggota',
      );
    }

    for (var i = 0; i < formatur.length; i++) {
      final item = formatur[i];
      final nama = item.namaController.text.trim();
      final jabatan = item.jabatanController.text.trim();

      final namaValidation = RequiredValidator(
        'Nama formatur no. ${i + 1}',
      ).validate(nama);
      if (!namaValidation.isValid) {
        return namaValidation;
      }

      final jabatanValidation = RequiredValidator(
        'Jabatan formatur no. ${i + 1}',
      ).validate(jabatan);
      if (!jabatanValidation.isValid) {
        return jabatanValidation;
      }

      if (item.ttd == null) {
        return FormValidationResult.error(
          'Tanda tangan formatur no. ${i + 1} belum dipilih',
        );
      }
    }

    return const FormValidationResult.success();
  }

  FormValidationResult validateDataPelindungPembinaStep({
    required List<PelindungData> pelindung,
    required List<PembinaData> pembina,
  }) {
    if (pelindung.isEmpty) {
      return const FormValidationResult.error(
        'Data pelindung harus diisi minimal satu',
      );
    }

    for (var i = 0; i < pelindung.length; i++) {
      final nama = pelindung[i].namaController.text.trim();
      final namaValidation = RequiredValidator(
        'Nama pelindung no. ${i + 1}',
      ).validate(nama);
      if (!namaValidation.isValid) {
        return namaValidation;
      }
    }

    if (pembina.isEmpty) {
      return const FormValidationResult.error(
        'Data pembina harus diisi minimal satu',
      );
    }

    for (var i = 0; i < pembina.length; i++) {
      final nama = pembina[i].namaController.text.trim();
      final namaValidation = RequiredValidator(
        'Nama pembina no. ${i + 1}',
      ).validate(nama);
      if (!namaValidation.isValid) {
        return namaValidation;
      }
    }

    return const FormValidationResult.success();
  }

  FormValidationResult validateDataPengurusIntiStep({
    required String namaKetua,
    required List<WakilKetuaData> wakilKetua,
    required String namaSekretaris,
    required List<WakilSekretarisData> wakilSekretaris,
    required String namaBendahara,
    required String namaWakilBend,
  }) {
    final validations = [
      RequiredValidator('Nama Ketua').validate(namaKetua),
      RequiredValidator('Nama Sekretaris').validate(namaSekretaris),
      RequiredValidator('Nama Bendahara').validate(namaBendahara),
    ];

    final combinedResult = FormValidationResult.combine(validations);
    if (!combinedResult.isValid) {
      return combinedResult;
    }

    if (wakilKetua.isEmpty) {
      return const FormValidationResult.error(
        'Data wakil ketua harus diisi minimal satu',
      );
    }

    for (var i = 0; i < wakilKetua.length; i++) {
      final item = wakilKetua[i];
      final title = item.titleController.text.trim();
      final nama = item.namaController.text.trim();

      final titleValidation = RequiredValidator(
        'Jabatan wakil ketua no. ${i + 1}',
      ).validate(title);
      if (!titleValidation.isValid) {
        return titleValidation;
      }

      final namaValidation = RequiredValidator(
        'Nama wakil ketua no. ${i + 1}',
      ).validate(nama);
      if (!namaValidation.isValid) {
        return namaValidation;
      }
    }

    // Wakil sekretaris optional tapi harus valid jika diisi
    for (var i = 0; i < wakilSekretaris.length; i++) {
      final item = wakilSekretaris[i];
      final title = item.titleController.text.trim();
      final nama = item.namaController.text.trim();

      if (title.isNotEmpty && nama.isEmpty) {
        return FormValidationResult.error(
          'Nama wakil sekretaris no. ${i + 1} tidak boleh kosong jika jabatan diisi',
        );
      }
      if (nama.isNotEmpty && title.isEmpty) {
        return FormValidationResult.error(
          'Jabatan wakil sekretaris no. ${i + 1} tidak boleh kosong jika nama diisi',
        );
      }
    }

    return const FormValidationResult.success();
  }

  FormValidationResult validatePenetapanStep({
    required String tanggalPenyusunan,
    required String tempatPenyusunan,
    required String namaWilayah,
    required String tanggalHijriah,
    required String tanggalMasehi,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Tanggal Penyusunan').validate(tanggalPenyusunan),
      RequiredValidator('Tempat Penyusunan').validate(tempatPenyusunan),
      RequiredValidator('Nama Wilayah').validate(namaWilayah),
      RequiredValidator('Tanggal Hijriah').validate(tanggalHijriah),
      RequiredValidator('Tanggal Masehi').validate(tanggalMasehi),
    ]);
  }

  FormValidationResult validateStep(
    BeritaAcaraFormaturPembentukanPengurusHarianFormStep step,
    BeritaAcaraFormaturPembentukanPengurusHarianIppnuFormDataManager formData,
  ) {
    switch (step) {
      case BeritaAcaraFormaturPembentukanPengurusHarianFormStep
          .informasiLembaga:
        return validateInformasiLembagaStep(
          jenisLembaga: formData.jenisLembaga,
          namaLembaga: formData.namaLembaga,
          periodeKepengurusan: formData.periodeKepengurusan,
          tingkatLembaga: formData.tingkatLembaga,
        );
      case BeritaAcaraFormaturPembentukanPengurusHarianFormStep.dataFormatur:
        return validateDataFormaturStep(formatur: formData.formatur);
      case BeritaAcaraFormaturPembentukanPengurusHarianFormStep
          .dataPelindungPembina:
        return validateDataPelindungPembinaStep(
          pelindung: formData.pelindung,
          pembina: formData.pembina,
        );
      case BeritaAcaraFormaturPembentukanPengurusHarianFormStep
          .dataPengurusInti:
        return validateDataPengurusIntiStep(
          namaKetua: formData.namaKetua,
          wakilKetua: formData.wakilKetua,
          namaSekretaris: formData.namaSekretaris,
          wakilSekretaris: formData.wakilSekretaris,
          namaBendahara: formData.namaBendahara,
          namaWakilBend: formData.namaWakilBend,
        );
      case BeritaAcaraFormaturPembentukanPengurusHarianFormStep.penetapan:
        return validatePenetapanStep(
          tanggalPenyusunan: formData.tanggalPenyusunan,
          tempatPenyusunan: formData.tempatPenyusunan,
          namaWilayah: formData.namaWilayah,
          tanggalHijriah: formData.tanggalHijriah,
          tanggalMasehi: formData.tanggalMasehi,
        );
      case BeritaAcaraFormaturPembentukanPengurusHarianFormStep.review:
        // Review step tidak memerlukan validasi
        return const FormValidationResult.success();
    }
  }
}
