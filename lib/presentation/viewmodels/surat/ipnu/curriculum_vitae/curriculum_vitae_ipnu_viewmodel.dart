import 'package:dio/dio.dart';
import 'package:gen_surat/core/exception/validation_exception.dart';
import 'package:gen_surat/core/helper/field_error_focus_helper.dart';
import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/data/mappers/ipnu/curriculum_vitae_ipnu_mapper.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/ipnu/generate_curriculum_vitae_ipnu_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/base_surat_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/curriculum_vitae/enum/curriculum_vitae_ipnu_form_step.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/curriculum_vitae/managers/curriculum_vitae_ipnu_form_data_manager.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/curriculum_vitae/managers/curriculum_vitae_ipnu_form_validator.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/curriculum_vitae/managers/curriculum_vitae_ipnu_step_navigation_manager.dart';
import 'package:get/get.dart';

class CurriculumVitaeIpnuViewmodel extends BaseSuratViewModel {
  final GenerateCurriculumVitaeIpnuUseCase _generateCurriculumVitaeIpnuUseCase;

  // Managers - composition pattern
  final CurriculumVitaeIpnuFormDataManager formDataManager;
  final CurriculumVitaeIpnuFormValidator formValidator;
  final CurriculumVitaeIpnuStepNavigationManager stepNavigationManager;

  CurriculumVitaeIpnuViewmodel(
    this._generateCurriculumVitaeIpnuUseCase,
    IGeneratedFileRepository fileRepository,
    NotificationService notificationService,
    FileOperationService fileOperationService,
  ) : formDataManager = CurriculumVitaeIpnuFormDataManager(),
      formValidator = CurriculumVitaeIpnuFormValidator(),
      stepNavigationManager = CurriculumVitaeIpnuStepNavigationManager(),
      super(
        fileRepository: fileRepository,
        notificationService: notificationService,
        fileOperationService: fileOperationService,
      );

  // ========== Observable Counters untuk Array Rebuilds ==========
  final _organisasiKetuaVersion = 0.obs;
  final _pendidikanKetuaVersion = 0.obs;
  final _organisasiSekretarisVersion = 0.obs;
  final _pendidikanSekretarisVersion = 0.obs;
  final _organisasiBendaharaVersion = 0.obs;
  final _pendidikanBendaharaVersion = 0.obs;

  // Getters for version counters
  Rx<int> get organisasiKetuaVersion => _organisasiKetuaVersion;
  Rx<int> get pendidikanKetuaVersion => _pendidikanKetuaVersion;
  Rx<int> get organisasiSekretarisVersion => _organisasiSekretarisVersion;
  Rx<int> get pendidikanSekretarisVersion => _pendidikanSekretarisVersion;
  Rx<int> get organisasiBendaharaVersion => _organisasiBendaharaVersion;
  Rx<int> get pendidikanBendaharaVersion => _pendidikanBendaharaVersion;

  // ========== Override Abstract Properties ==========
  @override
  String get fileType => 'curriculum_vitae';

  @override
  String get lembagaType => 'IPNU';

  @override
  String getSuratDescription() =>
      'CV Pengurus Harian ${formDataManager.namaLembaga}';

  @override
  String getNomorSurat() => ''; // CV tidak punya nomor surat

  @override
  String getNamaLembaga() => formDataManager.namaLembaga;

  // ========== Specific Getters ==========
  Rx<CurriculumVitaeIpnuFormStep> get currentStep =>
      stepNavigationManager.currentStep;
  int get totalSteps => CurriculumVitaeIpnuFormStep.totalSteps;
  List<String> get stepTitles => CurriculumVitaeIpnuFormStep.allTitles;

  // Navigation helpers
  bool canGoPrevious() => stepNavigationManager.canGoPrevious;
  bool canGoNext() => stepNavigationManager.canGoNext;
  bool isLastStep() => stepNavigationManager.isLastStep;

  @override
  void onClose() {
    formDataManager.dispose();
    super.onClose();
  }

  // ========== Organisasi Ketua Management ==========
  void toggleNoOrganizationKetua(bool value) {
    formDataManager.hasNoOrganizationKetua = value;
    if (value) {
      // Clear organisasi list when checkbox is checked
      while (formDataManager.organisasiKetuaList.isNotEmpty) {
        removeOrganisasiKetua(0);
      }
    }
    _organisasiKetuaVersion.value++;
    update();
  }

  void addOrganisasiKetua() {
    formDataManager.addOrganisasiKetua();
    _organisasiKetuaVersion.value++;
  }

  void removeOrganisasiKetua(int index) {
    formDataManager.removeOrganisasiKetua(index);
    _organisasiKetuaVersion.value++;
  }

  // ========== Pendidikan Ketua Management ==========
  void addPendidikanKetua() {
    formDataManager.addPendidikanKetua();
    _pendidikanKetuaVersion.value++;
  }

  void removePendidikanKetua(int index) {
    formDataManager.removePendidikanKetua(index);
    _pendidikanKetuaVersion.value++;
  }

  // ========== Organisasi Sekretaris Management ==========
  void toggleNoOrganizationSekretaris(bool value) {
    formDataManager.hasNoOrganizationSekretaris = value;
    if (value) {
      // Clear organisasi list when checkbox is checked
      while (formDataManager.organisasiSekretarisList.isNotEmpty) {
        removeOrganisasiSekretaris(0);
      }
    }
    _organisasiSekretarisVersion.value++;
    update();
  }

  void addOrganisasiSekretaris() {
    formDataManager.addOrganisasiSekretaris();
    _organisasiSekretarisVersion.value++;
  }

  void removeOrganisasiSekretaris(int index) {
    formDataManager.removeOrganisasiSekretaris(index);
    _organisasiSekretarisVersion.value++;
  }

