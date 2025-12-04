import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gen_surat/core/exception/validation_exception.dart';
import 'package:gen_surat/core/helper/field_error_focus_helper.dart';
import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/ippnu/generate_berita_acara_penyusunan_pengurus_ippnu_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/base_surat_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_penyusunan_pengurus/enum/berita_acara_penyusunan_pengurus_ippnu_form_step.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_penyusunan_pengurus/managers/berita_acara_penyusunan_pengurus_ippnu_form_data_manager.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_penyusunan_pengurus/managers/berita_acara_penyusunan_pengurus_ippnu_form_validator.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_penyusunan_pengurus/managers/berita_acara_penyusunan_pengurus_ippnu_step_navigation_manager.dart';
import 'package:get/get.dart';

class BeritaAcaraPenyusunanPengurusIppnuViewmodel extends BaseSuratViewModel {
  final GenerateBeritaAcaraPenyusunanPengurusIppnuUseCase _generateUseCase;

  final BeritaAcaraPenyusunanPengurusIppnuFormDataManager formDataManager;
  final BeritaAcaraPenyusunanPengurusIppnuFormValidator formValidator;
  final BeritaAcaraPenyusunanPengurusIppnuStepNavigationManager
      stepNavigationManager;

  BeritaAcaraPenyusunanPengurusIppnuViewmodel(
    this._generateUseCase,
    IGeneratedFileRepository fileRepository,
    NotificationService notificationService,
    FileOperationService fileOperationService,
  ) : formDataManager = BeritaAcaraPenyusunanPengurusIppnuFormDataManager(),
        formValidator = BeritaAcaraPenyusunanPengurusIppnuFormValidator(),
        stepNavigationManager =
            BeritaAcaraPenyusunanPengurusIppnuStepNavigationManager(),
        super(
          fileRepository: fileRepository,
          notificationService: notificationService,
          fileOperationService: fileOperationService,
        );

  // Observable versions for reactive updates
  final pengurusHarianVersion = 0.obs;
  final pelindungVersion = 0.obs;
  final pembinaVersion = 0.obs;
  final wakilKetuaVersion = 0.obs;
  final wakilSekretarisVersion = 0.obs;
  final departemenVersion = 0.obs;
  final lembagaVersion = 0.obs;

  @override
  String get fileType => 'berita_acara_penyusunan_pengurus';

  @override
  String get lembagaType => 'IPPNU';

  @override
  String getSuratDescription() =>
      'Berita Acara Penyusunan Pengurus ${formDataManager.namaLembaga}';

  @override
  String getNomorSurat() => '';

  @override
  String getNamaLembaga() => formDataManager.namaLembaga;

  Rx<BeritaAcaraPenyusunanPengurusIppnuFormStep> get currentStep =>
      stepNavigationManager.currentStep;
  int get totalSteps => BeritaAcaraPenyusunanPengurusIppnuFormStep.totalSteps;
  List<String> get stepTitles =>
      BeritaAcaraPenyusunanPengurusIppnuFormStep.allTitles;

  @override
  void onClose() {
    formDataManager.dispose();
    super.onClose();
  }

  // ========== Pengurus Harian Management ==========

  List<PengurusHarianData> get pengurusHarian =>
      formDataManager.pengurusHarian;
  int get pengurusHarianCount => formDataManager.pengurusHarianCount;

  void addPengurusHarian({String jabatan = '', String nama = '', File? ttd}) {
    formDataManager.addPengurusHarian(jabatan: jabatan, nama: nama, ttd: ttd);
    pengurusHarianVersion.value++;
  }

  void removePengurusHarian(int index) {
    formDataManager.removePengurusHarian(index);
    pengurusHarianVersion.value++;
  }

  void setPengurusHarianTtd(int index, File file) {
    if (index >= 0 && index < pengurusHarian.length) {
      pengurusHarian[index].ttd = file;
      pengurusHarianVersion.value++;
      clearError();
    }
  }

  void removePengurusHarianTtd(int index) {
    if (index >= 0 && index < pengurusHarian.length) {
      pengurusHarian[index].ttd = null;
      pengurusHarianVersion.value++;
    }
  }

  // ========== Pelindung Management ==========

  List<PelindungData> get pelindung => formDataManager.pelindung;
  int get pelindungCount => formDataManager.pelindungCount;

  void addPelindung({String nama = ''}) {
    formDataManager.addPelindung(nama: nama);
    pelindungVersion.value++;
  }

  void removePelindung(int index) {
    formDataManager.removePelindung(index);
    pelindungVersion.value++;
  }

  // ========== Pembina Management ==========

  List<PembinaData> get pembina => formDataManager.pembina;
  int get pembinaCount => formDataManager.pembinaCount;

  void addPembina({String nama = ''}) {
    formDataManager.addPembina(nama: nama);
    pembinaVersion.value++;
  }

  void removePembina(int index) {
    formDataManager.removePembina(index);
    pembinaVersion.value++;
  }

  // ========== Wakil Ketua Management ==========

  List<WakilKetuaData> get wakilKetua => formDataManager.wakilKetua;
  int get wakilKetuaCount => formDataManager.wakilKetuaCount;

  void addWakilKetua({String title = '', String nama = ''}) {
    formDataManager.addWakilKetua(title: title, nama: nama);
    wakilKetuaVersion.value++;
  }

