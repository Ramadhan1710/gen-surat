import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gen_surat/core/exception/validation_exception.dart';
import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/ipnu/generate_berita_acara_pemilihan_ketua_ipnu_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/base_surat_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_pemilihan_ketua/enum/berita_acara_pemilihan_ketua_form_step.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_pemilihan_ketua/managers/ipnu/berita_acara_pemilihan_ketua_ipnu_form_data_manager.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_pemilihan_ketua/managers/ipnu/berita_acara_pemilihan_ketua_ipnu_form_validator.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_pemilihan_ketua/managers/berita_acara_pemilihan_ketua_step_navigation_manager.dart';
import 'package:get/get.dart';

/// ViewModel untuk Berita Acara Pemilihan Ketua IPNU
/// Menggunakan pattern composition dengan 8 step form
class BeritaAcaraPemilihanKetuaIpnuViewmodel extends BaseSuratViewModel {
  final GenerateBeritaAcaraPemilihanKetuaIpnuUseCase
      _generateBeritaAcaraPemilihanKetuaIpnuUseCase;

  // Managers - composition pattern
  final BeritaAcaraPemilihanKetuaIpnuFormDataManager formDataManager;
  final BeritaAcaraPemilihanKetuaIpnuFormValidator formValidator;
  final BeritaAcaraPemilihanKetuaStepNavigationManager stepNavigationManager;

  BeritaAcaraPemilihanKetuaIpnuViewmodel(
    this._generateBeritaAcaraPemilihanKetuaIpnuUseCase,
    IGeneratedFileRepository fileRepository,
    NotificationService notificationService,
    FileOperationService fileOperationService,
  )   : formDataManager = BeritaAcaraPemilihanKetuaIpnuFormDataManager(),
        formValidator = BeritaAcaraPemilihanKetuaIpnuFormValidator(),
        stepNavigationManager =
            BeritaAcaraPemilihanKetuaStepNavigationManager(),
        super(
          fileRepository: fileRepository,
          notificationService: notificationService,
          fileOperationService: fileOperationService,
        ) {
    // Setup listeners for real-time total update
    formDataManager.setOnPencalonanSuaraChangedListener(() {
      _pencalonanKetuaVersion.value++;
    });
    formDataManager.setOnPemilihanSuaraChangedListener(() {
      _pemilihanKetuaVersion.value++;
    });
  }

  // ========== Specific State ==========
  final ttdKetuaFile = Rxn<File>();
  final ttdSekretarisFile = Rxn<File>();
  final ttdAnggotaFile = Rxn<File>();

  // Observable counters for array rebuilds
  final _pencalonanKetuaVersion = 0.obs;
  final _pemilihanKetuaVersion = 0.obs;
  final _formaturVersion = 0.obs;

  // ========== Override Abstract Properties ==========
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

  // ========== Specific Getters ==========
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

  // ========== File Management ==========

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

  // ========== Pencalonan Ketua Management ==========

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

  // ========== Pemilihan Ketua Management ==========

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

  // ========== Formatur Management ==========

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

  // ========== Navigation Methods ==========

  void nextStep() {
    // Validate form fields first
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Then validate step-specific logic
    final validationResult = formValidator.validateStep(
      currentStep.value,
      formDataManager,
      ttdKetua: ttdKetuaFile.value,
      ttdSekretaris: ttdSekretarisFile.value,
      ttdAnggota: ttdAnggotaFile.value,
    );

    if (validationResult.isValid) {
      stepNavigationManager.nextStep();
      clearError();
    } else {
      errorMessage.value = validationResult.errorMessage;
    }
  }

  void previousStep() {
    stepNavigationManager.previousStep();
    clearError();
  }

  bool canGoNext() => stepNavigationManager.canGoNext;
  bool canGoPrevious() => stepNavigationManager.canGoPrevious;
  bool isLastStep() => stepNavigationManager.isLastStep;

  // ========== Override: Main Action ==========

  @override
  Future<void> generateSurat() async {
    // Validate form
    if (!validateForm()) return;

    // Specific validation for Berita Acara
    final validationResult = formValidator.validateTandaTanganStep(
      ttdKetua: ttdKetuaFile.value,
      ttdSekretaris: ttdSekretarisFile.value,
      ttdAnggota: ttdAnggotaFile.value,
    );

    if (!validationResult.isValid) {
      errorMessage.value = validationResult.errorMessage;
      return;
    }

    // Validate pencalonan ketua
    final pencalonanValidation = formValidator.validatePencalonanKetuaStep(
      pencalonanKetua: formDataManager.pencalonanKetua,
      totalSuaraSahPencalonanKetua:
        formDataManager.computedTotalSuaraSahPencalonanKetua.toString(),
      totalSuaraTidakSahPencalonanKetua: formDataManager
          .totalSuaraTidakSahPencalonanKetuaController.text
          .trim(),
    );

    if (!pencalonanValidation.isValid) {
      errorMessage.value = pencalonanValidation.errorMessage;
      return;
    }

    // Validate pemilihan ketua
    final pemilihanValidation = formValidator.validatePemilihanStep(
      pemilihanKetua: formDataManager.pemilihanKetua,
      totalSuaraSahPemilihanKetua:
        formDataManager.computedTotalSuaraSahPemilihanKetua.toString(),
      totalSuaraTidakSahPemilihanKetua:
          formDataManager.totalSuaraTidakSahPemilihanKetuaController.text.trim(),
    );

    if (!pemilihanValidation.isValid) {
      errorMessage.value = pemilihanValidation.errorMessage;
      return;
    }

    // Validate formatur
    final formaturValidation = formValidator.validateFormaturStep(
      formatur: formDataManager.formatur,
    );

    if (!formaturValidation.isValid) {
      errorMessage.value = formaturValidation.errorMessage;
      return;
    }

    try {
      startLoading();

      // Prepare entity
      final entity = formDataManager.toEntity(
        ttdKetuaPath: ttdKetuaFile.value!.path,
        ttdSekretarisPath: ttdSekretarisFile.value!.path,
        ttdAnggotaPath: ttdAnggotaFile.value!.path,
      );

      // Execute usecase
      final file =
          await _generateBeritaAcaraPemilihanKetuaIpnuUseCase.execute(
        entity,
        onReceiveProgress: updateProgress,
        cancelToken: cancelToken,
      );

      // Save result
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

  // ========== Reset Form ==========

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
