import 'package:gen_surat/core/exception/form_validation_result.dart';
import 'package:gen_surat/core/validator/required_validator.dart';

import '../enum/berita_acara_penyusunan_pengurus_ippnu_form_step.dart';
import 'berita_acara_penyusunan_pengurus_ippnu_form_data_manager.dart';

class BeritaAcaraPenyusunanPengurusIppnuFormValidator {
  FormValidationResult validateInformasiLembagaStep({
    required String jenisLembaga,
    required String namaLembaga,
    required String periodeKepengurusan,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Jenis Lembaga').validate(jenisLembaga),
      RequiredValidator('Nama Lembaga').validate(namaLembaga),
      RequiredValidator('Periode Kepengurusan').validate(periodeKepengurusan),
    ]);
  }

  FormValidationResult validateDataPengurusHarianStep({
    required List<PengurusHarianData> pengurusHarian,
  }) {
    if (pengurusHarian.isEmpty) {
      return const FormValidationResult.error(
        'Data pengurus harian harus diisi minimal satu anggota',
      );
    }

    for (var i = 0; i < pengurusHarian.length; i++) {
      final item = pengurusHarian[i];
      final jabatan = item.jabatanController.text.trim();
      final nama = item.namaController.text.trim();

      final jabatanValidation = RequiredValidator(
        'Jabatan pengurus no. ${i + 1}',
      ).validate(jabatan);
      if (!jabatanValidation.isValid) {
        return jabatanValidation;
      }

      final namaValidation = RequiredValidator(
        'Nama pengurus no. ${i + 1}',
      ).validate(nama);
      if (!namaValidation.isValid) {
        return namaValidation;
      }

      // TTD is optional
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
          'Nama wakil sekretaris no. ${i + 1} belum diisi',
        );
      }

      if (title.isEmpty && nama.isNotEmpty) {
        return FormValidationResult.error(
          'Jabatan wakil sekretaris no. ${i + 1} belum diisi',
        );
      }
    }

    // Wakil bendahara optional

    return const FormValidationResult.success();
  }

  FormValidationResult validateDataDepartemenStep({
    required List<DepartemenData> departemen,
  }) {
    if (departemen.isEmpty) {
      return const FormValidationResult.error(
        'Data departemen harus diisi minimal satu',
      );
    }

    for (var i = 0; i < departemen.length; i++) {
      final item = departemen[i];
      final namaDept = item.namaDepartemenController.text.trim();
      final koordinator = item.koordinatorController.text.trim();

      final namaDeptValidation = RequiredValidator(
        'Nama departemen no. ${i + 1}',
      ).validate(namaDept);
      if (!namaDeptValidation.isValid) {
        return namaDeptValidation;
      }

      final koordinatorValidation = RequiredValidator(
        'Koordinator departemen "$namaDept"',
      ).validate(koordinator);
      if (!koordinatorValidation.isValid) {
        return koordinatorValidation;
      }

      if (item.anggota.isEmpty) {
        return FormValidationResult.error(
          'Anggota departemen "$namaDept" harus diisi minimal satu',
        );
      }

      for (var j = 0; j < item.anggota.length; j++) {
        final anggota = item.anggota[j];
        final namaAnggota = anggota.namaController.text.trim();

        final namaAnggotaValidation = RequiredValidator(
          'Nama anggota no. ${j + 1} departemen "$namaDept"',
        ).validate(namaAnggota);
        if (!namaAnggotaValidation.isValid) {
          return namaAnggotaValidation;
        }
      }
    }

    return const FormValidationResult.success();
  }

  FormValidationResult validateDataLembagaStep({
    required List<LembagaData> lembaga,
  }) {
    if (lembaga.isEmpty) {
      return const FormValidationResult.error(
        'Data lembaga harus diisi minimal satu',
      );
    }

    for (var i = 0; i < lembaga.length; i++) {
      final item = lembaga[i];
      final nama = item.namaController.text.trim();
      final direktur = item.direkturController.text.trim();
      final sekretaris = item.sekretarisController.text.trim();

      final namaValidation = RequiredValidator(
        'Nama lembaga no. ${i + 1}',
      ).validate(nama);
      if (!namaValidation.isValid) {
        return namaValidation;
      }

      final direkturValidation = RequiredValidator(
        'Direktur lembaga "$nama"',
      ).validate(direktur);
      if (!direkturValidation.isValid) {
        return direkturValidation;
      }

      final sekretarisValidation = RequiredValidator(
        'Sekretaris lembaga "$nama"',
      ).validate(sekretaris);
      if (!sekretarisValidation.isValid) {
        return sekretarisValidation;
      }

      if (item.anggota.isEmpty) {
        return FormValidationResult.error(
          'Anggota lembaga "$nama" harus diisi minimal satu',
        );
      }

      for (var j = 0; j < item.anggota.length; j++) {
        final anggota = item.anggota[j];
        final namaAnggota = anggota.namaController.text.trim();

        final namaAnggotaValidation = RequiredValidator(
          'Nama anggota no. ${j + 1} lembaga "$nama"',
        ).validate(namaAnggota);
        if (!namaAnggotaValidation.isValid) {
          return namaAnggotaValidation;
        }
      }
    }

    return const FormValidationResult.success();
  }

  FormValidationResult validatePenetapanStep({
    required String tanggalPenyusunan,
    required String tempatPenyusunan,
    required String namaWilayah,
    required String hariPenyusunan,
    required String tanggalHijriah,
    required String tanggalMasehi,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Tanggal Penyusunan').validate(tanggalPenyusunan),
      RequiredValidator('Tempat Penyusunan').validate(tempatPenyusunan),
      RequiredValidator('Nama Wilayah').validate(namaWilayah),
      RequiredValidator('Hari Penyusunan').validate(hariPenyusunan),
      RequiredValidator('Tanggal Hijriah').validate(tanggalHijriah),
      RequiredValidator('Tanggal Masehi').validate(tanggalMasehi),
    ]);
  }

  FormValidationResult validateStep(
    BeritaAcaraPenyusunanPengurusIppnuFormStep step,
    BeritaAcaraPenyusunanPengurusIppnuFormDataManager formDataManager,
  ) {
    switch (step) {
      case BeritaAcaraPenyusunanPengurusIppnuFormStep.informasiLembaga:
        return validateInformasiLembagaStep(
          jenisLembaga: formDataManager.jenisLembaga,
          namaLembaga: formDataManager.namaLembaga,
          periodeKepengurusan: formDataManager.periodeKepengurusan,
        );

      case BeritaAcaraPenyusunanPengurusIppnuFormStep.dataPengurusHarian:
        return validateDataPengurusHarianStep(
          pengurusHarian: formDataManager.pengurusHarian,
        );

      case BeritaAcaraPenyusunanPengurusIppnuFormStep.dataPelindungPembina:
        return validateDataPelindungPembinaStep(
          pelindung: formDataManager.pelindung,
          pembina: formDataManager.pembina,
        );

      case BeritaAcaraPenyusunanPengurusIppnuFormStep.dataPengurusInti:
        return validateDataPengurusIntiStep(
          namaKetua: formDataManager.namaKetua,
          wakilKetua: formDataManager.wakilKetua,
          namaSekretaris: formDataManager.namaSekretaris,
          wakilSekretaris: formDataManager.wakilSekretaris,
          namaBendahara: formDataManager.namaBendahara,
          namaWakilBend: formDataManager.namaWakilBend,
        );

      case BeritaAcaraPenyusunanPengurusIppnuFormStep.dataDepartemen:
        return validateDataDepartemenStep(
          departemen: formDataManager.departemen,
        );

      case BeritaAcaraPenyusunanPengurusIppnuFormStep.dataLembaga:
        return validateDataLembagaStep(
          lembaga: formDataManager.lembaga,
        );

      case BeritaAcaraPenyusunanPengurusIppnuFormStep.penetapan:
        return validatePenetapanStep(
          tanggalPenyusunan: formDataManager.tanggalPenyusunan,
          tempatPenyusunan: formDataManager.tempatPenyusunan,
          namaWilayah: formDataManager.namaWilayah,
          hariPenyusunan: formDataManager.hariPenyusunan,
          tanggalHijriah: formDataManager.tanggalHijriah,
          tanggalMasehi: formDataManager.tanggalMasehi,
        );

      case BeritaAcaraPenyusunanPengurusIppnuFormStep.review:
        return const FormValidationResult.success();
    }
  }
}
