import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gen_surat/core/exception/validation_exception.dart';
import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/ipnu/generate_surat_keputusan_ipnu_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/base_surat_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/keputusan/enum/surat_keputusan_form_step.dart';
import 'package:gen_surat/presentation/viewmodels/surat/keputusan/managers/ipnu/surat_keputusan_ipnu_form_data_manager.dart';
import 'package:gen_surat/presentation/viewmodels/surat/keputusan/managers/ipnu/surat_keputusan_ipnu_form_validator.dart';
import 'package:gen_surat/presentation/viewmodels/surat/keputusan/managers/surat_keputusan_step_navigation_manager.dart';
import 'package:get/get.dart';

/// ViewModel untuk Surat Keputusan IPNU
/// Menggunakan pattern yang sama dengan Surat Permohonan Pengesahan
/// dengan 4 step: Lembaga, Surat, Tim Formatur, Tanda Tangan
class SuratKeputusanIpnuViewmodel extends BaseSuratViewModel {
  final GenerateSuratKeputusanIpnuUseCase _generateSuratKeputusanIpnuUseCase;

  // Managers - composition pattern
  final SuratKeputusanIpnuFormDataManager formDataManager;
  final SuratKeputusanIpnuFormValidator formValidator;
  final SuratKeputusanStepNavigationManager stepNavigationManager;

  SuratKeputusanIpnuViewmodel(
    this._generateSuratKeputusanIpnuUseCase,
    IGeneratedFileRepository fileRepository,
    NotificationService notificationService,
    FileOperationService fileOperationService,
  )   : formDataManager = SuratKeputusanIpnuFormDataManager(),
        formValidator = SuratKeputusanIpnuFormValidator(),
        stepNavigationManager = SuratKeputusanStepNavigationManager(),
        super(
          fileRepository: fileRepository,
          notificationService: notificationService,
          fileOperationService: fileOperationService,
        );

  // ========== Specific State ==========
  final ttdKetuaFile = Rxn<File>();
  final ttdSekretarisFile = Rxn<File>();
  final ttdAnggotaFile = Rxn<File>();

  // ========== Override Abstract Properties ==========
  @override
  String get fileType => 'keputusan';

  @override
  String get lembagaType => 'IPNU';

  @override
  String getSuratDescription() =>
      'Surat Keputusan ${formDataManager.namaLembaga}';

  @override
  String getNomorSurat() => formDataManager.nomorSurat;

  @override
  String getNamaLembaga() => formDataManager.namaLembaga;

  // ========== Specific Getters ==========
  Rx<SuratKeputusanFormStep> get currentStep =>
      stepNavigationManager.currentStep;
  int get totalSteps => SuratKeputusanFormStep.totalSteps;
  List<String> get stepTitles => SuratKeputusanFormStep.allTitles;

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

  // ========== Tim Formatur Management ==========
  
  // Observable counter untuk trigger rebuild
  final _timFormaturVersion = 0.obs;

  void addTimFormatur({String nama = '', String daerahPengkaderan = ''}) {
    formDataManager.addTimFormatur(
      nama: nama,
      daerahPengkaderan: daerahPengkaderan,
    );
    _timFormaturVersion.value++; // Trigger update
  }

  void removeTimFormatur(int index) {
    formDataManager.removeTimFormatur(index);
    _timFormaturVersion.value++; // Trigger update
  }

  void updateTimFormatur(int index, {String? nama, String? daerahPengkaderan}) {
    formDataManager.updateTimFormatur(
      index,
      nama: nama,
      daerahPengkaderan: daerahPengkaderan,
    );
    _timFormaturVersion.value++; // Trigger update
  }

  int get timFormaturCount => formDataManager.timFormaturCount;
  List<TimFormaturData> get timFormatur => formDataManager.timFormatur;
  
  // Observable getter for UI
  RxInt get timFormaturVersion => _timFormaturVersion;

  // ========== Navigation Methods ==========

  void nextStep() {
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

    // Specific validation for Surat Keputusan
    final validationResult = formValidator.validateTandaTanganStep(
      ttdKetua: ttdKetuaFile.value,
      ttdSekretaris: ttdSekretarisFile.value,
      ttdAnggota: ttdAnggotaFile.value,
    );

    if (!validationResult.isValid) {
      errorMessage.value = validationResult.errorMessage;
      return;
    }

    // Validate tim formatur
    final timFormaturValidation = formValidator.validationTimFormatur(
      timFormatur: formDataManager.timFormatur,
    );

    if (!timFormaturValidation.isValid) {
      errorMessage.value = timFormaturValidation.errorMessage;
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
      final file = await _generateSuratKeputusanIpnuUseCase.execute(
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

