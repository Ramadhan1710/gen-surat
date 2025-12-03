import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gen_surat/core/exception/validation_exception.dart';
import 'package:gen_surat/core/helper/field_error_focus_helper.dart';
import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/ipnu/generate_surat_keputusan_ipnu_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/base_surat_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/keputusan/enum/surat_keputusan_form_step.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/keputusan/managers/ipnu/surat_keputusan_ipnu_form_data_manager.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/keputusan/managers/ipnu/surat_keputusan_ipnu_form_validator.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/keputusan/managers/surat_keputusan_step_navigation_manager.dart';
import 'package:get/get.dart';

class SuratKeputusanIpnuViewmodel extends BaseSuratViewModel {
  final GenerateSuratKeputusanIpnuUseCase _generateSuratKeputusanIpnuUseCase;

  final SuratKeputusanIpnuFormDataManager formDataManager;
  final SuratKeputusanIpnuFormValidator formValidator;
  final SuratKeputusanStepNavigationManager stepNavigationManager;

  SuratKeputusanIpnuViewmodel(
    this._generateSuratKeputusanIpnuUseCase,
    IGeneratedFileRepository fileRepository,
    NotificationService notificationService,
    FileOperationService fileOperationService,
  ) : formDataManager = SuratKeputusanIpnuFormDataManager(),
      formValidator = SuratKeputusanIpnuFormValidator(),
      stepNavigationManager = SuratKeputusanStepNavigationManager(),
      super(
        fileRepository: fileRepository,
        notificationService: notificationService,
        fileOperationService: fileOperationService,
      );

  final ttdKetuaFile = Rxn<File>();
  final ttdSekretarisFile = Rxn<File>();
  final ttdAnggotaFile = Rxn<File>();

  @override
  String get fileType => 'keputusan';

  @override
  String get lembagaType => 'IPNU';

  @override
  String getSuratDescription() =>
      'Surat Keputusan ${formDataManager.namaLembaga}';

  @override
  String getNomorSurat() => formDataManager.nomorSurat;

  @override
  String getNamaLembaga() => formDataManager.namaLembaga;

  Rx<SuratKeputusanFormStep> get currentStep =>
      stepNavigationManager.currentStep;
  int get totalSteps => SuratKeputusanFormStep.totalSteps;
  List<String> get stepTitles => SuratKeputusanFormStep.allTitles;

  @override
  void onClose() {
    formDataManager.dispose();
    ttdKetuaFile.close();
    ttdSekretarisFile.close();
    ttdAnggotaFile.close();
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

  void setTtdAnggota(File file) {
    ttdAnggotaFile.value = file;
    clearError();
  }

  void removeTtdKetua() => ttdKetuaFile.value = null;
  void removeTtdSekretaris() => ttdSekretarisFile.value = null;
  void removeTtdAnggota() => ttdAnggotaFile.value = null;

  final _timFormaturVersion = 0.obs;

  void addTimFormatur({String nama = '', String daerahPengkaderan = ''}) {
    formDataManager.addTimFormatur(
      nama: nama,
      daerahPengkaderan: daerahPengkaderan,
    );
    _timFormaturVersion.value++;
  }

  void removeTimFormatur(int index) {
    formDataManager.removeTimFormatur(index);
    _timFormaturVersion.value++;
  }

  void updateTimFormatur(int index, {String? nama, String? daerahPengkaderan}) {
    formDataManager.updateTimFormatur(
      index,
      nama: nama,
      daerahPengkaderan: daerahPengkaderan,
    );
    _timFormaturVersion.value++;
  }

  int get timFormaturCount => formDataManager.timFormaturCount;
  List<TimFormaturData> get timFormatur => formDataManager.timFormatur;

  RxInt get timFormaturVersion => _timFormaturVersion;

  Map<SuratKeputusanFormStep, List<FocusErrorField>> get _stepErrorFields => {
    SuratKeputusanFormStep.lembaga: [
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
        hasError: () => formDataManager.ketuaTerpilih.isEmpty,
        focusNode: formDataManager.ketuaTerpilihFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.periodeRapta.isEmpty,
        focusNode: formDataManager.periodeRaptaFocus,
      ),
    ],
    SuratKeputusanFormStep.surat: [
      FocusErrorField(
        hasError: () => formDataManager.nomorSurat.isEmpty,
        focusNode: formDataManager.nomorSuratFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.tanggalHijriah.isEmpty,
        focusNode: formDataManager.tanggalHijriahFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.tanggalMasehi.isEmpty,
        focusNode: formDataManager.tanggalMasehiFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.waktuPenetapan.isEmpty,
        focusNode: formDataManager.waktuPenetapanFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.namaWilayah.isEmpty,
        focusNode: formDataManager.namaWilayahFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.namaKetua.isEmpty,
        focusNode: formDataManager.namaKetuaFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.namaSekretaris.isEmpty,
        focusNode: formDataManager.namaSekretarisFocus,
      ),
      FocusErrorField(
        hasError: () => formDataManager.namaAnggota.isEmpty,
        focusNode: formDataManager.namaAnggotaFocus,
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
    if (!validateForm()) {
      final validationResult = formValidator.validateStep(
        currentStep.value,
        formDataManager,
        ttdKetua: ttdKetuaFile.value,
        ttdSekretaris: ttdSekretarisFile.value,
        ttdAnggota: ttdAnggotaFile.value,
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
      ttdAnggota: ttdAnggotaFile.value,
    );

    if (!validationResult.isValid) {
      errorMessage.value = validationResult.errorMessage;
      return;
    }

    final timFormaturValidation = formValidator.validationTimFormatur(
      timFormatur: formDataManager.timFormatur,
    );

    if (!timFormaturValidation.isValid) {
      errorMessage.value = timFormaturValidation.errorMessage;
      return;
    }

    try {
      startLoading();

      final entity = formDataManager.toEntity(
        ttdKetuaPath: ttdKetuaFile.value!.path,
        ttdSekretarisPath: ttdSekretarisFile.value!.path,
        ttdAnggotaPath: ttdAnggotaFile.value!.path,
      );

      final file = await _generateSuratKeputusanIpnuUseCase.execute(
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
    ttdAnggotaFile.value = null;
    errorMessage.value = null;
    generatedFile.value = null;
    uploadProgress.value = 0.0;
    stepNavigationManager.reset();
    formKey.currentState?.reset();
  }
}
