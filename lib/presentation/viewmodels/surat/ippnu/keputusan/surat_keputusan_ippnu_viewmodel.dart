import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gen_surat/core/helper/field_error_focus_helper.dart';
import 'package:get/get.dart';

import '../../../../../core/exception/validation_exception.dart';
import '../../../../../core/services/file_operation_service.dart';
import '../../../../../core/services/notification_service.dart';
import '../../../../../domain/repositories/i_generated_file_repository.dart';
import '../../../../../domain/usecases/ippnu/generate_surat_keputusan_ippnu_usecase.dart';
import '../../base_surat_viewmodel.dart';
import 'enum/surat_keputusan_ippnu_form_step.dart';
import 'managers/surat_keputusan_ippnu_form_validator.dart';
import 'managers/surat_keputusan_ippnu_form_data_manager.dart';
import 'managers/surat_keputusan_ippnu_step_navigation_manager.dart';

class SuratKeputusanIppnuViewmodel extends BaseSuratViewModel {
  final GenerateSuratKeputusanIppnuUseCase _generateUseCase;

  final SuratKeputusanIppnuFormDataManager formDataManager;
  final SuratKeputusanIppnuFormValidator formValidator;
  final SuratKeputusanIppnuStepNavigationManager stepNavigationManager;

  SuratKeputusanIppnuViewmodel(
    this._generateUseCase,
    IGeneratedFileRepository fileRepository,
    NotificationService notificationService,
    FileOperationService fileOperationService,
  ) : formDataManager = SuratKeputusanIppnuFormDataManager(),
      formValidator = SuratKeputusanIppnuFormValidator(),
      stepNavigationManager = SuratKeputusanIppnuStepNavigationManager(),
      super(
        fileRepository: fileRepository,
        notificationService: notificationService,
        fileOperationService: fileOperationService,
      );

  final ttdKetuaFile = Rxn<File>();
  final ttdSekretarisFile = Rxn<File>();
  final ttdAnggotaFile = Rxn<File>();
  final timFormaturVersion = 0.obs;

  @override
  String get fileType => 'surat_keputusan';

  @override
  String get lembagaType => 'IPPNU';

  @override
  String getSuratDescription() =>
      'Surat Keputusan IPPNU ${formDataManager.namaLembaga}';

  @override
  String getNomorSurat() => formDataManager.nomorSurat;

  @override
  String getNamaLembaga() => formDataManager.namaLembaga;

  Rx<SuratKeputusanIppnuFormStep> get currentStep =>
      stepNavigationManager.currentStep;
  int get totalSteps => SuratKeputusanIppnuFormStep.totalSteps;
  List<String> get stepTitles => SuratKeputusanIppnuFormStep.allTitles;
  List<TimFormaturData> get timFormatur => formDataManager.timFormatur;

  @override
  void onClose() {
    formDataManager.dispose();
    ttdKetuaFile.close();
    ttdSekretarisFile.close();
    ttdAnggotaFile.close();
    timFormaturVersion.close();
    super.onClose();
  }

  void addTimFormatur() {
    formDataManager.addTimFormatur();
    timFormaturVersion.value++;
  }

  void removeTimFormatur(int index) {
    formDataManager.removeTimFormatur(index);
    timFormaturVersion.value++;
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

  Map<SuratKeputusanIppnuFormStep, List<FocusErrorField>>
  get _stepErrorFields => {
    SuratKeputusanIppnuFormStep.lembaga: [
      FocusErrorField(
        hasError: () => formDataManager.periodeRapta.isEmpty,
        focusNode: formDataManager.periodeRaptaFocus,
      ),
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
      FocusErrorField(
        hasError: () => formDataManager.ketuaTerpilih.isEmpty,
        focusNode: formDataManager.ketuaTerpilihFocus,
      ),
    ],
    SuratKeputusanIppnuFormStep.surat: [
      FocusErrorField(
        hasError: () => formDataManager.nomorSurat.isEmpty,
        focusNode: formDataManager.nomorSuratFocus,
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
        hasError: () => formDataManager.namaWilayah.isEmpty,
        focusNode: formDataManager.namaWilayahFocus,
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

    try {
      startLoading();

      final entity = formDataManager.toEntity(
        ttdKetuaPath: ttdKetuaFile.value!.path,
        ttdSekretarisPath: ttdSekretarisFile.value!.path,
        ttdAnggotaPath: ttdAnggotaFile.value!.path,
      );

      final file = await _generateUseCase.execute(
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
