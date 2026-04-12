import 'package:gen_surat/core/exception/form_validation_result.dart';
import 'package:gen_surat/core/validator/common_step_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/permohonan_izin_tempat/enum/surat_permohonan_izin_tempat_bersama_form_step.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/permohonan_izin_tempat/managers/surat_permohonan_izin_tempat_bersama_form_data_manager.dart';

class SuratPermohonanIzinTempatBersamaFormValidator {
  FormValidationResult validatePembukaSurat({
    required String nomorSurat,
    required String lampiran,
    required String tujuanSurat,
  }) {
    return CommonStepValidators.combine([
      CommonStepValidators.required(nomorSurat, 'Nomor surat'),
      CommonStepValidators.required(lampiran, 'Lampiran'),
      CommonStepValidators.required(tujuanSurat, 'Tujuan surat'),
    ]);
  }

  FormValidationResult validateIsiSurat({
    required String namaKegiatan,
    required String tempat,
    required String hariTanggal,
    required String waktu,
  }) {
    return CommonStepValidators.combine([
      CommonStepValidators.required(namaKegiatan, 'Nama kegiatan'),
      CommonStepValidators.required(tempat, 'Tempat'),
      CommonStepValidators.required(hariTanggal, 'Hari/Tanggal'),
      CommonStepValidators.required(waktu, 'Waktu'),
    ]);
  }

  FormValidationResult validatePenutupSurat({
    required String tanggalHijriah,
    required String tanggalMasehi,
  }) {
    return CommonStepValidators.validateTanggalLengkap(
      tanggalHijriah: tanggalHijriah,
      tanggalMasehi: tanggalMasehi,
    );
  }

  FormValidationResult validateStep(
    SuratPermohonanIzinTempatBersamaFormStep step,
    SuratPermohonanIzinTempatBersamaFormDataManager formDataManager,
  ) {
    switch (step) {
      case SuratPermohonanIzinTempatBersamaFormStep.pembuka:
        return validatePembukaSurat(
          nomorSurat: formDataManager.nomorSurat,
          lampiran: formDataManager.lampiran,
          tujuanSurat: formDataManager.tujuanSurat,
        );
      case SuratPermohonanIzinTempatBersamaFormStep.isi:
        return validateIsiSurat(
          namaKegiatan: formDataManager.namaKegiatan,
          tempat: formDataManager.tempat,
          hariTanggal: formDataManager.hariTanggal,
          waktu: formDataManager.waktu,
        );
      case SuratPermohonanIzinTempatBersamaFormStep.penutup:
        return validatePenutupSurat(
          tanggalHijriah: formDataManager.tanggalHijriah,
          tanggalMasehi: formDataManager.tanggalMasehi,
        );
    }
  }
}
