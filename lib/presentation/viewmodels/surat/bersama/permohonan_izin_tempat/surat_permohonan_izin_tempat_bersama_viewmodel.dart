import 'package:dio/dio.dart';
import 'package:gen_surat/core/exception/validation_exception.dart';
import 'package:gen_surat/core/helper/field_error_focus_helper.dart';
import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/bersama/generate_surat_permohonan_izin_tempat_bersama_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/base_surat_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/permohonan_izin_tempat/enum/surat_permohonan_izin_tempat_bersama_form_step.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/permohonan_izin_tempat/managers/surat_permohonan_izin_tempat_bersama_form_data_manager.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/permohonan_izin_tempat/managers/surat_permohonan_izin_tempat_bersama_form_validator.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/permohonan_izin_tempat/managers/surat_permohonan_izin_tempat_bersama_step_navigation_manager.dart';
import 'package:get/get.dart';

class SuratPermohonanIzinTempatBersamaViewmodel extends BaseSuratViewModel {
  final GenerateSuratPermohonanIzinTempatBersamaUsecase
  _generateSuratPermohonanIzinTempatBersamaUsecase;

  final SuratPermohonanIzinTempatBersamaFormDataManager formDataManager;
  final SuratPermohonanIzinTempatBersamaFormValidator formValidator;
  final SuratPermohonanIzinTempatBersamaStepNavigationManager stepNavigationManager;

  SuratPermohonanIzinTempatBersamaViewmodel(
    this._generateSuratPermohonanIzinTempatBersamaUsecase,
    IGeneratedFileRepository fileRepository,
    NotificationService notificationService,
    FileOperationService fileOperationService,
  ) : formDataManager = SuratPermohonanIzinTempatBersamaFormDataManager(),
      formValidator = SuratPermohonanIzinTempatBersamaFormValidator(),
      stepNavigationManager = SuratPermohonanIzinTempatBersamaStepNavigationManager(),
      super(
        fileRepository: fileRepository,
        notificationService: notificationService,
        fileOperationService: fileOperationService,
      );

  Rx<SuratPermohonanIzinTempatBersamaFormStep> get currentStep =>
      stepNavigationManager.currentStep;
  int get totalSteps => SuratPermohonanIzinTempatBersamaFormStep.totalSteps;
  List<String> get stepTitles => SuratPermohonanIzinTempatBersamaFormStep.allTitles;

  @override
  String get fileType => 'permohonan_izin_tempat_bersama';

  @override
  String get lembagaType => 'Bersama';

  @override
  Future<void> generateSurat({String? jenisSurat, String? endpoint}) async {
    if (!validateForm()) return;

    final valudationResult = formValidator.validateStep(
      currentStep.value,
      formDataManager,
    );

    if (!valudationResult.isValid) {
      errorMessage.value = valudationResult.errorMessage;
      return;
    }

    try {
      startLoading();

      final file = await _generateSuratPermohonanIzinTempatBersamaUsecase.execute(
        formDataManager.toEntity(),
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

  Map<SuratPermohonanIzinTempatBersamaFormStep, List<FocusErrorField>>
  get _stepErrorFields => {
    SuratPermohonanIzinTempatBersamaFormStep.pembuka: [
      FocusErrorField(
        hasError: () => formDataManager.nomorSurat.isEmpty,
        focusNode: formDataManager.nomorSuratFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.lampiran.isEmpty,
        focusNode: formDataManager.lampiranFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.tujuanSurat.isEmpty,
        focusNode: formDataManager.tujuanSuratFocus,
      ),
    ],
    SuratPermohonanIzinTempatBersamaFormStep.isi: [
      FocusErrorField(
        hasError: () => formDataManager.namaKegiatan.isEmpty,
        focusNode: formDataManager.namaKegiatanFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.tempat.isEmpty,
        focusNode: formDataManager.tempatFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.hariTanggal.isEmpty,
        focusNode: formDataManager.hariTanggalFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.waktu.isEmpty,
        focusNode: formDataManager.waktuFocus,
      ),
    ],
    SuratPermohonanIzinTempatBersamaFormStep.penutup: [
      FocusErrorField(
        hasError: () => formDataManager.tanggalHijriah.isEmpty,
        focusNode: formDataManager.tanggalHijriahFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.tanggalMasehi.isEmpty,
        focusNode: formDataManager.tanggalMasehiFocus,
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
  void onClose() {
    formDataManager.dispose();
    super.onClose();
  }

  @override
  String getNamaLembaga() => 'Bersama';

  @override
  String getNomorSurat() => formDataManager.nomorSuratController.text.trim();

  @override
  String getSuratDescription() => 'Surat Permohonan Izin Tempat Bersama';

  void resetForm() {
    formDataManager.resetForm();
    errorMessage.value = null;
    generatedFile.value = null;
    uploadProgress.value = 0.0;
    stepNavigationManager.reset();
    formKey.currentState?.reset();
  }
}
