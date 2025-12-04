import 'package:dio/dio.dart';
import 'package:gen_surat/core/helper/field_error_focus_helper.dart';
import 'package:get/get.dart';

import '../../../../../core/exception/validation_exception.dart';
import '../../../../../core/services/file_operation_service.dart';
import '../../../../../core/services/notification_service.dart';
import '../../../../../domain/repositories/i_generated_file_repository.dart';
import '../../../../../domain/usecases/ippnu/generate_susunan_pengurus_ippnu_usecase.dart';
import '../../base_surat_viewmodel.dart';
import 'enum/susunan_pengurus_ippnu_form_step.dart';
import 'managers/susunan_pengurus_ippnu_form_validator.dart';
import 'managers/susunan_pengurus_ippnu_form_data_manager.dart';
import 'managers/susunan_pengurus_ippnu_step_navigation_manager.dart';

class SusunanPengurusIppnuViewmodel extends BaseSuratViewModel {
  final GenerateSusunanPengurusIppnuUseCase _generateUseCase;

  final SusunanPengurusIppnuFormDataManager formDataManager;
  final SusunanPengurusIppnuFormValidator formValidator;
  final SusunanPengurusIppnuStepNavigationManager stepNavigationManager;

  SusunanPengurusIppnuViewmodel(
    this._generateUseCase,
    IGeneratedFileRepository fileRepository,
    NotificationService notificationService,
    FileOperationService fileOperationService,
  ) : formDataManager = SusunanPengurusIppnuFormDataManager(),
      formValidator = SusunanPengurusIppnuFormValidator(),
      stepNavigationManager = SusunanPengurusIppnuStepNavigationManager(),
      super(
        fileRepository: fileRepository,
        notificationService: notificationService,
        fileOperationService: fileOperationService,
      );

  // Observable versions for reactive updates
  final wakilKetuaVersion = 0.obs;
  final wakilSekreVersion = 0.obs;
  final departemenVersion = 0.obs;
  final lembagaVersion = 0.obs;
  final pelindungVersion = 0.obs;
  final pembinaVersion = 0.obs;

  @override
  String get fileType => 'susunan_pengurus';

  @override
  String get lembagaType => 'IPPNU';

  @override
  String getSuratDescription() =>
      'Susunan Pengurus IPPNU ${formDataManager.namaLembaga}';

  @override
  String getNomorSurat() => '';

  @override
  String getNamaLembaga() => formDataManager.namaLembaga;

  Rx<SusunanPengurusIppnuFormStep> get currentStep =>
      stepNavigationManager.currentStep;
  int get totalSteps => SusunanPengurusIppnuFormStep.totalSteps;
  List<String> get stepTitles => SusunanPengurusIppnuFormStep.allTitles;

  // Wakil Ketua
  List<WakilKetuaData> get wakilKetua => formDataManager.wakilKetua;
  void addWakilKetua() {
    formDataManager.addWakilKetua();
    wakilKetuaVersion.value++;
  }

  void removeWakilKetua(int index) {
    formDataManager.removeWakilKetua(index);
    wakilKetuaVersion.value++;
  }

  // Wakil Sekretaris
  List<WakilSekretarisData> get wakilSekre => formDataManager.wakilSekre;
  void addWakilSekretaris() {
    formDataManager.addWakilSekretaris();
    wakilSekreVersion.value++;
  }

  void removeWakilSekretaris(int index) {
    formDataManager.removeWakilSekretaris(index);
    wakilSekreVersion.value++;
  }

  // Departemen
  List<DepartemenData> get departemen => formDataManager.departemen;
  void addDepartemen() {
    formDataManager.addDepartemen();
    departemenVersion.value++;
  }

  void removeDepartemen(int index) {
    formDataManager.removeDepartemen(index);
    departemenVersion.value++;
  }

  void addAnggotaDepartemen(int departemenIndex) {
    if (departemenIndex >= 0 && departemenIndex < departemen.length) {
      departemen[departemenIndex].addAnggota();
      departemenVersion.value++;
    }
  }

  void removeAnggotaDepartemen(int departemenIndex, int anggotaIndex) {
    if (departemenIndex >= 0 && departemenIndex < departemen.length) {
      departemen[departemenIndex].removeAnggota(anggotaIndex);
      departemenVersion.value++;
    }
  }

