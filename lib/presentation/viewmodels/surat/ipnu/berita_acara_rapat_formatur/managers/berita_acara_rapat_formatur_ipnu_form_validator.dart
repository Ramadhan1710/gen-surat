import '../../../../../../core/exception/form_validation_result.dart';
import '../../../../../../core/validator/required_validator.dart';
import '../enum/berita_acara_rapat_formatur_ipnu_form_step.dart';
import 'berita_acara_rapat_formatur_ipnu_form_data_manager.dart';

/// Form validator untuk Berita Acara Rapat Formatur
/// Handles step-level validation untuk multi-step form
class BeritaAcaraRapatFormaturIpnuFormValidator {
  /// Validasi Step 1: Informasi Lembaga
  FormValidationResult validateLembagaStep({
    required String jenisLembaga,
    required String namaLembaga,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Tingkatan Pimpinan').validate(jenisLembaga),
      RequiredValidator('Nama desa/sekolah').validate(namaLembaga),
    ]);
  }

  /// Validasi Step 2: Waktu dan Tempat
  FormValidationResult validateWaktuTempatStep({
    required String tanggal,
    required String bulan,
    required String tahun,
    required String tempatRapat,
    required String periodeRapta,
    required String namaWilayah,
    required String tanggalRapat,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Tanggal').validate(tanggal),
      RequiredValidator('Bulan').validate(bulan),
      RequiredValidator('Tahun').validate(tahun),
      RequiredValidator('Tempat rapat').validate(tempatRapat),
      RequiredValidator('Periode RAPTA').validate(periodeRapta),
      RequiredValidator('Nama wilayah').validate(namaWilayah),
      RequiredValidator('Tanggal penetapan').validate(tanggalRapat),
    ]);
  }

  /// Validasi Step 3: Tim Formatur
  FormValidationResult validateTimFormaturStep({
    required List<TimFormaturData> timFormaturList,
  }) {
    if (timFormaturList.isEmpty) {
      return const FormValidationResult.error(
        'Tim formatur harus diisi minimal 1 orang',
      );
    }

    for (int i = 0; i < timFormaturList.length; i++) {
      final member = timFormaturList[i];
      final nama = member.namaController.text.trim();
      final jabatan = member.jabatanController.text.trim();

      final namaValidation = RequiredValidator('Nama tim formatur #${i + 1}').validate(nama);
      if (!namaValidation.isValid) {
        return namaValidation;
      }

      final jabatanValidation = RequiredValidator('Jabatan tim formatur #${i + 1}').validate(jabatan);
      if (!jabatanValidation.isValid) {
        return jabatanValidation;
      }

      if (member.ttdPath == null) {
        return FormValidationResult.error(
          'Tanda tangan tim formatur #${i + 1} ($nama) belum diunggah',
        );
      }
    }

    return const FormValidationResult.success();
  }

  /// Validasi per step berdasarkan step saat ini
  FormValidationResult validateStep(
    BeritaAcaraRapatFormaturIpnuFormStep step,
    BeritaAcaraRapatFormaturIpnuFormDataManager formData,
  ) {
    switch (step) {
      case BeritaAcaraRapatFormaturIpnuFormStep.lembaga:
        return validateLembagaStep(
          jenisLembaga: formData.jenisLembagaController.text.trim(),
          namaLembaga: formData.namaLembagaController.text.trim(),
        );
      case BeritaAcaraRapatFormaturIpnuFormStep.waktuTempat:
        return validateWaktuTempatStep(
          tanggal: formData.tanggalController.text.trim(),
          bulan: formData.bulanController.text.trim(),
          tahun: formData.tahunController.text.trim(),
          tempatRapat: formData.tempatRapatController.text.trim(),
          periodeRapta: formData.periodeRaptaController.text.trim(),
          namaWilayah: formData.namaWilayahController.text.trim(),
          tanggalRapat: formData.tanggalRapatController.text.trim(),
        );
      case BeritaAcaraRapatFormaturIpnuFormStep.timFormatur:
        return validateTimFormaturStep(
          timFormaturList: formData.timFormaturList,
        );
    }
  }
}
