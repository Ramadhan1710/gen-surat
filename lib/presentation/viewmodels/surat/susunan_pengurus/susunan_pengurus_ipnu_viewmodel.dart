import 'package:gen_surat/core/exception/validation_exception.dart';
import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/ipnu/generate_susunan_pengurus_ipnu_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/base_surat_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/susunan_pengurus/enum/susunan_pengurus_form_step.dart';
import 'package:gen_surat/presentation/viewmodels/surat/susunan_pengurus/managers/ipnu/susunan_pengurus_ipnu_form_data_manager.dart';
import 'package:gen_surat/presentation/viewmodels/surat/susunan_pengurus/managers/ipnu/susunan_pengurus_ipnu_form_validator.dart';
import 'package:gen_surat/presentation/viewmodels/surat/susunan_pengurus/managers/susunan_pengurus_step_navigation_manager.dart';
import 'package:get/get.dart';

class SusunanPengurusIpnuViewmodel extends BaseSuratViewModel {
  final GenerateSusunanPengurusIpnuUseCase _generateSusunanPengurusIpnuUseCase;

  // Managers - composition pattern
  final SusunanPengurusIpnuFormDataManager formDataManager;
  final SusunanPengurusIpnuFormValidator formValidator;
  final SusunanPengurusStepNavigationManager stepNavigationManager;

  SusunanPengurusIpnuViewmodel(
    this._generateSusunanPengurusIpnuUseCase,
    IGeneratedFileRepository fileRepository,
    NotificationService notificationService,
    FileOperationService fileOperationService,
  ) : formDataManager = SusunanPengurusIpnuFormDataManager(),
      formValidator = SusunanPengurusIpnuFormValidator(),
      stepNavigationManager = SusunanPengurusStepNavigationManager(),
      super(
        fileRepository: fileRepository,
        notificationService: notificationService,
        fileOperationService: fileOperationService,
      );

  // ========== Observable Counters untuk Array Rebuilds ==========
  final _pembinaVersion = 0.obs;
  final _wakilKetuaVersion = 0.obs;
  final _wakilSekretarisVersion = 0.obs;
  final _departemenVersion = 0.obs;
  final _lembagaVersion = 0.obs;
  final _divisiVersion = 0.obs;

  // Getters for version counters
  Rx<int> get departemenVersion => _departemenVersion;
  Rx<int> get pembinaVersion => _pembinaVersion;
  Rx<int> get wakilKetuaVersion => _wakilKetuaVersion;
  Rx<int> get wakilSekretarisVersion => _wakilSekretarisVersion;
  Rx<int> get lembagaVersion => _lembagaVersion;
  Rx<int> get divisiVersion => _divisiVersion;

  // ========== Override Abstract Properties ==========
  @override
  String get fileType => 'susunan_pengurus';

  @override
  String get lembagaType => 'IPNU';

  @override
  String getSuratDescription() =>
      'Susunan Pengurus ${formDataManager.namaLembaga}';

  @override
  String getNomorSurat() => ''; // Susunan pengurus tidak punya nomor surat

  @override
  String getNamaLembaga() => formDataManager.namaLembaga;

  // ========== Specific Getters ==========
  Rx<SusunanPengurusFormStep> get currentStep =>
      stepNavigationManager.currentStep;
  int get totalSteps => SusunanPengurusFormStep.totalSteps;
  List<String> get stepTitles => SusunanPengurusFormStep.allTitles;

  // Navigation helpers
  bool canGoPrevious() => stepNavigationManager.canGoPrevious;
  bool canGoNext() => stepNavigationManager.canGoNext;
  bool isLastStep() => stepNavigationManager.isLastStep;

  @override
  void onClose() {
    formDataManager.dispose();
    super.onClose();
  }

  // ========== Pembina Management ==========
  void addPembina() {
    formDataManager.addPembina();
    _pembinaVersion.value++;
  }

  void removePembina(int index) {
    formDataManager.removePembina(index);
    _pembinaVersion.value++;
  }

  // ========== Wakil Ketua Management ==========
  void addWakilKetua() {
    formDataManager.addWakilKetua();
    _wakilKetuaVersion.value++;
  }

  void removeWakilKetua(int index) {
    formDataManager.removeWakilKetua(index);
    _wakilKetuaVersion.value++;
  }

  // ========== Wakil Sekretaris Management ==========
  void addWakilSekretaris() {
    formDataManager.addWakilSekretaris();
    _wakilSekretarisVersion.value++;
  }

