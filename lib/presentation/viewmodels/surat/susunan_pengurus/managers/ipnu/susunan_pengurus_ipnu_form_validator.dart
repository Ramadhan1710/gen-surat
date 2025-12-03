import '../../../../../../core/exception/form_validation_result.dart';
import '../../../../../../core/validator/required_validator.dart';
import '../../../../../../core/validator/email_validator.dart';
import '../../enum/susunan_pengurus_form_step.dart';
import 'susunan_pengurus_ipnu_form_data_manager.dart';

class SusunanPengurusIpnuFormValidator {
  FormValidationResult validateLembagaStep({
    required String jenisLembaga,
    required String namaLembaga,
    required String alamatLembaga,
    required String nomorTeleponLembaga,
    required String emailLembaga,
    required String periodeKepengurusan,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Tingkatan lembaga').validate(jenisLembaga),
      RequiredValidator('Nama desa/sekolah').validate(namaLembaga),
      RequiredValidator('Alamat lembaga').validate(alamatLembaga),
      RequiredValidator('Nomor telepon lembaga').validate(nomorTeleponLembaga),
      RequiredValidator('Email lembaga').validate(emailLembaga),
      const EmailValidator().validate(emailLembaga),
      RequiredValidator('Periode kepengurusan').validate(periodeKepengurusan),
    ]);
  }

  FormValidationResult validatePelindungPembinaStep({
    required List<PembinaData> pembina,
  }) {
    if (pembina.isEmpty) {
      return const FormValidationResult.error(
        'Data pembina harus diisi minimal satu',
      );
    }

    for (var i = 0; i < pembina.length; i++) {
      final item = pembina[i];
      final nama = item.namaController.text.trim();

      final namaValidation = RequiredValidator(
        'Nama pembina no. ${i + 1}',
      ).validate(nama);
      if (!namaValidation.isValid) {
        return namaValidation;
      }
    }

    return const FormValidationResult.success();
  }

  FormValidationResult validateKetuaWakilStep({
    required String namaKetua,
    required String alamatKetua,
    required List<WakilKetuaData> wakilKetua,
  }) {
    final validation = FormValidationResult.combine([
      RequiredValidator('Nama ketua').validate(namaKetua),
      RequiredValidator('Alamat ketua').validate(alamatKetua),
    ]);

    if (!validation.isValid) {
      return validation;
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
      final alamat = item.alamatController.text.trim();

      final titleValidation = RequiredValidator(
        'Title wakil ketua no. ${i + 1}',
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

      final alamatValidation = RequiredValidator(
        'Alamat wakil ketua no. ${i + 1}',
      ).validate(alamat);
      if (!alamatValidation.isValid) {
        return alamatValidation;
      }
    }

    return const FormValidationResult.success();
  }

  FormValidationResult validateSekretarisWakilStep({
    required String namaSekretaris,
    required String alamatSekretaris,
    List<WakilSekretarisData>? wakilSekre,
  }) {
    final validation = FormValidationResult.combine([
      RequiredValidator('Nama sekretaris').validate(namaSekretaris),
      RequiredValidator('Alamat sekretaris').validate(alamatSekretaris),
    ]);

    if (!validation.isValid) {
      return validation;
    }

    if (wakilSekre != null && wakilSekre.isNotEmpty) {
      for (var i = 0; i < wakilSekre.length; i++) {
        final item = wakilSekre[i];
        final title = item.titleController.text.trim();
        final nama = item.namaController.text.trim();
        final alamat = item.alamatController.text.trim();

        final titleValidation = RequiredValidator(
          'Title wakil sekretaris no. ${i + 1}',
        ).validate(title);
        if (!titleValidation.isValid) {
          return titleValidation;
        }

        final namaValidation = RequiredValidator(
          'Nama wakil sekretaris no. ${i + 1}',
        ).validate(nama);
        if (!namaValidation.isValid) {
          return namaValidation;
        }

        final alamatValidation = RequiredValidator(
          'Alamat wakil sekretaris no. ${i + 1}',
        ).validate(alamat);
        if (!alamatValidation.isValid) {
          return alamatValidation;
        }
      }
    }

    return const FormValidationResult.success();
  }

  FormValidationResult validateBendaharaStep({
    required String namaBendahara,
    required String alamatBendahara,
    String? namaWakilBend,
    String? alamatWakilBend,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Nama bendahara').validate(namaBendahara),
      RequiredValidator('Alamat bendahara').validate(alamatBendahara),
    ]);
  }

  FormValidationResult validateDepartemenStep({
    required List<DepartemenData> departemen,
  }) {
    if (departemen.isEmpty) {
      return const FormValidationResult.error(
        'Data departemen harus diisi minimal satu',
      );
    }

    for (var i = 0; i < departemen.length; i++) {
      final dept = departemen[i];
      final nama = dept.namaController.text.trim();
      final koordinator = dept.koordinatorController.text.trim();
      final alamatKoordinator = dept.alamatKoordinatorController.text.trim();

      final namaValidation = RequiredValidator(
        'Nama departemen no. ${i + 1}',
      ).validate(nama);
      if (!namaValidation.isValid) {
        return namaValidation;
      }

      final koordinatorValidation = RequiredValidator(
        'Koordinator departemen no. ${i + 1}',
      ).validate(koordinator);
      if (!koordinatorValidation.isValid) {
        return koordinatorValidation;
      }

      final alamatValidation = RequiredValidator(
        'Alamat koordinator departemen no. ${i + 1}',
      ).validate(alamatKoordinator);
      if (!alamatValidation.isValid) {
        return alamatValidation;
      }

      for (var j = 0; j < dept.anggota.length; j++) {
        final anggota = dept.anggota[j];
        final namaAnggota = anggota.namaController.text.trim();
        final alamatAnggota = anggota.alamatController.text.trim();

        final namaAnggotaValidation = RequiredValidator(
          'Nama anggota no. ${j + 1} departemen ${dept.nama}',
        ).validate(namaAnggota);
        if (!namaAnggotaValidation.isValid) {
          return namaAnggotaValidation;
        }

        final alamatAnggotaValidation = RequiredValidator(
          'Alamat anggota no. ${j + 1} departemen ${dept.nama}',
        ).validate(alamatAnggota);
        if (!alamatAnggotaValidation.isValid) {
          return alamatAnggotaValidation;
        }
      }
    }

    return const FormValidationResult.success();
  }

  FormValidationResult validateLembagaInternalStep({
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
      final alamatDirektur = item.alamatDirekturController.text.trim();
      final sekretaris = item.sekretarisController.text.trim();
      final alamatSekretaris = item.alamatSekretarisController.text.trim();

      final namaValidation = RequiredValidator(
        'Nama lembaga no. ${i + 1}',
      ).validate(nama);
      if (!namaValidation.isValid) {
        return namaValidation;
      }

      final direkturValidation = RequiredValidator(
        'Direktur lembaga no. ${i + 1}',
      ).validate(direktur);
      if (!direkturValidation.isValid) {
        return direkturValidation;
      }

      final alamatDirekturValidation = RequiredValidator(
        'Alamat direktur lembaga no. ${i + 1}',
      ).validate(alamatDirektur);
      if (!alamatDirekturValidation.isValid) {
        return alamatDirekturValidation;
      }

      final sekretarisValidation = RequiredValidator(
        'Sekretaris lembaga no. ${i + 1}',
      ).validate(sekretaris);
      if (!sekretarisValidation.isValid) {
        return sekretarisValidation;
      }

      final alamatSekretarisValidation = RequiredValidator(
        'Alamat sekretaris lembaga no. ${i + 1}',
      ).validate(alamatSekretaris);
      if (!alamatSekretarisValidation.isValid) {
        return alamatSekretarisValidation;
      }
    }

    return const FormValidationResult.success();
  }

  FormValidationResult validateCBPDivisiStep({
    required bool hasLembagaCBP,
    required String komandan,
    required String alamatKomandan,
    required String wakilKomandan,
    required String alamatWakilKomandan,
    required bool hasDivisi,
    required List<DivisiData> divisi,
  }) {
    if (!hasLembagaCBP) {
      return const FormValidationResult.success();
    }

    final cbpValidation = FormValidationResult.combine([
      RequiredValidator('Komandan').validate(komandan),
      RequiredValidator('Alamat komandan').validate(alamatKomandan),
    ]);

    if (!cbpValidation.isValid) {
      return cbpValidation;
    }

    if (!hasDivisi) {
      return const FormValidationResult.success();
    }

    if (divisi.isEmpty) {
      return const FormValidationResult.error(
        'Data divisi harus diisi minimal satu jika memiliki divisi',
      );
    }

    for (var i = 0; i < divisi.length; i++) {
      final item = divisi[i];
      final nama = item.namaController.text.trim();
      final koordinator = item.koordinatorController.text.trim();
      final alamatKoordinator = item.alamatKoordinatorController.text.trim();

      final namaValidation = RequiredValidator(
        'Nama divisi no. ${i + 1}',
      ).validate(nama);
      if (!namaValidation.isValid) {
        return namaValidation;
      }

      final koordinatorValidation = RequiredValidator(
        'Koordinator divisi no. ${i + 1}',
      ).validate(koordinator);
      if (!koordinatorValidation.isValid) {
        return koordinatorValidation;
      }

      final alamatValidation = RequiredValidator(
        'Alamat koordinator divisi no. ${i + 1}',
      ).validate(alamatKoordinator);
      if (!alamatValidation.isValid) {
        return alamatValidation;
      }
    }

    return const FormValidationResult.success();
  }

  FormValidationResult validateStep(
    SusunanPengurusFormStep step,
    SusunanPengurusIpnuFormDataManager formData,
  ) {
    switch (step) {
      case SusunanPengurusFormStep.lembaga:
        return validateLembagaStep(
          jenisLembaga: formData.jenisLembaga,
          namaLembaga: formData.namaLembaga,
          alamatLembaga: formData.alamatLembaga,
          nomorTeleponLembaga: formData.nomorTeleponLembaga,
          emailLembaga: formData.emailLembaga,
          periodeKepengurusan: formData.periodeKepengurusan,
        );
      case SusunanPengurusFormStep.pelindungPembina:
        return validatePelindungPembinaStep(pembina: formData.pembina);
      case SusunanPengurusFormStep.ketuaWakil:
        return validateKetuaWakilStep(
          namaKetua: formData.namaKetua,
          alamatKetua: formData.alamatKetua,
          wakilKetua: formData.wakilKetua,
        );
      case SusunanPengurusFormStep.sekretarisWakil:
        return validateSekretarisWakilStep(
          namaSekretaris: formData.namaSekretaris,
          alamatSekretaris: formData.alamatSekretaris,
          wakilSekre: formData.wakilSekre,
        );
      case SusunanPengurusFormStep.bendahara:
        return validateBendaharaStep(
          namaBendahara: formData.namaBendahara,
          alamatBendahara: formData.alamatBendahara,
          namaWakilBend:
              formData.namaWakilBend.isNotEmpty ? formData.namaWakilBend : null,
          alamatWakilBend:
              formData.alamatWakilBend.isNotEmpty
                  ? formData.alamatWakilBend
                  : null,
        );
      case SusunanPengurusFormStep.departemen:
        return validateDepartemenStep(departemen: formData.departemen);
      case SusunanPengurusFormStep.lembagaInternal:
        return validateLembagaInternalStep(lembaga: formData.lembagaInternal);
      case SusunanPengurusFormStep.cbpDivisi:
        return validateCBPDivisiStep(
          hasLembagaCBP: formData.hasLembagaCBP.value,
          komandan: formData.komandan,
          alamatKomandan: formData.alamatKomandan,
          wakilKomandan: formData.wakilKomandan,
          alamatWakilKomandan: formData.alamatWakilKomandan,
          hasDivisi: formData.hasDivisi.value,
          divisi: formData.divisi,
        );
    }
  }
}
