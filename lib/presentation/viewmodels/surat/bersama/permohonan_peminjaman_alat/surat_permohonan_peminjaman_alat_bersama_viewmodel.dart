import 'package:dio/dio.dart';
import 'package:gen_surat/core/exception/validation_exception.dart';
import 'package:gen_surat/core/helper/field_error_focus_helper.dart';
import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/bersama/generate_surat_permohonan_peminjaman_alat_bersama_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/base_surat_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/permohonan_peminjaman_alat/enum/surat_permohonan_peminjaman_alat_bersama_form_step.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/permohonan_peminjaman_alat/managers/surat_permohonan_peminjaman_alat_bersama_form_data_manager.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/permohonan_peminjaman_alat/managers/surat_permohonan_peminjaman_alat_bersama_form_validator.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/permohonan_peminjaman_alat/managers/surat_permohonan_peminjaman_alat_bersama_step_navigation_manager.dart';
import 'package:get/get.dart';

class SuratPermohonanPeminjamanAlatBersamaViewmodel extends BaseSuratViewModel {
  final GenerateSuratPermohonanPeminjamanAlatBersamaUsecase
  _generateSuratPermohonanPeminjamanAlatBersamaUsecase;

  final SuratPermohonanPeminjamanAlatBersamaFormDataManager formDataManager;
  final SuratPermohonanPeminjamanAlatBersamaFormValidator formValidator;
  final SuratPermohonanPeminjamanAlatBersamaStepNavigationManager stepNavigationManager;

  SuratPermohonanPeminjamanAlatBersamaViewmodel(
    this._generateSuratPermohonanPeminjamanAlatBersamaUsecase,
    IGeneratedFileRepository fileRepository,
    NotificationService notificationService,
    FileOperationService fileOperationService,
  ) : formDataManager = SuratPermohonanPeminjamanAlatBersamaFormDataManager(),
      formValidator = SuratPermohonanPeminjamanAlatBersamaFormValidator(),
      stepNavigationManager = SuratPermohonanPeminjamanAlatBersamaStepNavigationManager(),
      super(
        fileRepository: fileRepository,
        notificationService: notificationService,
        fileOperationService: fileOperationService,
      );

  Rx<SuratPermohonanPeminjamanAlatBersamaFormStep> get currentStep =>
      stepNavigationManager.currentStep;
  int get totalSteps => SuratPermohonanPeminjamanAlatBersamaFormStep.totalSteps;
  List<String> get stepTitles => SuratPermohonanPeminjamanAlatBersamaFormStep.allTitles;

  @override
  String get fileType => 'permohonan_peminjaman_alat_bersama';

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

      final file = await _generateSuratPermohonanPeminjamanAlatBersamaUsecase.execute(
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

  Map<SuratPermohonanPeminjamanAlatBersamaFormStep, List<FocusErrorField>>
  get _stepErrorFields => {
    SuratPermohonanPeminjamanAlatBersamaFormStep.pembuka: [
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
    SuratPermohonanPeminjamanAlatBersamaFormStep.isi: [
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
        hasError: () => formDataManager.alat.isEmpty,
        focusNode: formDataManager.alatFocus,
      ),
    ],
    SuratPermohonanPeminjamanAlatBersamaFormStep.penutup: [
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
  String getSuratDescription() => 'Surat Permohonan Peminjaman Alat Bersama';

  void resetForm() {
    formDataManager.resetForm();
    errorMessage.value = null;
    generatedFile.value = null;
    uploadProgress.value = 0.0;
    stepNavigationManager.reset();
    formKey.currentState?.reset();
  }
}