  // ========== Pendidikan Sekretaris Management ==========
  void addPendidikanSekretaris() {
    formDataManager.addPendidikanSekretaris();
    _pendidikanSekretarisVersion.value++;
  }

  void removePendidikanSekretaris(int index) {
    formDataManager.removePendidikanSekretaris(index);
    _pendidikanSekretarisVersion.value++;
  }

  // ========== Organisasi Bendahara Management ==========
  void toggleNoOrganizationBendahara(bool value) {
    formDataManager.hasNoOrganizationBendahara = value;
    if (value) {
      // Clear organisasi list when checkbox is checked
      while (formDataManager.organisasiBendaharaList.isNotEmpty) {
        removeOrganisasiBendahara(0);
      }
    }
    _organisasiBendaharaVersion.value++;
    update();
  }

  void addOrganisasiBendahara() {
    formDataManager.addOrganisasiBendahara();
    _organisasiBendaharaVersion.value++;
  }

  void removeOrganisasiBendahara(int index) {
    formDataManager.removeOrganisasiBendahara(index);
    _organisasiBendaharaVersion.value++;
  }

  // ========== Pendidikan Bendahara Management ==========
  void addPendidikanBendahara() {
    formDataManager.addPendidikanBendahara();
    _pendidikanBendaharaVersion.value++;
  }

  void removePendidikanBendahara(int index) {
    formDataManager.removePendidikanBendahara(index);
    _pendidikanBendaharaVersion.value++;
  }

  // ========== Image Picker ==========
  // Note: Foto akan dipilih menggunakan ImagePickerHelper dari widget
  void setFotoKetua(String path) {
    formDataManager.fotoKetuaPath = path;
    update();
  }

  void setFotoSekretaris(String path) {
    formDataManager.fotoSekretarisPath = path;
    update();
  }

  void setFotoBendahara(String path) {
    formDataManager.fotoBendaharaPath = path;
    update();
  }

  void removeFotoKetua() {
    formDataManager.fotoKetuaPath = null;
    update();
  }

  void removeFotoSekretaris() {
    formDataManager.fotoSekretarisPath = null;
    update();
  }

  void removeFotoBendahara() {
    formDataManager.fotoBendaharaPath = null;
    update();
  }

  // ========== Navigation Methods ==========
  Map<CurriculumVitaeIpnuFormStep, List<FocusErrorField>> get _stepErrorFields => {
    CurriculumVitaeIpnuFormStep.lembaga: [
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
    CurriculumVitaeIpnuFormStep.dataKetua: [
      FocusErrorField(
        hasError: () => formDataManager.namaKetuaController.text.trim().isEmpty,
        focusNode: formDataManager.namaKetuaFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.ttlKetuaController.text.trim().isEmpty,
        focusNode: formDataManager.ttlKetuaFocus,
      ),
      FocusErrorField(
        hasError:
            () => formDataManager.alamatKetuaController.text.trim().isEmpty,
        focusNode: formDataManager.alamatKetuaFocus,
      ),
    ],
    CurriculumVitaeIpnuFormStep.dataSekretaris: [
      FocusErrorField(
        hasError:
            () => formDataManager.namaSekretarisController.text.trim().isEmpty,
        focusNode: formDataManager.namaSekretarisFocus,
      ),
      FocusErrorField(
        hasError:
            () => formDataManager.ttlSekretarisController.text.trim().isEmpty,
        focusNode: formDataManager.ttlSekretarisFocus,
      ),
      FocusErrorField(
        hasError:
            () =>
                formDataManager.alamatSekretarisController.text.trim().isEmpty,
        focusNode: formDataManager.alamatSekretarisFocus,
      ),
    ],
    CurriculumVitaeIpnuFormStep.dataBendahara: [
      FocusErrorField(
        hasError:
            () => formDataManager.namaBendaharaController.text.trim().isEmpty,
        focusNode: formDataManager.namaBendaharaFocus,
      ),
      FocusErrorField(
        hasError:
            () => formDataManager.ttlBendaharaController.text.trim().isEmpty,
        focusNode: formDataManager.ttlBendaharaFocus,
      ),
      FocusErrorField(
        hasError:
            () => formDataManager.alamatBendaharaController.text.trim().isEmpty,
        focusNode: formDataManager.alamatBendaharaFocus,
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
  }

  void previousStep() {
    stepNavigationManager.previousStep();
  }

  // ========== Generate CV ==========
  @override
  Future<void> generateSurat() async {
    // Validasi semua step sebelum generate
    for (final step in CurriculumVitaeIpnuFormStep.values) {
      final validation = formValidator.validateStep(step, formDataManager);
      if (!validation.isValid) {
        handleValidationError(
          ValidationException(validation.errorMessage ?? 'Validasi gagal'),
        );
        return;
      }
    }

    try {
      startLoading();

      final model = formDataManager.buildModel();
      final entity = CurriculumVitaeIpnuMapper.toEntity(model);

      final file = await _generateCurriculumVitaeIpnuUseCase.execute(
        entity,
        onReceiveProgress: updateProgress,
        cancelToken: cancelToken,
      );

      // Save to local database
      await saveFileToLocal(file);

      // Set generated file
      generatedFile.value = file;

      // Show success notification
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
    formDataManager.resetForm();
    stepNavigationManager.resetToFirstStep();
    formKey.currentState?.reset();

    // Reset counters
    _organisasiKetuaVersion.value = 0;
    _pendidikanKetuaVersion.value = 0;
    _organisasiSekretarisVersion.value = 0;
    _pendidikanSekretarisVersion.value = 0;
    _organisasiBendaharaVersion.value = 0;
    _pendidikanBendaharaVersion.value = 0;

    generatedFile.value = null;
    errorMessage.value = null;
  }
}
