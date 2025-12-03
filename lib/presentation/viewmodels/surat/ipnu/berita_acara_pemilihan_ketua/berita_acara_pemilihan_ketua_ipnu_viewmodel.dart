import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gen_surat/core/exception/validation_exception.dart';
import 'package:gen_surat/core/helper/field_error_focus_helper.dart';
import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/ipnu/generate_berita_acara_pemilihan_ketua_ipnu_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/base_surat_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/berita_acara_pemilihan_ketua/enum/berita_acara_pemilihan_ketua_form_step.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/berita_acara_pemilihan_ketua/managers/berita_acara_pemilihan_ketua_ipnu_form_data_manager.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/berita_acara_pemilihan_ketua/managers/berita_acara_pemilihan_ketua_ipnu_form_validator.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/berita_acara_pemilihan_ketua/managers/berita_acara_pemilihan_ketua_step_navigation_manager.dart';
import 'package:get/get.dart';

class BeritaAcaraPemilihanKetuaIpnuViewmodel extends BaseSuratViewModel {
  final GenerateBeritaAcaraPemilihanKetuaIpnuUseCase
  _generateBeritaAcaraPemilihanKetuaIpnuUseCase;

  final BeritaAcaraPemilihanKetuaIpnuFormDataManager formDataManager;
  final BeritaAcaraPemilihanKetuaIpnuFormValidator formValidator;
  final BeritaAcaraPemilihanKetuaStepNavigationManager stepNavigationManager;

  BeritaAcaraPemilihanKetuaIpnuViewmodel(
    this._generateBeritaAcaraPemilihanKetuaIpnuUseCase,
    IGeneratedFileRepository fileRepository,
    NotificationService notificationService,
    FileOperationService fileOperationService,
  ) : formDataManager = BeritaAcaraPemilihanKetuaIpnuFormDataManager(),
      formValidator = BeritaAcaraPemilihanKetuaIpnuFormValidator(),
      stepNavigationManager = BeritaAcaraPemilihanKetuaStepNavigationManager(),
      super(
        fileRepository: fileRepository,
        notificationService: notificationService,
        fileOperationService: fileOperationService,
      ) {
    formDataManager.setOnPencalonanSuaraChangedListener(() {
      _pencalonanKetuaVersion.value++;
    });
    formDataManager.setOnPemilihanSuaraChangedListener(() {
      _pemilihanKetuaVersion.value++;
    });
  }

  final ttdKetuaFile = Rxn<File>();
  final ttdSekretarisFile = Rxn<File>();
  final ttdAnggotaFile = Rxn<File>();

  final _pencalonanKetuaVersion = 0.obs;
  final _pemilihanKetuaVersion = 0.obs;
  final _formaturVersion = 0.obs;

  @override
  String get fileType => 'berita_acara_pemilihan_ketua';

  @override
  String get lembagaType => 'IPNU';

  @override
  String getSuratDescription() =>
      'Berita Acara Pemilihan Ketua ${formDataManager.namaLembaga}';

  @override
  String getNomorSurat() => '';

  @override
  String getNamaLembaga() => formDataManager.namaLembaga;

  Rx<BeritaAcaraPemilihanKetuaFormStep> get currentStep =>
      stepNavigationManager.currentStep;
  int get totalSteps => BeritaAcaraPemilihanKetuaFormStep.totalSteps;
  List<String> get stepTitles => BeritaAcaraPemilihanKetuaFormStep.allTitles;

  @override
  void onClose() {
    formDataManager.dispose();
    ttdKetuaFile.close();
    ttdSekretarisFile.close();
    ttdAnggotaFile.close();
    super.onClose();
  }

  void setTtdKetua(File file) {
    ttdKetuaFile.value = file;
    clearError();
  }

  void setTtdSekretaris(File file) {
    ttdSekretarisFile.value = file;
    clearError();
  }

  void setTtdAnggota(File file) {
    ttdAnggotaFile.value = file;
    clearError();
  }

  void removeTtdKetua() => ttdKetuaFile.value = null;
  void removeTtdSekretaris() => ttdSekretarisFile.value = null;
  void removeTtdAnggota() => ttdAnggotaFile.value = null;

