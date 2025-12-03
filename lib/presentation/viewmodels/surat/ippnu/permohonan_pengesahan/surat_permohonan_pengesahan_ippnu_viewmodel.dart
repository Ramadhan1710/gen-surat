import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gen_surat/core/helper/field_error_focus_helper.dart';
import 'package:gen_surat/core/validator/email_validator.dart';
import 'package:get/get.dart';

import '../../../../../core/exception/validation_exception.dart';
import '../../../../../core/services/file_operation_service.dart';
import '../../../../../core/services/notification_service.dart';
import '../../../../../domain/repositories/i_generated_file_repository.dart';
import '../../../../../domain/usecases/ippnu/generate_surat_permohonan_pengesahan_ippnu_usecase.dart';
import '../../base_surat_viewmodel.dart';
import 'enum/surat_permohonan_pengesahan_ippnu_form_step.dart';
import 'managers/surat_permohonan_pengesahan_ippnu_form_validator.dart';
import 'managers/surat_permohonan_pengesahan_ippnu_form_data_manager.dart';
import 'managers/surat_permohonan_pengesahan_ippnu_step_navigation_manager.dart';

class SuratPermohonanPengesahanIppnuViewmodel extends BaseSuratViewModel {
  final GenerateSuratPermohonanPengesahanIppnuUseCase
  _generateSuratPermohonanPengesahanIppnuUseCase;

  final SuratPermohonanPengesahanIppnuFormDataManager formDataManager;
  final SuratPermohonanPengesahanIppnuFormValidator formValidator;
  final SuratPermohonanPengesahanIppnuStepNavigationManager
  stepNavigationManager;

  SuratPermohonanPengesahanIppnuViewmodel(
    this._generateSuratPermohonanPengesahanIppnuUseCase,
    IGeneratedFileRepository fileRepository,
    NotificationService notificationService,
    FileOperationService fileOperationService,
  ) : formDataManager = SuratPermohonanPengesahanIppnuFormDataManager(),
      formValidator = SuratPermohonanPengesahanIppnuFormValidator(),
      stepNavigationManager =
          SuratPermohonanPengesahanIppnuStepNavigationManager(),
      super(
        fileRepository: fileRepository,
        notificationService: notificationService,
        fileOperationService: fileOperationService,
      );

  final ttdKetuaFile = Rxn<File>();
  final ttdSekretarisFile = Rxn<File>();

  @override
  String get fileType => 'permohonan_pengesahan';

  @override
  String get lembagaType => 'IPPNU';

  @override
  String getSuratDescription() =>
      'Surat Permohonan Pengesahan IPPNU ${formDataManager.namaLembaga}';

  @override
  String getNomorSurat() => formDataManager.nomorSurat;

  @override
  String getNamaLembaga() => formDataManager.namaLembaga;

  Rx<SuratPermohonanPengesahanIppnuFormStep> get currentStep =>
      stepNavigationManager.currentStep;
  int get totalSteps => SuratPermohonanPengesahanIppnuFormStep.totalSteps;
  List<String> get stepTitles =>
      SuratPermohonanPengesahanIppnuFormStep.allTitles;

  @override
  void onClose() {
    formDataManager.dispose();
    ttdKetuaFile.close();
    ttdSekretarisFile.close();
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

  void removeTtdKetua() => ttdKetuaFile.value = null;
  void removeTtdSekretaris() => ttdSekretarisFile.value = null;

  Map<SuratPermohonanPengesahanIppnuFormStep, List<FocusErrorField>>
  get _stepErrorFields => {
    SuratPermohonanPengesahanIppnuFormStep.lembaga: [
      FocusErrorField(
        hasError: () => formDataManager.jenisLembaga.isEmpty,
        focusNode: formDataManager.jenisLembagaFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.namaLembaga.isEmpty,
        focusNode: formDataManager.namaLembagaFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.telepon.isEmpty,
        focusNode: formDataManager.teleponLembagaFocus,
      ),
      FocusErrorField(
        hasError:
            () =>
                formDataManager.email.isEmpty ||
                !EmailValidator().validate(formDataManager.email).isValid,
        focusNode: formDataManager.emailLembagaFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.alamat.isEmpty,
        focusNode: formDataManager.alamatLembagaFocus,
      ),
    ],
    SuratPermohonanPengesahanIppnuFormStep.surat: [
      FocusErrorField(
        hasError: () => formDataManager.tanggalRapta.isEmpty,
        focusNode: formDataManager.tanggalRaptaFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.nomorRapta.isEmpty,
        focusNode: formDataManager.nomorRaptaFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.tempatRapta.isEmpty,
        focusNode: formDataManager.tempatRaptaFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.tanggalKeputusan.isEmpty,
        focusNode: formDataManager.tanggalKeputusanFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.tanggalHijriah.isEmpty,
        focusNode: formDataManager.tanggalHijriahFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.tanggalMasehi.isEmpty,
        focusNode: formDataManager.tanggalMasehiFocus,
      ),
    ],
    SuratPermohonanPengesahanIppnuFormStep.kepengurusan: [
      FocusErrorField(
        hasError: () => formDataManager.periodeKepengurusan.isEmpty,
        focusNode: formDataManager.periodeKepengurusanFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.namaKetua.isEmpty,
        focusNode: formDataManager.namaKetuaTerpilihFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.namaSekretaris.isEmpty,
        focusNode: formDataManager.namaSekretarisTerpilihFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.namaLembagaInduk.isEmpty,
        focusNode: formDataManager.namaLembagaIndukFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.tingkatLembaga.isEmpty,
        focusNode: formDataManager.tingkatLembagaFocus,
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
    // Trigger UI validation terlebih dahulu
    if (!validateForm()) {
      // Kemudian validasi step-level
      final validationResult = formValidator.validateStep(
        currentStep.value,
        formDataManager,
        ttdKetua: ttdKetuaFile.value,
        ttdSekretaris: ttdSekretarisFile.value,
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
  Future<void> generateSurat() async {
    if (!validateForm()) return;

    final validationResult = formValidator.validateTandaTanganStep(
      ttdKetua: ttdKetuaFile.value,
      ttdSekretaris: ttdSekretarisFile.value,
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
      );

      final file = await _generateSuratPermohonanPengesahanIppnuUseCase.execute(
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
    errorMessage.value = null;
    generatedFile.value = null;
    uploadProgress.value = 0.0;
    stepNavigationManager.reset();
    formKey.currentState?.reset();
  }
}