  // Lembaga
  List<LembagaData> get lembaga => formDataManager.lembaga;
  void addLembaga() {
    formDataManager.addLembaga();
    lembagaVersion.value++;
  }

  void removeLembaga(int index) {
    formDataManager.removeLembaga(index);
    lembagaVersion.value++;
  }

  void addAnggotaLembaga(int lembagaIndex) {
    if (lembagaIndex >= 0 && lembagaIndex < lembaga.length) {
      lembaga[lembagaIndex].addAnggota();
      lembagaVersion.value++;
    }
  }

  void removeAnggotaLembaga(int lembagaIndex, int anggotaIndex) {
    if (lembagaIndex >= 0 && lembagaIndex < lembaga.length) {
      lembaga[lembagaIndex].removeAnggota(anggotaIndex);
      lembagaVersion.value++;
    }
  }

  // Pelindung
  List<PelindungData> get pelindung => formDataManager.pelindung;
  void addPelindung() {
    formDataManager.addPelindung();
    pelindungVersion.value++;
  }

  void removePelindung(int index) {
    formDataManager.removePelindung(index);
    pelindungVersion.value++;
  }

  // Pembina
  List<PembinaData> get pembina => formDataManager.pembina;
  void addPembina() {
    formDataManager.addPembina();
    pembinaVersion.value++;
  }

  void removePembina(int index) {
    formDataManager.removePembina(index);
    pembinaVersion.value++;
  }

  @override
  void onClose() {
    formDataManager.dispose();
    wakilKetuaVersion.close();
    wakilSekreVersion.close();
    departemenVersion.close();
    lembagaVersion.close();
    pelindungVersion.close();
    pembinaVersion.close();
    super.onClose();
  }

  Map<SusunanPengurusIppnuFormStep, List<FocusErrorField>>
  get _stepErrorFields => {
    SusunanPengurusIppnuFormStep.lembaga: [
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
        hasError: () => formDataManager.alamatLembaga.isEmpty,
        focusNode: formDataManager.alamatLembagaFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.nomorTeleponLembaga.isEmpty,
        focusNode: formDataManager.nomorTeleponLembagaFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.emailLembaga.isEmpty,
        focusNode: formDataManager.emailLembagaFocus,
      ),
    ],
    SusunanPengurusIppnuFormStep.ketuaWakil: [
      FocusErrorField(
        hasError: () => formDataManager.namaKetua.isEmpty,
        focusNode: formDataManager.namaKetuaFocus,
      ),
    ],
    SusunanPengurusIppnuFormStep.sekretarisWakil: [
      FocusErrorField(
        hasError: () => formDataManager.namaSekretaris.isEmpty,
        focusNode: formDataManager.namaSekretarisFocus,
      ),
    ],
    SusunanPengurusIppnuFormStep.bendahara: [
      FocusErrorField(
        hasError: () => formDataManager.namaBendahara.isEmpty,
        focusNode: formDataManager.namaBendaharaFocus,
      ),
    ],
  };

  void focusErrorForCurrentStep() {
    final list = _stepErrorFields[currentStep.value];
    if (list != null) {
      FieldErrorFocusHelper.focusFirstErrorField(list);
    }
  }

  Future<void> nextStep() async {
    // Trigger validation display
    formKey.currentState?.validate();

    final validation = formValidator.validateStep(
      currentStep.value,
      formDataManager,
    );

    if (!validation.isValid) {
      errorMessage.value = validation.errorMessage;
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

    final validationResult = formValidator.validateStep(
      currentStep.value,
      formDataManager,
    );

    if (!validationResult.isValid) {
      errorMessage.value = validationResult.errorMessage;
      return;
    }

    try {
      startLoading();

      final entity = formDataManager.toEntity();

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
    errorMessage.value = null;
    generatedFile.value = null;
    uploadProgress.value = 0.0;
    stepNavigationManager.reset();
    formKey.currentState?.reset();
    wakilKetuaVersion.value = 0;
    wakilSekreVersion.value = 0;
    departemenVersion.value = 0;
    lembagaVersion.value = 0;
    pelindungVersion.value = 0;
    pembinaVersion.value = 0;
  }
}