  void addPencalonanKetua({
    String nama = '',
    String alamat = '',
    String jmlSuaraSah = '',
  }) {
    formDataManager.addPencalonanKetua(
      nama: nama,
      alamat: alamat,
      jmlSuaraSah: jmlSuaraSah,
    );
    _pencalonanKetuaVersion.value++;
  }

  void removePencalonanKetua(int index) {
    formDataManager.removePencalonanKetua(index);
    _pencalonanKetuaVersion.value++;
  }

  int get pencalonanKetuaCount => formDataManager.pencalonanKetuaCount;
  List<PencalonanKetuaData> get pencalonanKetua =>
      formDataManager.pencalonanKetua;
  RxInt get pencalonanKetuaVersion => _pencalonanKetuaVersion;

  void addPemilihanKetua({
    String nama = '',
    String alamat = '',
    String jmlSuaraSah = '',
  }) {
    formDataManager.addPemilihanKetua(
      nama: nama,
      alamat: alamat,
      jmlSuaraSah: jmlSuaraSah,
    );
    _pemilihanKetuaVersion.value++;
  }

  void removePemilihanKetua(int index) {
    formDataManager.removePemilihanKetua(index);
    _pemilihanKetuaVersion.value++;
  }

  int get pemilihanKetuaCount => formDataManager.pemilihanKetuaCount;
  List<PemilihanKetuaData> get pemilihanKetua => formDataManager.pemilihanKetua;
  RxInt get pemilihanKetuaVersion => _pemilihanKetuaVersion;

  void addFormatur({
    String nama = '',
    String alamat = '',
    String daerahPengkaderan = '',
  }) {
    formDataManager.addFormatur(
      nama: nama,
      alamat: alamat,
      daerahPengkaderan: daerahPengkaderan,
    );
    _formaturVersion.value++;
  }

  void removeFormatur(int index) {
    formDataManager.removeFormatur(index);
    _formaturVersion.value++;
  }

  int get formaturCount => formDataManager.formaturCount;
  List<FormaturData> get formatur => formDataManager.formatur;
  RxInt get formaturVersion => _formaturVersion;

  Map<BeritaAcaraPemilihanKetuaFormStep, List<FocusErrorField>>
  get _stepErrorFields => {
    BeritaAcaraPemilihanKetuaFormStep.lembaga: [
      FocusErrorField(
        hasError: () => formDataManager.jenisLembaga.isEmpty,
        focusNode: formDataManager.jenisLembagaFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.namaLembaga.isEmpty,
        focusNode: formDataManager.namaLembagaFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.periodeKepengurusan.isEmpty,
        focusNode: formDataManager.periodeKepengurusanFocus,
      ),
    ],
    BeritaAcaraPemilihanKetuaFormStep.pemilihanKetua: [
      FocusErrorField(
        hasError: () => formDataManager.tanggal.isEmpty,
        focusNode: formDataManager.tanggalFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.bulan.isEmpty,
        focusNode: formDataManager.bulanFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.tahun.isEmpty,
        focusNode: formDataManager.tahunFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.waktuPemilihanKetua.isEmpty,
        focusNode: formDataManager.waktuPemilihanKetuaFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.tempatPemilihanKetua.isEmpty,
        focusNode: formDataManager.tempatPemilihanKetuaFocus,
      ),
    ],
    BeritaAcaraPemilihanKetuaFormStep.ketuaTerpilih: [
      FocusErrorField(
        hasError: () => formDataManager.namaKetuaTerpilih.isEmpty,
        focusNode: formDataManager.namaKetuaTerpilihFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.alamatKetuaTerpilih.isEmpty,
        focusNode: formDataManager.alamatKetuaTerpilihFocus,
      ),
      FocusErrorField(
        hasError:
            () =>
                formDataManager.totalSuaraKetuaTerpilihController.text
                    .trim()
                    .isEmpty,
        focusNode: formDataManager.totalSuaraKetuaTerpilihFocus,
      ),
    ],
    BeritaAcaraPemilihanKetuaFormStep.penetapan: [
      FocusErrorField(
        hasError: () => formDataManager.namaWilayah.isEmpty,
        focusNode: formDataManager.namaWilayahFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.tanggalHijriah.isEmpty,
        focusNode: formDataManager.tanggalHijriahFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.tanggalMasehi.isEmpty,
        focusNode: formDataManager.tanggalMasehiFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.waktuPenetapan.isEmpty,
        focusNode: formDataManager.waktuPenetapanFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.namaKetua.isEmpty,
        focusNode: formDataManager.namaKetuaFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.namaSekretaris.isEmpty,
        focusNode: formDataManager.namaSekretarisFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.namaAnggota.isEmpty,
        focusNode: formDataManager.namaAnggotaFocus,
      ),
    ],
  };

