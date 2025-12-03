import 'package:gen_surat/core/exception/validation_exception.dart';
import 'package:gen_surat/core/helper/field_error_focus_helper.dart';
import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/ipnu/generate_sertifikat_kaderisasi_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/base_surat_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/sertifikat_kaderisasi/managers/sertifikat_kaderisasi_form_data_manager.dart';
import 'package:gen_surat/presentation/viewmodels/surat/sertifikat_kaderisasi/managers/sertifikat_kaderisasi_form_validator.dart';

class SertifikatKaderisasiViewmodel extends BaseSuratViewModel {
  final GenerateSertifikatKaderisasiUseCase
  _generateSertifikatKaderisasiUseCase;

  late final SertifikatKaderisasiFormDataManager formDataManager;
  late final SertifikatKaderisasiFormValidator formValidator;

  SertifikatKaderisasiViewmodel(
    this._generateSertifikatKaderisasiUseCase,
    IGeneratedFileRepository fileRepository,
    NotificationService notificationService,
    FileOperationService fileOperationService,
  ) : super(
        fileRepository: fileRepository,
        notificationService: notificationService,
        fileOperationService: fileOperationService,
      ) {
    formDataManager = SertifikatKaderisasiFormDataManager();
    formValidator = SertifikatKaderisasiFormValidator();
  }

  // ========== Override Abstract Properties ==========
  @override
  String get fileType => 'sertifikat_kaderisasi';

  @override
  String get lembagaType => 'IPNU';

  @override
  String getSuratDescription() =>
      'Sertifikat Kaderisasi ${formDataManager.jenisLembagaController.text} ${formDataManager.namaLembagaController.text}';

  @override
  String getNomorSurat() => ''; // Sertifikat kaderisasi tidak punya nomor surat

  @override
  String getNamaLembaga() => formDataManager.namaLembagaController.text.trim();

  @override
  Future<void> generateSurat() async {
    if (!_validateForm()) return;

    try {
      startLoading();

      final entity = formDataManager.buildEntity();

      final file = await _generateSertifikatKaderisasiUseCase.execute(
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
    if (!formDataManager.formKey.currentState!.validate()) {
      focusFirstErrorField();
      return false;
    }

    if (formDataManager.sertifikatKaderisasiKetuaPath == null) {
      return false;
    }

    if (formDataManager.sertifikatKaderisasiSekretarisPath == null) {
      handleValidationError(
        ValidationException(
          'Foto sertifikat kaderisasi sekretaris harus diunggah',
        ),
      );
      return false;
    }

    if (formDataManager.sertifikatKaderisasiBendaharaPath == null) {
      handleValidationError(
        ValidationException(
          'Foto sertifikat kaderisasi bendahara harus diunggah',
        ),
      );
      return false;
    }

    return true;
  }

  // Setter methods untuk foto
  void setSertifikatKaderisasiKetua(String path) {
    formDataManager.sertifikatKaderisasiKetuaPath = path;
    update();
  }

  void setSertifikatKaderisasiSekretaris(String path) {
    formDataManager.sertifikatKaderisasiSekretarisPath = path;
    update();
  }

  void setSertifikatKaderisasiBendahara(String path) {
    formDataManager.sertifikatKaderisasiBendaharaPath = path;
    update();
  }

  // Remove methods untuk foto
  void removeSertifikatKaderisasiKetua() {
    formDataManager.sertifikatKaderisasiKetuaPath = null;
    update();
  }

  void removeSertifikatKaderisasiSekretaris() {
    formDataManager.sertifikatKaderisasiSekretarisPath = null;
    update();
  }

  void removeSertifikatKaderisasiBendahara() {
    formDataManager.sertifikatKaderisasiBendaharaPath = null;
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
