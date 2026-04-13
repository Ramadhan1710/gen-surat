import 'package:dio/dio.dart';
import 'package:gen_surat/core/exception/validation_exception.dart';
import 'package:gen_surat/core/helper/field_error_focus_helper.dart';
import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/bersama/generate_surat_dispensasi_bersama_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/base_surat_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/dispensasi/enum/surat_dispensasi_bersama_form_step.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/dispensasi/managers/surat_dispensasi_bersama_form_data_manager.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/dispensasi/managers/surat_dispensasi_bersama_form_validator.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/dispensasi/managers/surat_dispensasi_bersama_step_navigation_manager.dart';
import 'package:get/get.dart';

class SuratDispensasiBersamaViewmodel extends BaseSuratViewModel {
  final GenerateSuratDispensasiBersamaUsecase
  _generateSuratDispensasiBersamaUsecase;

  final SuratDispensasiBersamaFormDataManager formDataManager;
  final SuratDispensasiBersamaFormValidator formValidator;
  final SuratDispensasiBersamaStepNavigationManager stepNavigationManager;

  SuratDispensasiBersamaViewmodel(
    this._generateSuratDispensasiBersamaUsecase,
    IGeneratedFileRepository fileRepository,
    NotificationService notificationService,
    FileOperationService fileOperationService,
  ) : formDataManager = SuratDispensasiBersamaFormDataManager(),
      formValidator = SuratDispensasiBersamaFormValidator(),
      stepNavigationManager = SuratDispensasiBersamaStepNavigationManager(),
      super(
        fileRepository: fileRepository,
        notificationService: notificationService,
        fileOperationService: fileOperationService,
      );

  Rx<SuratDispensasiBersamaFormStep> get currentStep =>
      stepNavigationManager.currentStep;
  int get totalSteps => SuratDispensasiBersamaFormStep.totalSteps;
  List<String> get stepTitles => SuratDispensasiBersamaFormStep.allTitles;

  @override
  String get fileType => 'dispensasi_bersama';

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

      final file = await _generateSuratDispensasiBersamaUsecase.execute(
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

  Map<SuratDispensasiBersamaFormStep, List<FocusErrorField>>
  get _stepErrorFields => {
    SuratDispensasiBersamaFormStep.pembuka: [
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
    SuratDispensasiBersamaFormStep.isi: [
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
      FocusErrorField(
        hasError: () => formDataManager.nama.isEmpty,
        focusNode: formDataManager.namaFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.kelasSekolah.isEmpty,
        focusNode: formDataManager.kelasSekolahFocus,
      ),
    ],
    SuratDispensasiBersamaFormStep.penutup: [
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
  String getSuratDescription() => 'Surat Undangan Bersama';

  void resetForm() {
    formDataManager.resetForm();
    errorMessage.value = null;
    generatedFile.value = null;
    uploadProgress.value = 0.0;
    stepNavigationManager.reset();
    formKey.currentState?.reset();
  }
}
