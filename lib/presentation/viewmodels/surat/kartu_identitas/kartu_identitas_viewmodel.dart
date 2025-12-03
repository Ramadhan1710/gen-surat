import 'package:gen_surat/core/exception/validation_exception.dart';
import 'package:gen_surat/core/helper/field_error_focus_helper.dart';
import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/ipnu/generate_kartu_identitas_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/base_surat_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/kartu_identitas/managers/kartu_identitas_form_data_manager.dart';
import 'package:gen_surat/presentation/viewmodels/surat/kartu_identitas/managers/kartu_identitas_form_validator.dart';

class KartuIdentitasViewmodel extends BaseSuratViewModel {
  final GenerateKartuIdentitasUseCase _generateKartuIdentitasUseCase;

  late final KartuIdentitasFormDataManager formDataManager;
  late final KartuIdentitasFormValidator formValidator;

  KartuIdentitasViewmodel(
    this._generateKartuIdentitasUseCase,
    IGeneratedFileRepository fileRepository,
    NotificationService notificationService,
    FileOperationService fileOperationService,
  ) : super(
        fileRepository: fileRepository,
        notificationService: notificationService,
        fileOperationService: fileOperationService,
      ) {
    formDataManager = KartuIdentitasFormDataManager();
    formValidator = KartuIdentitasFormValidator();
  }

  // ========== Override Abstract Properties ==========
  @override
  String get fileType => 'kartu_identitas';

  @override
  String get lembagaType => 'IPNU';

  @override
  String getSuratDescription() =>
      'Kartu Identitas ${formDataManager.jenisLembagaController.text} ${formDataManager.namaLembagaController.text}';

  @override
  String getNomorSurat() => ''; // Kartu identitas tidak punya nomor surat

  @override
  String getNamaLembaga() => formDataManager.namaLembagaController.text.trim();

  @override
  Future<void> generateSurat() async {
    if (!_validateForm()) return;

    try {
      startLoading();

      final entity = formDataManager.buildEntity();

      final file = await _generateKartuIdentitasUseCase.execute(
        entity,
        onReceiveProgress: (received, total) => updateProgress(received, total),
        cancelToken: cancelToken,
      );

      generatedFile.value = file;
      await saveFileToLocal(file);
      showSuccessNotification();
    } on ValidationException catch (e) {
      handleValidationError(e);
    } catch (e) {
      handleUnexpectedError(e);
    } finally {
      stopLoading();
    }
  }

  void focusFirstErrorField() {
    final errorFields = [
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
      FocusErrorField(
        hasError:
            () =>
                formDataManager.periodeKepengurusanController.text
                    .trim()
                    .isEmpty,
        focusNode: formDataManager.periodeKepengurusanFocus,
      ),
    ];

    FieldErrorFocusHelper.focusFirstErrorField(errorFields);
  }

  bool _validateForm() {
    final currentState = formDataManager.formKey.currentState;
    if (currentState == null || !currentState.validate()) {
      handleValidationError(
        ValidationException('Mohon lengkapi semua field yang diperlukan'),
      );
      focusFirstErrorField();
      return false;
    }

    if (formDataManager.kartuIdentitasKetuaPath == null) {
      handleValidationError(
        ValidationException('Foto kartu identitas ketua harus diunggah'),
      );
      return false;
    }

    if (formDataManager.kartuIdentitasSekretarisPath == null) {
      handleValidationError(
        ValidationException('Foto kartu identitas sekretaris harus diunggah'),
      );
      return false;
    }

    if (formDataManager.kartuIdentitasBendaharaPath == null) {
      handleValidationError(
        ValidationException('Foto kartu identitas bendahara harus diunggah'),
      );
      return false;
    }

    return true;
  }

  // Setter methods untuk foto
  void setKartuIdentitasKetua(String? path) {
    formDataManager.kartuIdentitasKetuaPath = path;
    update();
  }

  void setKartuIdentitasSekretaris(String? path) {
    formDataManager.kartuIdentitasSekretarisPath = path;
    update();
  }

  void setKartuIdentitasBendahara(String? path) {
    formDataManager.kartuIdentitasBendaharaPath = path;
    update();
  }

  // Remove methods untuk foto
  void removeKartuIdentitasKetua() {
    formDataManager.kartuIdentitasKetuaPath = null;
    update();
  }

  void removeKartuIdentitasSekretaris() {
    formDataManager.kartuIdentitasSekretarisPath = null;
    update();
  }

  void removeKartuIdentitasBendahara() {
    formDataManager.kartuIdentitasBendaharaPath = null;
    update();
  }

  void resetForm() {
    formDataManager.resetForm();
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
