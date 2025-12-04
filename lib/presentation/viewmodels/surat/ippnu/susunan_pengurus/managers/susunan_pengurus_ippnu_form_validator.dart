import '../../../../../../core/exception/form_validation_result.dart';
import '../../../../../../core/validator/required_validator.dart';
import '../enum/susunan_pengurus_ippnu_form_step.dart';
import 'susunan_pengurus_ippnu_form_data_manager.dart';

class SusunanPengurusIppnuFormValidator {
  FormValidationResult validateInformasiLembagaStep({
    required String jenisLembaga,
    required String namaLembaga,
    required String periodeKepengurusan,
    required String alamatLembaga,
    required String nomorTeleponLembaga,
    required String emailLembaga,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Tingkatan Lembaga').validate(jenisLembaga),
      RequiredValidator('Nama Desa/Sekolah').validate(namaLembaga),
      RequiredValidator('Periode Kepengurusan').validate(periodeKepengurusan),
      RequiredValidator('Alamat Lembaga').validate(alamatLembaga),
      RequiredValidator('Nomor Telepon Lembaga').validate(nomorTeleponLembaga),
      RequiredValidator('Email Lembaga').validate(emailLembaga),
    ]);
  }

  FormValidationResult validatePengurusHarianStep({
    required String namaKetua,
    required List<WakilKetuaData> wakilKetua,
    required String namaSekretaris,
    required List<WakilSekretarisData> wakilSekre,
    required String namaBendahara,
  }) {
    final results = <FormValidationResult>[
      RequiredValidator('Nama Ketua').validate(namaKetua),
      RequiredValidator('Nama Sekretaris').validate(namaSekretaris),
      RequiredValidator('Nama Bendahara').validate(namaBendahara),
    ];

    if (wakilKetua.isEmpty) {
      results.add(
        const FormValidationResult.error(
          'Wakil ketua harus diisi minimal satu',
        ),
      );
    } else {
      for (var i = 0; i < wakilKetua.length; i++) {
        final item = wakilKetua[i];
        results.add(
          RequiredValidator(
            'Jabatan wakil ketua ${i + 1}',
          ).validate(item.title),
        );
        results.add(
          RequiredValidator('Nama wakil ketua ${i + 1}').validate(item.nama),
        );
      }
    }

    for (var i = 0; i < wakilSekre.length; i++) {
      final item = wakilSekre[i];
      if (item.title.isNotEmpty || item.nama.isNotEmpty) {
        results.add(
          RequiredValidator(
            'Jabatan wakil sekretaris ${i + 1}',
          ).validate(item.title),
        );
        results.add(
          RequiredValidator(
            'Nama wakil sekretaris ${i + 1}',
          ).validate(item.nama),
        );
      }
    }

    return FormValidationResult.combine(results);
  }

  FormValidationResult validateDepartemenStep({
    required List<DepartemenData> departemen,
  }) {
    if (departemen.isEmpty) {
      return const FormValidationResult.error(
        'Departemen harus diisi minimal satu',
      );
    }

    for (var i = 0; i < departemen.length; i++) {
      final dept = departemen[i];
      final results = <FormValidationResult>[
        RequiredValidator(
          'Nama departemen ${i + 1}',
        ).validate(dept.namaDepartemen),
        RequiredValidator(
          'Koordinator departemen ${i + 1}',
        ).validate(dept.koordinator),
      ];

      if (dept.anggota.isEmpty) {
        results.add(
          FormValidationResult.error(
            'Anggota departemen ${i + 1} harus diisi minimal satu',
          ),
        );
      } else {
        for (var j = 0; j < dept.anggota.length; j++) {
          results.add(
            RequiredValidator(
              'Nama anggota ${j + 1} departemen ${i + 1}',
            ).validate(dept.anggota[j].nama),
          );
        }
      }

      final combined = FormValidationResult.combine(results);
      if (!combined.isValid) {
        return combined;
      }
    }

    return const FormValidationResult.success();
  }

  FormValidationResult validateLembagaStep({
    required List<LembagaData> lembaga,
  }) {
    if (lembaga.isEmpty) {
      return const FormValidationResult.error(
        'Lembaga harus diisi minimal satu',
      );
    }

    for (var i = 0; i < lembaga.length; i++) {
      final lmb = lembaga[i];
      final results = <FormValidationResult>[
        RequiredValidator('Nama lembaga ${i + 1}').validate(lmb.nama),
        RequiredValidator('Direktur lembaga ${i + 1}').validate(lmb.direktur),
        RequiredValidator(
          'Sekretaris lembaga ${i + 1}',
        ).validate(lmb.sekretaris),
      ];

      if (lmb.anggota.isEmpty) {
        results.add(
          FormValidationResult.error(
            'Anggota lembaga ${i + 1} harus diisi minimal satu',
          ),
        );
      } else {
        for (var j = 0; j < lmb.anggota.length; j++) {
          results.add(
            RequiredValidator(
              'Nama anggota ${j + 1} lembaga ${i + 1}',
            ).validate(lmb.anggota[j].nama),
          );
        }
      }

      final combined = FormValidationResult.combine(results);
      if (!combined.isValid) {
        return combined;
      }
    }

    return const FormValidationResult.success();
  }

  FormValidationResult validatePelindungPembinaStep({
    required List<PelindungData> pelindung,
    required List<PembinaData> pembina,
  }) {
    final results = <FormValidationResult>[];

    if (pelindung.isEmpty) {
      results.add(
        const FormValidationResult.error('Pelindung harus diisi minimal satu'),
      );
    } else {
      for (var i = 0; i < pelindung.length; i++) {
        results.add(
          RequiredValidator(
            'Nama pelindung ${i + 1}',
          ).validate(pelindung[i].nama),
        );
      }
    }

    if (pembina.isEmpty) {
      results.add(
        const FormValidationResult.error('Pembina harus diisi minimal satu'),
      );
    } else {
      for (var i = 0; i < pembina.length; i++) {
        results.add(
          RequiredValidator('Nama pembina ${i + 1}').validate(pembina[i].nama),
        );
      }
    }

    return FormValidationResult.combine(results);
  }

  FormValidationResult validateKetuaWakilStep({
    required String namaKetua,
    required List<WakilKetuaData> wakilKetua,
  }) {
    final results = <FormValidationResult>[
      RequiredValidator('Nama Ketua').validate(namaKetua),
    ];

    if (wakilKetua.isEmpty) {
      results.add(
        const FormValidationResult.error(
          'Wakil ketua harus diisi minimal satu',
        ),
      );
    }

    // Wakil ketua is optional, but if added, must be valid
    for (var i = 0; i < wakilKetua.length; i++) {
      final item = wakilKetua[i];
      if (item.title.isNotEmpty || item.nama.isNotEmpty) {
        results.add(
          RequiredValidator(
            'Jabatan wakil ketua ${i + 1}',
          ).validate(item.title),
        );
        results.add(
          RequiredValidator('Nama wakil ketua ${i + 1}').validate(item.nama),
        );
      }
    }

    return FormValidationResult.combine(results);
  }

  FormValidationResult validateSekretarisWakilStep({
    required String namaSekretaris,
    required List<WakilSekretarisData> wakilSekre,
  }) {
    final results = <FormValidationResult>[
      RequiredValidator('Nama Sekretaris').validate(namaSekretaris),
    ];

    // Wakil sekretaris is optional, but if added, must be valid
    for (var i = 0; i < wakilSekre.length; i++) {
      final item = wakilSekre[i];
      if (item.title.isNotEmpty || item.nama.isNotEmpty) {
        results.add(
          RequiredValidator(
            'Jabatan wakil sekretaris ${i + 1}',
          ).validate(item.title),
        );
        results.add(
          RequiredValidator(
            'Nama wakil sekretaris ${i + 1}',
          ).validate(item.nama),
        );
      }
    }

    return FormValidationResult.combine(results);
  }

  FormValidationResult validateBendaharaStep({required String namaBendahara}) {
    return RequiredValidator('Nama Bendahara').validate(namaBendahara);
  }

  FormValidationResult validateStep(
    SusunanPengurusIppnuFormStep step,
    SusunanPengurusIppnuFormDataManager formData,
  ) {
    switch (step) {
      case SusunanPengurusIppnuFormStep.lembaga:
        return validateInformasiLembagaStep(
          jenisLembaga: formData.jenisLembaga,
          namaLembaga: formData.namaLembaga,
          periodeKepengurusan: formData.periodeKepengurusan,
          alamatLembaga: formData.alamatLembaga,
          nomorTeleponLembaga: formData.nomorTeleponLembaga,
          emailLembaga: formData.emailLembaga,
        );
      case SusunanPengurusIppnuFormStep.pelindungPembina:
        return validatePelindungPembinaStep(
          pelindung: formData.pelindung,
          pembina: formData.pembina,
        );
      case SusunanPengurusIppnuFormStep.ketuaWakil:
        return validateKetuaWakilStep(
          namaKetua: formData.namaKetua,
          wakilKetua: formData.wakilKetua,
        );
      case SusunanPengurusIppnuFormStep.sekretarisWakil:
        return validateSekretarisWakilStep(
          namaSekretaris: formData.namaSekretaris,
          wakilSekre: formData.wakilSekre,
        );
      case SusunanPengurusIppnuFormStep.bendahara:
        return validateBendaharaStep(namaBendahara: formData.namaBendahara);
      case SusunanPengurusIppnuFormStep.departemen:
        return validateDepartemenStep(departemen: formData.departemen);
      case SusunanPengurusIppnuFormStep.lembagaInternal:
        return validateLembagaStep(lembaga: formData.lembaga);
    }
  }
}