  void removeWakilSekretaris(int index) {
    formDataManager.removeWakilSekretaris(index);
    _wakilSekretarisVersion.value++;
  }

  // ========== Departemen Management ==========
  void addDepartemen() {
    formDataManager.addDepartemen();
    _departemenVersion.value++;
  }

  void removeDepartemen(int index) {
    formDataManager.removeDepartemen(index);
    _departemenVersion.value++;
  }

  void addAnggotaDepartemen(int departemenIndex) {
    if (departemenIndex >= 0 &&
        departemenIndex < formDataManager.departemen.length) {
      formDataManager.departemen[departemenIndex].addAnggota();
      _departemenVersion.value++;
    }
  }

  void removeAnggotaDepartemen(int departemenIndex, int anggotaIndex) {
    if (departemenIndex >= 0 &&
        departemenIndex < formDataManager.departemen.length) {
      formDataManager.departemen[departemenIndex].removeAnggota(anggotaIndex);
      _departemenVersion.value++;
    }
  }

  // ========== Lembaga Management ==========
  void addLembaga() {
    formDataManager.addLembaga();
    _lembagaVersion.value++;
  }

  void removeLembaga(int index) {
    formDataManager.removeLembaga(index);
    _lembagaVersion.value++;
  }

  void addAnggotaLembaga(int lembagaIndex) {
    if (lembagaIndex >= 0 &&
        lembagaIndex < formDataManager.lembagaInternal.length) {
      formDataManager.lembagaInternal[lembagaIndex].addAnggota();
      _lembagaVersion.value++;
    }
  }

  void removeAnggotaLembaga(int lembagaIndex, int anggotaIndex) {
    if (lembagaIndex >= 0 &&
        lembagaIndex < formDataManager.lembagaInternal.length) {
      formDataManager.lembagaInternal[lembagaIndex].removeAnggota(anggotaIndex);
      _lembagaVersion.value++;
    }
  }

  // ========== Divisi Management ==========
  void addDivisi() {
    formDataManager.addDivisi();
    _divisiVersion.value++;
  }

  void removeDivisi(int index) {
    formDataManager.removeDivisi(index);
    _divisiVersion.value++;
  }

  void addAnggotaDivisi(int divisiIndex) {
    if (divisiIndex >= 0 && divisiIndex < formDataManager.divisi.length) {
      formDataManager.divisi[divisiIndex].addAnggota();
      _divisiVersion.value++;
    }
  }

  void removeAnggotaDivisi(int divisiIndex, int anggotaIndex) {
    if (divisiIndex >= 0 && divisiIndex < formDataManager.divisi.length) {
      formDataManager.divisi[divisiIndex].removeAnggota(anggotaIndex);
      _divisiVersion.value++;
    }
  }

  // ========== Navigation ==========
  Future<void> nextStep() async {
    // Trigger validation display
    formKey.currentState?.validate();

    final validation = formValidator.validateStep(
      currentStep.value,
      formDataManager,
    );

    if (!validation.isValid) {
      notificationService.showError(validation.errorMessage ?? 'Validasi gagal');
      return;
    }

    stepNavigationManager.nextStep();
    clearError();
  }

  void previousStep() {
    stepNavigationManager.previousStep();
    clearError();
  }

  // ========== Generate Surat ==========
  @override
  Future<void> generateSurat() async {
    try {
      startLoading();

      // Validasi final
      final validation = formValidator.validateStep(
        currentStep.value,
        formDataManager,
      );

      if (!validation.isValid) {
        throw ValidationException(validation.errorMessage ?? 'Validasi gagal');
      }

      final entity = formDataManager.toEntity();

      final file = await _generateSusunanPengurusIpnuUseCase.execute(
        entity,
        onReceiveProgress: (received, total) {
          updateProgress(received, total);
        },
        cancelToken: cancelToken,
      );

      generatedFile.value = file; // Set dulu sebelum saveFileToLocal
      await saveFileToLocal(file);

      showSuccessNotification();

      resetForm();
    } on ValidationException catch (e) {
      handleValidationError(e);
    } catch (e) {
      handleUnexpectedError(e);
    } finally {
      stopLoading();
    }
  }

  void resetForm() {
    formDataManager.clear();
    stepNavigationManager.reset();
    clearError();
    uploadProgress.value = 0;

    // Reset version counters
    _pembinaVersion.value = 0;
    _wakilKetuaVersion.value = 0;
    _wakilSekretarisVersion.value = 0;
    _departemenVersion.value = 0;
    _lembagaVersion.value = 0;
    _divisiVersion.value = 0;
  }
}
