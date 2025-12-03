import 'package:dio/dio.dart';
import 'package:gen_surat/core/exception/validation_exception.dart';
import 'package:gen_surat/core/helper/field_error_focus_helper.dart';
import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/data/mappers/ipnu/curriculum_vitae_mapper.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/ipnu/generate_curriculum_vitae_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/base_surat_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/curriculum_vitae/enum/curriculum_vitae_form_step.dart';
import 'package:gen_surat/presentation/viewmodels/surat/curriculum_vitae/managers/curriculum_vitae_form_data_manager.dart';
import 'package:gen_surat/presentation/viewmodels/surat/curriculum_vitae/managers/curriculum_vitae_form_validator.dart';
import 'package:gen_surat/presentation/viewmodels/surat/curriculum_vitae/managers/curriculum_vitae_step_navigation_manager.dart';
import 'package:get/get.dart';

class CurriculumVitaeViewmodel extends BaseSuratViewModel {
  final GenerateCurriculumVitaeUseCase _generateCurriculumVitaeUseCase;

  // Managers - composition pattern
  final CurriculumVitaeFormDataManager formDataManager;
  final CurriculumVitaeFormValidator formValidator;
  final CurriculumVitaeStepNavigationManager stepNavigationManager;

  CurriculumVitaeViewmodel(
    this._generateCurriculumVitaeUseCase,
    IGeneratedFileRepository fileRepository,
    NotificationService notificationService,
    FileOperationService fileOperationService,
  ) : formDataManager = CurriculumVitaeFormDataManager(),
      formValidator = CurriculumVitaeFormValidator(),
      stepNavigationManager = CurriculumVitaeStepNavigationManager(),
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
  Rx<CurriculumVitaeFormStep> get currentStep =>
      stepNavigationManager.currentStep;
  int get totalSteps => CurriculumVitaeFormStep.totalSteps;
  List<String> get stepTitles => CurriculumVitaeFormStep.allTitles;

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
  Map<CurriculumVitaeFormStep, List<FocusErrorField>> get _stepErrorFields => {
    CurriculumVitaeFormStep.lembaga: [
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
    CurriculumVitaeFormStep.dataKetua: [
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
    CurriculumVitaeFormStep.dataSekretaris: [
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
    CurriculumVitaeFormStep.dataBendahara: [
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
    if (_validateCurrentStep()) {
      stepNavigationManager.nextStep();
    } else {
      focusErrorForCurrentStep();
    }
  }

  void previousStep() {
    stepNavigationManager.previousStep();
  }

  bool _validateCurrentStep() {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    try {
      switch (currentStep.value) {
        case CurriculumVitaeFormStep.organisasiPendidikanKetua:
          if (!formDataManager.hasNoOrganizationKetua &&
              formDataManager.organisasiKetuaList.isEmpty) {
            throw ValidationException(
              'Minimal harus ada 1 pengalaman organisasi ketua atau centang "Tidak ada pengalaman organisasi"',
            );
          }
          if (formDataManager.pendidikanKetuaList.isEmpty) {
            throw ValidationException(
              'Minimal harus ada 1 data pendidikan ketua',
            );
          }
          break;
        case CurriculumVitaeFormStep.dataKetua:
          if (formDataManager.fotoKetuaPath == null) {
            throw ValidationException('Foto ketua harus dipilih');
          }
          break;
        case CurriculumVitaeFormStep.organisasiPendidikanSekretaris:
          if (!formDataManager.hasNoOrganizationSekretaris &&
              formDataManager.organisasiSekretarisList.isEmpty) {
            throw ValidationException(
              'Minimal harus ada 1 pengalaman organisasi sekretaris atau centang "Tidak ada pengalaman organisasi"',
            );
          }
          if (formDataManager.pendidikanSekretarisList.isEmpty) {
            throw ValidationException(
              'Minimal harus ada 1 data pendidikan sekretaris',
            );
          }
          break;
        case CurriculumVitaeFormStep.dataSekretaris:
          if (formDataManager.fotoSekretarisPath == null) {
            throw ValidationException('Foto sekretaris harus dipilih');
          }
          break;
        case CurriculumVitaeFormStep.organisasiPendidikanBendahara:
          if (!formDataManager.hasNoOrganizationBendahara &&
              formDataManager.organisasiBendaharaList.isEmpty) {
            throw ValidationException(
              'Minimal harus ada 1 pengalaman organisasi bendahara atau centang "Tidak ada pengalaman organisasi"',
            );
          }
          if (formDataManager.pendidikanBendaharaList.isEmpty) {
            throw ValidationException(
              'Minimal harus ada 1 data pendidikan bendahara',
            );
          }
          break;
        case CurriculumVitaeFormStep.dataBendahara:
          if (formDataManager.fotoBendaharaPath == null) {
            throw ValidationException('Foto bendahara harus dipilih');
          }
          break;
        default:
          break;
      }
      return true;
    } on ValidationException catch (e) {
      notificationService.showError(e.message);
      return false;
    }
  }

  // ========== Generate CV ==========
  @override
  Future<void> generateSurat() async {
    if (!_validateCurrentStep()) {
      return;
    }

    try {
      startLoading();

      final model = formDataManager.buildModel();
      final entity = CurriculumVitaeMapper.toEntity(model);

      final file = await _generateCurriculumVitaeUseCase.execute(
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