  void removeWakilKetua(int index) {
    formDataManager.removeWakilKetua(index);
    wakilKetuaVersion.value++;
  }

  // ========== Wakil Sekretaris Management ==========

  List<WakilSekretarisData> get wakilSekretaris =>
      formDataManager.wakilSekretaris;
  int get wakilSekretarisCount => formDataManager.wakilSekretarisCount;

  void addWakilSekretaris({String title = '', String nama = ''}) {
    formDataManager.addWakilSekretaris(title: title, nama: nama);
    wakilSekretarisVersion.value++;
  }

  void removeWakilSekretaris(int index) {
    formDataManager.removeWakilSekretaris(index);
    wakilSekretarisVersion.value++;
  }

  // ========== Departemen Management ==========

  List<DepartemenData> get departemen => formDataManager.departemen;
  int get departemenCount => formDataManager.departemenCount;

  void addDepartemen({String namaDepartemen = '', String koordinator = ''}) {
    formDataManager.addDepartemen(
      namaDepartemen: namaDepartemen,
      koordinator: koordinator,
    );
    departemenVersion.value++;
  }

  void removeDepartemen(int index) {
    formDataManager.removeDepartemen(index);
    departemenVersion.value++;
  }

  void addAnggotaDepartemen(int departemenIndex, {String nama = ''}) {
    if (departemenIndex >= 0 && departemenIndex < departemen.length) {
      departemen[departemenIndex].addAnggota(nama: nama);
      departemenVersion.value++;
    }
  }

  void removeAnggotaDepartemen(int departemenIndex, int anggotaIndex) {
    if (departemenIndex >= 0 && departemenIndex < departemen.length) {
      departemen[departemenIndex].removeAnggota(anggotaIndex);
      departemenVersion.value++;
    }
  }

  // ========== Lembaga Management ==========

  List<LembagaData> get lembaga => formDataManager.lembaga;
  int get lembagaCount => formDataManager.lembagaCount;

  void addLembaga({
    String nama = '',
    String direktur = '',
    String sekretaris = '',
  }) {
    formDataManager.addLembaga(
      nama: nama,
      direktur: direktur,
      sekretaris: sekretaris,
    );
    lembagaVersion.value++;
  }

  void removeLembaga(int index) {
    formDataManager.removeLembaga(index);
    lembagaVersion.value++;
  }

  void addAnggotaLembaga(int lembagaIndex, {String nama = ''}) {
    if (lembagaIndex >= 0 && lembagaIndex < lembaga.length) {
      lembaga[lembagaIndex].addAnggota(nama: nama);
      lembagaVersion.value++;
    }
  }

  void removeAnggotaLembaga(int lembagaIndex, int anggotaIndex) {
    if (lembagaIndex >= 0 && lembagaIndex < lembaga.length) {
      lembaga[lembagaIndex].removeAnggota(anggotaIndex);
      lembagaVersion.value++;
    }
  }

  // ========== Navigation ==========

  Map<BeritaAcaraPenyusunanPengurusIppnuFormStep, List<FocusErrorField>>
      get _stepErrorFields => {
            BeritaAcaraPenyusunanPengurusIppnuFormStep.informasiLembaga: [
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
            BeritaAcaraPenyusunanPengurusIppnuFormStep.dataPengurusInti: [
              FocusErrorField(
                hasError: () => formDataManager.namaKetua.isEmpty,
                focusNode: formDataManager.namaKetuaFocus,
              ),
              FocusErrorField(
                hasError: () => formDataManager.namaSekretaris.isEmpty,
                focusNode: formDataManager.namaSekretarisFocus,
              ),
              FocusErrorField(
                hasError: () => formDataManager.namaBendahara.isEmpty,
                focusNode: formDataManager.namaBendaharaFocus,
              ),
            ],
            BeritaAcaraPenyusunanPengurusIppnuFormStep.penetapan: [
              FocusErrorField(
                hasError: () => formDataManager.tanggalPenyusunan.isEmpty,
                focusNode: formDataManager.tanggalPenyusunanFocus,
              ),
              FocusErrorField(
                hasError: () => formDataManager.tempatPenyusunan.isEmpty,
                focusNode: formDataManager.tempatPenyusunanFocus,
              ),
              FocusErrorField(
                hasError: () => formDataManager.namaWilayah.isEmpty,
                focusNode: formDataManager.namaWilayahFocus,
              ),
              FocusErrorField(
                hasError: () => formDataManager.hariPenyusunan.isEmpty,
                focusNode: formDataManager.hariPenyusunanFocus,
              ),
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

  void jumpToStep(BeritaAcaraPenyusunanPengurusIppnuFormStep step) {
    currentStep.value = step;
    clearError();
  }

  bool canGoNext() => stepNavigationManager.canGoNext;
  bool canGoPrevious() => stepNavigationManager.canGoPrevious;
  bool isLastStep() => stepNavigationManager.isLastStep;

  @override
  Future<void> generateSurat({String? lembaga, String? endpoint}) async {
    if (!validateForm()) return;

    // Validate all steps before generation
    for (var step in BeritaAcaraPenyusunanPengurusIppnuFormStep.values) {
      final validationResult = formValidator.validateStep(
        step,
        formDataManager,
      );

      if (!validationResult.isValid) {
        errorMessage.value = validationResult.errorMessage;
        return;
      }
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
  }
}
