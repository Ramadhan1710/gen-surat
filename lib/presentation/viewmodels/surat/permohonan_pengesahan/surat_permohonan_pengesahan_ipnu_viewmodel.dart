import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../core/exception/validation_exception.dart';
import '../../../../core/services/file_operation_service.dart';
import '../../../../core/services/notification_service.dart';
import '../../../../domain/repositories/i_generated_file_repository.dart';
import '../../../../domain/usecases/ipnu/generate_surat_permohonan_pengesahan_ipnu_usecase.dart';
import '../base_surat_viewmodel.dart';
import 'enum/surat_permohonan_pengesahan_form_step.dart';
import 'managers/ipnu/surat_permohonan_pengesahan_form_validator.dart';
import 'managers/ipnu/surat_permohonan_pengesahan_ipnu_form_data_manager.dart';
import 'managers/surat_permohonan_pengesahan_step_navigation_manager.dart';

class SuratPermohonanPengesahanIpnuViewmodel extends BaseSuratViewModel {
  final GenerateSuratPermohonanPengesahanIpnuUseCase
  _generateSuratPermohonanPengesahanIpnuUseCase;

  final SuratPermohonanPengesahanIpnuFormDataManager formDataManager;
  final SuratPermohonanPengesahanIpnuFormValidator formValidator;
  final SuratPermohonanPengesahanStepNavigationManager stepNavigationManager;

  SuratPermohonanPengesahanIpnuViewmodel(
    this._generateSuratPermohonanPengesahanIpnuUseCase,
    IGeneratedFileRepository fileRepository,
    NotificationService notificationService,
    FileOperationService fileOperationService,
  ) : formDataManager = SuratPermohonanPengesahanIpnuFormDataManager(),
      formValidator = SuratPermohonanPengesahanIpnuFormValidator(),
      stepNavigationManager = SuratPermohonanPengesahanStepNavigationManager(),
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
  String get lembagaType => 'IPNU';

  @override
  String getSuratDescription() =>
      'Surat Permohonan Pengesahan IPNU ${formDataManager.namaLembaga}';

  @override
  String getNomorSurat() => formDataManager.nomorSurat;

  @override
  String getNamaLembaga() => formDataManager.namaLembaga;

  Rx<SuratPermohonanPengesahanFormStep> get currentStep =>
      stepNavigationManager.currentStep;
  int get totalSteps => SuratPermohonanPengesahanFormStep.totalSteps;
  List<String> get stepTitles => SuratPermohonanPengesahanFormStep.allTitles;

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

  void nextStep() {
    final validationResult = formValidator.validateStep(
      currentStep.value,
      formDataManager,
      ttdKetua: ttdKetuaFile.value,
      ttdSekretaris: ttdSekretarisFile.value,
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

      final file = await _generateSuratPermohonanPengesahanIpnuUseCase.execute(
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
