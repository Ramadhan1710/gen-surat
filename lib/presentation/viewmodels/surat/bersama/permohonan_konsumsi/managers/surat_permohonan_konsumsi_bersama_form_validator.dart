import 'package:gen_surat/core/exception/form_validation_result.dart';
import 'package:gen_surat/core/validator/common_step_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/permohonan_konsumsi/enum/surat_permohonan_konsumsi_bersama_form_step.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/permohonan_konsumsi/managers/surat_permohonan_konsumsi_bersama_form_data_manager.dart';

class SuratPermohonanKonsumsiBersamaFormValidator {
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
    required String namaKonsumsi,
    required String jumlahKonsumsi,
  }) {
    return CommonStepValidators.combine([
      CommonStepValidators.required(namaKegiatan, 'Nama kegiatan'),
      CommonStepValidators.required(tempat, 'Tempat'),
      CommonStepValidators.required(hariTanggal, 'Hari/Tanggal'),
      CommonStepValidators.required(waktu, 'Waktu'),
      CommonStepValidators.required(namaKonsumsi, 'Nama konsumsi'),
      CommonStepValidators.required(jumlahKonsumsi, 'Jumlah konsumsi'),
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
    SuratPermohonanKonsumsiBersamaFormStep step,
    SuratPermohonanKonsumsiBersamaFormDataManager formDataManager,
  ) {
    switch (step) {
      case SuratPermohonanKonsumsiBersamaFormStep.pembuka:
        return validatePembukaSurat(
          nomorSurat: formDataManager.nomorSurat,
          lampiran: formDataManager.lampiran,
          tujuanSurat: formDataManager.tujuanSurat,
        );
      case SuratPermohonanKonsumsiBersamaFormStep.isi:
        return validateIsiSurat(
          namaKegiatan: formDataManager.namaKegiatan,
          tempat: formDataManager.tempat,
          hariTanggal: formDataManager.hariTanggal,
          waktu: formDataManager.waktu,
          namaKonsumsi: formDataManager.namaKonsumsi,
          jumlahKonsumsi: formDataManager.jumlahKonsumsi,
        );
      case SuratPermohonanKonsumsiBersamaFormStep.penutup:
        return validatePenutupSurat(
          tanggalHijriah: formDataManager.tanggalHijriah,
          tanggalMasehi: formDataManager.tanggalMasehi,
        );
    }
  }
}