  void focusErrorForCurrentStep() {
    final list = _stepErrorFields[currentStep.value];

    if (list != null) {
      FieldErrorFocusHelper.focusFirstErrorField(list);
    }
  }

  void nextStep() {
    if (!validateForm()) {
      final validationResult = formValidator.validateStep(
        currentStep.value,
        formDataManager,
        ttdKetua: ttdKetuaFile.value,
        ttdSekretaris: ttdSekretarisFile.value,
        ttdAnggota: ttdAnggotaFile.value,
      );

      if (!validationResult.isValid) {
        errorMessage.value = validationResult.errorMessage;
      }
      focusErrorForCurrentStep();
      return;
    }
    stepNavigationManager.nextStep();
    clearError();
  }

  void previousStep() {
    stepNavigationManager.previousStep();
    clearError();
  }

  bool canGoNext() => stepNavigationManager.canGoNext;
  bool canGoPrevious() => stepNavigationManager.canGoPrevious;
  bool isLastStep() => stepNavigationManager.isLastStep;

  @override
  Future<void> generateSurat({String? lembaga, String? endpoint}) async {
    if (!validateForm()) return;

    final validationResult = formValidator.validateTandaTanganStep(
      ttdKetua: ttdKetuaFile.value,
      ttdSekretaris: ttdSekretarisFile.value,
      ttdAnggota: ttdAnggotaFile.value,
    );

    if (!validationResult.isValid) {
      errorMessage.value = validationResult.errorMessage;
      return;
    }

    final pencalonanValidation = formValidator.validatePencalonanKetuaStep(
      pencalonanKetua: formDataManager.pencalonanKetua,
      totalSuaraSahPencalonanKetua:
          formDataManager.computedTotalSuaraSahPencalonanKetua.toString(),
      totalSuaraTidakSahPencalonanKetua:
          formDataManager.totalSuaraTidakSahPencalonanKetuaController.text
              .trim(),
    );

    if (!pencalonanValidation.isValid) {
      errorMessage.value = pencalonanValidation.errorMessage;
      return;
    }

    final pemilihanValidation = formValidator.validatePemilihanStep(
      pemilihanKetua: formDataManager.pemilihanKetua,
      totalSuaraSahPemilihanKetua:
          formDataManager.computedTotalSuaraSahPemilihanKetua.toString(),
      totalSuaraTidakSahPemilihanKetua:
          formDataManager.totalSuaraTidakSahPemilihanKetuaController.text
              .trim(),
    );

    if (!pemilihanValidation.isValid) {
      errorMessage.value = pemilihanValidation.errorMessage;
      return;
    }

    final formaturValidation = formValidator.validateFormaturStep(
      formatur: formDataManager.formatur,
    );

    if (!formaturValidation.isValid) {
      errorMessage.value = formaturValidation.errorMessage;
      return;
    }

    try {
      startLoading();

      final entity = formDataManager.toEntity(
        ttdKetuaPath: ttdKetuaFile.value!.path,
        ttdSekretarisPath: ttdSekretarisFile.value!.path,
        ttdAnggotaPath: ttdAnggotaFile.value!.path,
      );

      final file = await _generateBeritaAcaraPemilihanKetuaIpnuUseCase.execute(
        entity,
        onReceiveProgress: updateProgress,
        cancelToken: cancelToken,
      );

      generatedFile.value = file;
      await saveFileToLocal(file);
      showSuccessNotification();
    } on ValidationException catch (e) {
      handleValidationError(e);
    } on DioException catch (e) {
      handleDioError(e);
    } catch (e) {
      handleUnexpectedError(e);
    } finally {
      stopLoading();
    }
  }

  void resetForm() {
    formDataManager.clear();
    ttdKetuaFile.value = null;
    ttdSekretarisFile.value = null;
    ttdAnggotaFile.value = null;
    errorMessage.value = null;
    generatedFile.value = null;
    uploadProgress.value = 0.0;
    stepNavigationManager.reset();
    formKey.currentState?.reset();
  }
}
