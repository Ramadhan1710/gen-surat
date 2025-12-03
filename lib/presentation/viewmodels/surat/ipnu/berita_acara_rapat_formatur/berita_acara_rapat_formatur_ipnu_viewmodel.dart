import 'package:dio/dio.dart';
import 'package:gen_surat/core/exception/validation_exception.dart';
import 'package:gen_surat/core/helper/field_error_focus_helper.dart';
import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/ipnu/generate_berita_acara_rapat_formatur_ipnu_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/base_surat_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/berita_acara_rapat_formatur/enum/berita_acara_rapat_formatur_ipnu_form_step.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/berita_acara_rapat_formatur/managers/berita_acara_rapat_formatur_ipnu_form_data_manager.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/berita_acara_rapat_formatur/managers/berita_acara_rapat_formatur_ipnu_form_validator.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/berita_acara_rapat_formatur/managers/berita_acara_rapat_formatur_ipnu_step_navigation_manager.dart';
import 'package:get/get.dart';

class BeritaAcaraRapatFormaturIpnuViewmodel extends BaseSuratViewModel {
  final GenerateBeritaAcaraRapatFormaturIpnuUseCase
  _generateBeritaAcaraRapatFormaturIpnuUseCase;

  final BeritaAcaraRapatFormaturIpnuFormDataManager formDataManager;
  final BeritaAcaraRapatFormaturIpnuFormValidator formValidator;
  final BeritaAcaraRapatFormaturIpnuStepNavigationManager stepNavigationManager;

  BeritaAcaraRapatFormaturIpnuViewmodel(
    this._generateBeritaAcaraRapatFormaturIpnuUseCase,
    IGeneratedFileRepository fileRepository,
    NotificationService notificationService,
    FileOperationService fileOperationService,
  ) : formDataManager = BeritaAcaraRapatFormaturIpnuFormDataManager(),
      formValidator = BeritaAcaraRapatFormaturIpnuFormValidator(),
      stepNavigationManager = BeritaAcaraRapatFormaturIpnuStepNavigationManager(),
      super(
        fileRepository: fileRepository,
        notificationService: notificationService,
        fileOperationService: fileOperationService,
      );

  @override
  void onInit() {
    super.onInit();
    // Inisialisasi dengan 2 anggota tim formatur (Ketua Terpilih dan Ketua Demisioner)
    if (formDataManager.timFormaturList.isEmpty) {
      addTimFormatur(); // Ketua Terpilih
      addTimFormatur(); // Ketua Demisioner
    }
  }

  // ========== Specific Getters ==========
  Rx<BeritaAcaraRapatFormaturIpnuFormStep> get currentStep =>
      stepNavigationManager.currentStep;
  int get totalSteps => BeritaAcaraRapatFormaturIpnuFormStep.totalSteps;
  List<String> get stepTitles => BeritaAcaraRapatFormaturIpnuFormStep.allTitles;

  // ========== Override Abstract Properties ==========
  @override
  String get fileType => 'berita_acara_rapat_formatur';

  @override
  String get lembagaType => 'IPNU';

  @override
  String getSuratDescription() =>
      'Berita Acara Rapat Formatur ${formDataManager.jenisLembagaController.text} ${formDataManager.namaLembagaController.text}';

  @override
  String getNomorSurat() => ''; // Berita acara rapat formatur tidak punya nomor surat

  @override
  String getNamaLembaga() => formDataManager.namaLembagaController.text.trim();

  @override
  Future<void> generateSurat() async {
    if (!_validateForm()) return;

    try {
      startLoading();

      final entity = formDataManager.buildEntity();

      final file = await _generateBeritaAcaraRapatFormaturIpnuUseCase.execute(
        entity,
        onReceiveProgress: (received, total) => updateProgress(received, total),
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

  bool _validateForm() {
    // Validasi semua step
    for (final step in BeritaAcaraRapatFormaturIpnuFormStep.values) {
      final validation = formValidator.validateStep(step, formDataManager);
      if (!validation.isValid) {
        handleValidationError(
          ValidationException(validation.errorMessage ?? 'Validasi gagal'),
        );
        focusErrorForCurrentStep();
        return false;
      }
    }

    return true;
  }

  // Tim Formatur Management
  void addTimFormatur() {
    formDataManager.addTimFormatur();
    update();
  }

  void removeTimFormatur(int index) {
    formDataManager.removeTimFormatur(index);
    update();
  }

  void setTtdTimFormatur(int index, String? path) {
    formDataManager.setTtdTimFormatur(index, path);
    update();
  }

  // ========== Step Navigation ==========
  bool canGoNext() => stepNavigationManager.canGoNext();
  bool canGoPrevious() => stepNavigationManager.canGoPrevious();
  bool isLastStep() => stepNavigationManager.isLastStep();

  Map<BeritaAcaraRapatFormaturIpnuFormStep, List<FocusErrorField>>
  get _stepErrorFields => {
    BeritaAcaraRapatFormaturIpnuFormStep.lembaga: [
      FocusErrorField(
        hasError:
            () => formDataManager.jenisLembagaController.text.trim().isEmpty,
        focusNode: formDataManager.jenisLembagaFocus,
      ),
      FocusErrorField(
        hasError:
            () => formDataManager.namaLembagaController.text.trim().isEmpty,
        focusNode: formDataManager.namaLembagaFocus,
      ),
    ],
    BeritaAcaraRapatFormaturIpnuFormStep.waktuTempat: [
      FocusErrorField(
        hasError: () => formDataManager.tanggalController.text.trim().isEmpty,
        focusNode: formDataManager.tanggalFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.bulanController.text.trim().isEmpty,
        focusNode: formDataManager.bulanFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.tahunController.text.trim().isEmpty,
        focusNode: formDataManager.tahunFocus,
      ),
      FocusErrorField(
        hasError:
            () => formDataManager.tempatRapatController.text.trim().isEmpty,
        focusNode: formDataManager.tempatRapatFocus,
      ),
      FocusErrorField(
        hasError:
            () => formDataManager.periodeRaptaController.text.trim().isEmpty,
        focusNode: formDataManager.periodeRaptaFocus,
      ),
      FocusErrorField(
        hasError:
            () => formDataManager.namaWilayahController.text.trim().isEmpty,
        focusNode: formDataManager.namaWilayahFocus,
      ),
      FocusErrorField(
        hasError:
            () => formDataManager.tanggalRapatController.text.trim().isEmpty,
        focusNode: formDataManager.tanggalRapatFocus,
      ),
    ],
    BeritaAcaraRapatFormaturIpnuFormStep.timFormatur: [
      for (int i = 0; i < formDataManager.timFormaturList.length; i++) ...[
        FocusErrorField(
          hasError: () =>
              formDataManager.timFormaturList[i].namaController.text
                  .trim()
                  .isEmpty,
          focusNode: formDataManager.timFormaturList[i].namaFocus,
        ),
        FocusErrorField(
          hasError: () =>
              formDataManager.timFormaturList[i].jabatanController.text
                  .trim()
                  .isEmpty,
          focusNode: formDataManager.timFormaturList[i].jabatanFocus,
        ),
      ],
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
    // Clear error message saat kembali
    errorMessage.value = null;
    stepNavigationManager.previousStep();
  }

  void resetForm() {
    formDataManager.resetForm();
    stepNavigationManager.reset();
    generatedFile.value = null;
    errorMessage.value = null;
    update();
  }

  @override
  void onClose() {
    formDataManager.dispose();
    super.onClose();
  }
}
