# 📚 Panduan Lengkap Menambah Fitur Surat Baru

## 📖 Daftar Isi
1. [Pendahuluan](#pendahuluan)
2. [Arsitektur Project](#arsitektur-project)
3. [Langkah-langkah Implementasi](#langkah-langkah-implementasi)
4. [Contoh Implementasi](#contoh-implementasi)
5. [Best Practices](#best-practices)
6. [Troubleshooting](#troubleshooting)

---

## 🎯 Pendahuluan

Project ini menggunakan **Clean Architecture** dengan **GetX** untuk state management. Setiap fitur surat terdiri dari beberapa layer:

- **Domain Layer**: Entities & Use Cases (Business Logic)
- **Data Layer**: Models, Mappers, & Repositories (Data Access)
- **Presentation Layer**: ViewModels, Pages, & Widgets (UI)

### Struktur Folder
```
lib/
├── core/                          # Utilities, Constants, DI
├── data/                          # Data Layer
│   ├── models/
│   │   ├── ipnu/
│   │   └── ippnu/
│   └── mappers/
│       ├── ipnu/
│       └── ippnu/
├── domain/                        # Domain Layer
│   ├── entities/
│   │   ├── ipnu/
│   │   └── ippnu/
│   └── usecases/
│       ├── ipnu/
│       └── ippnu/
└── presentation/                  # Presentation Layer
    ├── viewmodels/
    │   └── surat/
    │       ├── ipnu/
    │       └── ippnu/
    ├── pages/
    │   └── surat/
    │       ├── ipnu/
    │       └── ippnu/
    └── routes/
        └── bindings/
```

---

## 🏗️ Arsitektur Project

### Clean Architecture Flow
```
UI (Page/Widget) 
    ↓
ViewModel (State Management)
    ↓
UseCase (Business Logic)
    ↓
Repository (Data Source)
    ↓
API/Local Storage
```

### Dependency Injection
- **Global Bindings**: Services yang persistent (Repository, Services)
- **Domain Bindings**: UseCases (permanent)
- **Route Bindings**: ViewModels (auto-dispose saat leave page)

---

## 🚀 Langkah-langkah Implementasi

### Checklist Implementasi
- [ ] 1. Buat Entity
- [ ] 2. Buat Model
- [ ] 3. Buat Mapper
- [ ] 4. Buat UseCase
- [ ] 5. Update API Constants
- [ ] 6. Buat Form Data Manager
- [ ] 7. Buat Form Validator
- [ ] 8. Buat Enum Form Step
- [ ] 9. Buat Step Navigation Manager
- [ ] 10. Buat ViewModel
- [ ] 11. Buat Widgets untuk Form
- [ ] 12. Buat Page
- [ ] 13. Buat Binding
- [ ] 14. Update Domain Bindings
- [ ] 15. Update App Routes
- [ ] 16. Update Document Constants

---

## 📝 Langkah 1: Buat Entity

**Lokasi**: `lib/domain/entities/{lembaga}/{nama_surat}_entity.dart`

**Contoh**: Surat Keputusan IPNU

```dart
// lib/domain/entities/ipnu/surat_keputusan_ipnu_entity.dart

class SuratKeputusanIpnuEntity {
  final String jenisLembaga;
  final String namaLembaga;
  final String nomorTeleponLembaga;
  final String alamatLembaga;
  final String emailLembaga;
  final String nomorSurat;
  // ... field lainnya sesuai kebutuhan
  final String ttdKetuaPath;
  final String ttdSekretarisPath;

  SuratKeputusanIpnuEntity({
    required this.jenisLembaga,
    required this.namaLembaga,
    required this.nomorTeleponLembaga,
    required this.alamatLembaga,
    required this.emailLembaga,
    required this.nomorSurat,
    // ... required fields lainnya
    required this.ttdKetuaPath,
    required this.ttdSekretarisPath,
  });
}
```

**Tips**:
- Gunakan tipe data yang tepat (String, int, bool, DateTime)
- Semua field harus `final`
- Gunakan `required` untuk field wajib
- Untuk file upload, gunakan path (String) bukan File

---

## 📝 Langkah 2: Buat Model

**Lokasi**: `lib/data/models/{lembaga}/{nama_surat}_model.dart`

**Contoh**:

```dart
// lib/data/models/ipnu/surat_keputusan_ipnu_model.dart

import 'dart:io';
import 'package:dio/dio.dart';

class SuratKeputusanIpnuModel {
  final String jenisLembaga;
  final String namaLembaga;
  final String nomorTeleponLembaga;
  final String alamatLembaga;
  final String emailLembaga;
  final String nomorSurat;
  // ... field lainnya
  
  final File ttdKetua;
  final File ttdSekretaris;

  SuratKeputusanIpnuModel({
    required this.jenisLembaga,
    required this.namaLembaga,
    required this.nomorTeleponLembaga,
    required this.alamatLembaga,
    required this.emailLembaga,
    required this.nomorSurat,
    // ... required fields lainnya
    required this.ttdKetua,
    required this.ttdSekretaris,
  });

  Future<Map<String, dynamic>> toMultipartMap() async {
    return {
      "jenis_lembaga": jenisLembaga,
      "nama_lembaga": namaLembaga,
      "nomor_telepon_lembaga": nomorTeleponLembaga,
      "alamat_lembaga": alamatLembaga,
      "email_lembaga": emailLembaga,
      "nomor_surat": nomorSurat,
      // ... field lainnya dengan snake_case (sesuai API)
      "ttd_ketua": await MultipartFile.fromFile(
        ttdKetua.path,
        filename: ttdKetua.path.split('/').last,
      ),
      "ttd_sekretaris": await MultipartFile.fromFile(
        ttdSekretaris.path,
        filename: ttdSekretaris.path.split('/').last,
      ),
    };
  }
}
```

**Tips**:
- Model menggunakan File untuk upload
- Method `toMultipartMap()` untuk convert ke format API
- Gunakan snake_case untuk key API (sesuai backend)
- Gunakan camelCase untuk property Dart

---

## 📝 Langkah 3: Buat Mapper

**Lokasi**: `lib/data/mappers/{lembaga}/{nama_surat}_mapper.dart`

**Contoh**:

```dart
// lib/data/mappers/ipnu/surat_keputusan_ipnu_mapper.dart

import 'dart:io';
import '../../../domain/entities/ipnu/surat_keputusan_ipnu_entity.dart';
import '../../models/ipnu/surat_keputusan_ipnu_model.dart';

class SuratKeputusanIpnuMapper {
  static SuratKeputusanIpnuEntity toEntity(
    SuratKeputusanIpnuModel model,
  ) {
    return SuratKeputusanIpnuEntity(
      jenisLembaga: model.jenisLembaga,
      namaLembaga: model.namaLembaga,
      nomorTeleponLembaga: model.nomorTeleponLembaga,
      alamatLembaga: model.alamatLembaga,
      emailLembaga: model.emailLembaga,
      nomorSurat: model.nomorSurat,
      // ... mapping field lainnya
      ttdKetuaPath: model.ttdKetua.path,
      ttdSekretarisPath: model.ttdSekretaris.path,
    );
  }

  static SuratKeputusanIpnuModel toModel(
    SuratKeputusanIpnuEntity entity,
  ) {
    return SuratKeputusanIpnuModel(
      jenisLembaga: entity.jenisLembaga,
      namaLembaga: entity.namaLembaga,
      nomorTeleponLembaga: entity.nomorTeleponLembaga,
      alamatLembaga: entity.alamatLembaga,
      emailLembaga: entity.emailLembaga,
      nomorSurat: entity.nomorSurat,
      // ... mapping field lainnya
      ttdKetua: File(entity.ttdKetuaPath),
      ttdSekretaris: File(entity.ttdSekretarisPath),
    );
  }
}
```

**Tips**:
- Gunakan static method
- Buat 2 method: `toEntity()` dan `toModel()`
- Convert path ↔ File untuk upload fields

---

## 📝 Langkah 4: Buat UseCase

**Lokasi**: `lib/domain/usecases/{lembaga}/generate_{nama_surat}_usecase.dart`

**Contoh**:

```dart
// lib/domain/usecases/ipnu/generate_surat_keputusan_ipnu_usecase.dart

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gen_surat/core/constants/app_constants.dart';
import 'package:gen_surat/core/constants/type_surat_constants.dart';
import 'package:gen_surat/core/exception/validation_exception.dart';
import '../../../core/constants/api_constants.dart';
import '../../../data/mappers/ipnu/surat_keputusan_ipnu_mapper.dart';
import '../../entities/ipnu/surat_keputusan_ipnu_entity.dart';
import '../../repositories/i_surat_repository.dart';

class GenerateSuratKeputusanIpnuUseCase {
  final ISuratRepository repository;

  GenerateSuratKeputusanIpnuUseCase(this.repository);

  Future<File> execute(
    SuratKeputusanIpnuEntity entity, {
    String? customSavePath,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    _validateEntity(entity);

    final model = SuratKeputusanIpnuMapper.toModel(entity);

    return await repository.generateSurat(
      data: model,
      lembaga: AppConstants.lembagaIpnu, // atau lembagaIppnu
      typeSurat: TypeSuratConstants.suratKeputusan, // sesuaikan
      endpoint: ApiConstants.suratKeputusanIpnuEndpoint,
      toMultipartMap: (data) => data.toMultipartMap(),
      customSavePath: customSavePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  void _validateEntity(SuratKeputusanIpnuEntity entity) {
    // Validasi semua field required
    if (entity.jenisLembaga.trim().isEmpty) {
      throw ValidationException('Jenis lembaga tidak boleh kosong');
    }
    
    if (entity.namaLembaga.trim().isEmpty) {
      throw ValidationException('Nama lembaga tidak boleh kosong');
    }
    
    // ... validasi field lainnya
    
    // Validasi file exists
    final ttdKetuaFile = File(entity.ttdKetuaPath);
    if (!ttdKetuaFile.existsSync()) {
      throw ValidationException('File tanda tangan ketua tidak ditemukan');
    }
    
    // Validasi email format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(entity.emailLembaga)) {
      throw ValidationException('Format email tidak valid');
    }
  }
}
```

**Tips**:
- Validasi di UseCase layer
- Gunakan ValidationException untuk error
- Support progress tracking & cancellation

---

## 📝 Langkah 5: Update API Constants

**Lokasi**: `lib/core/constants/api_constants.dart`

**Tambahkan endpoint baru**:

```dart
// Untuk IPNU
static const String suratKeputusanIpnuEndpoint = "/ipnu/surat-keputusan";

// Untuk IPPNU
static const String suratKeputusanIppnuEndpoint = "/ippnu/surat-keputusan";
```

**Jika perlu, tambahkan juga di** `type_surat_constants.dart`:

```dart
static const String suratKeputusan = 'surat_keputusan';
```

---

## 📝 Langkah 6: Buat Form Data Manager

**Lokasi**: `lib/presentation/viewmodels/surat/{lembaga}/{nama_surat}/managers/{nama_surat}_form_data_manager.dart`

**Contoh**:

```dart
// lib/presentation/viewmodels/surat/ipnu/keputusan/managers/surat_keputusan_ipnu_form_data_manager.dart

import 'package:flutter/material.dart';
import '../../../../../../domain/entities/ipnu/surat_keputusan_ipnu_entity.dart';

class SuratKeputusanIpnuFormDataManager {
  // Controllers
  final jenisLembagaController = TextEditingController();
  final namaLembagaController = TextEditingController();
  final nomorTeleponLembagaController = TextEditingController();
  final alamatLembagaController = TextEditingController();
  final emailLembagaController = TextEditingController();
  final nomorSuratController = TextEditingController();
  // ... controllers lainnya

  // Focus nodes
  final jenisLembagaFocus = FocusNode();
  final namaLembagaFocus = FocusNode();
  final nomorTeleponLembagaFocus = FocusNode();
  final alamatLembagaFocus = FocusNode();
  final emailLembagaFocus = FocusNode();
  // ... focus nodes lainnya

  // Typed getters for clean access
  String get jenisLembaga => jenisLembagaController.text.trim();
  String get namaLembaga => namaLembagaController.text.trim();
  String get nomorTelepon => nomorTeleponLembagaController.text.trim();
  String get alamat => alamatLembagaController.text.trim();
  String get email => emailLembagaController.text.trim();
  String get nomorSurat => nomorSuratController.text.trim();
  // ... getters lainnya

  void clear() {
    jenisLembagaController.clear();
    namaLembagaController.clear();
    nomorTeleponLembagaController.clear();
    alamatLembagaController.clear();
    emailLembagaController.clear();
    nomorSuratController.clear();
    // ... clear semua controller
  }

  void dispose() {
    jenisLembagaController.dispose();
    namaLembagaController.dispose();
    nomorTeleponLembagaController.dispose();
    alamatLembagaController.dispose();
    emailLembagaController.dispose();
    nomorSuratController.dispose();
    // ... dispose semua controller
    
    jenisLembagaFocus.dispose();
    namaLembagaFocus.dispose();
    nomorTeleponLembagaFocus.dispose();
    alamatLembagaFocus.dispose();
    emailLembagaFocus.dispose();
    // ... dispose semua focus node
  }

  SuratKeputusanIpnuEntity toEntity({
    required String ttdKetuaPath,
    required String ttdSekretarisPath,
    // parameter lain untuk file upload jika ada
  }) {
    return SuratKeputusanIpnuEntity(
      jenisLembaga: jenisLembaga,
      namaLembaga: namaLembaga,
      nomorTeleponLembaga: nomorTelepon,
      alamatLembaga: alamat,
      emailLembaga: email,
      nomorSurat: nomorSurat,
      // ... field lainnya
      ttdKetuaPath: ttdKetuaPath,
      ttdSekretarisPath: ttdSekretarisPath,
    );
  }
}
```

**Tips**:
- Satu controller untuk satu field
- Gunakan FocusNode untuk navigasi keyboard
- Method `toEntity()` untuk convert ke Entity
- Jangan lupa dispose semua controller & focus node

---

## 📝 Langkah 7: Buat Form Validator

**Lokasi**: `lib/presentation/viewmodels/surat/{lembaga}/{nama_surat}/managers/{nama_surat}_form_validator.dart`

**Contoh**:

```dart
// lib/presentation/viewmodels/surat/ipnu/keputusan/managers/surat_keputusan_ipnu_form_validator.dart

import 'dart:io';
import '../../../../../../core/exception/form_validation_result.dart';
import '../../../../../../core/validator/common_step_validators.dart';
import '../../../../../../core/validator/required_validator.dart';
import '../enum/surat_keputusan_form_step.dart';
import 'surat_keputusan_ipnu_form_data_manager.dart';

class SuratKeputusanIpnuFormValidator {
  /// Validasi Step 1: Informasi Lembaga
  FormValidationResult validateLembagaStep({
    required String jenisLembaga,
    required String namaLembaga,
    required String nomorTelepon,
    required String email,
    required String alamat,
  }) {
    return CommonStepValidators.validateLembagaFields(
      jenisLembaga: jenisLembaga,
      namaLembaga: namaLembaga,
      alamat: alamat,
      nomorTelepon: nomorTelepon,
      email: email,
    );
  }

  /// Validasi Step 2: Informasi Surat
  FormValidationResult validateSuratStep({
    required String nomorSurat,
    required String tanggalSurat,
    // ... parameter lainnya
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Nomor surat').validate(nomorSurat),
      RequiredValidator('Tanggal surat').validate(tanggalSurat),
      // ... validasi field lainnya
    ]);
  }

  /// Validasi Step 3: Tanda Tangan
  FormValidationResult validateTandaTanganStep({
    required File? ttdKetua,
    required File? ttdSekretaris,
  }) {
    if (ttdKetua == null) {
      return const FormValidationResult.error(
        'Tanda tangan ketua belum diunggah',
      );
    }
    if (ttdSekretaris == null) {
      return const FormValidationResult.error(
        'Tanda tangan sekretaris belum diunggah',
      );
    }
    return const FormValidationResult.success();
  }

  /// Validasi per step (dispatch ke method yang sesuai)
  FormValidationResult validateStep(
    SuratKeputusanFormStep step,
    SuratKeputusanIpnuFormDataManager formData, {
    File? ttdKetua,
    File? ttdSekretaris,
  }) {
    switch (step) {
      case SuratKeputusanFormStep.lembaga:
        return validateLembagaStep(
          jenisLembaga: formData.jenisLembaga,
          namaLembaga: formData.namaLembaga,
          nomorTelepon: formData.nomorTelepon,
          email: formData.email,
          alamat: formData.alamat,
        );
      case SuratKeputusanFormStep.surat:
        return validateSuratStep(
          nomorSurat: formData.nomorSurat,
          tanggalSurat: formData.tanggalSurat,
        );
      case SuratKeputusanFormStep.tandaTangan:
        return validateTandaTanganStep(
          ttdKetua: ttdKetua,
          ttdSekretaris: ttdSekretaris,
        );
    }
  }
}
```

**Tips**:
- Gunakan `CommonStepValidators` untuk validasi umum
- Gunakan `RequiredValidator` untuk field wajib
- Combine multiple validations dengan `FormValidationResult.combine()`
- Validasi file upload di step terpisah

---

## 📝 Langkah 8: Buat Enum Form Step

**Lokasi**: `lib/presentation/viewmodels/surat/{lembaga}/{nama_surat}/enum/{nama_surat}_form_step.dart`

**Contoh**:

```dart
// lib/presentation/viewmodels/surat/ipnu/keputusan/enum/surat_keputusan_form_step.dart

enum SuratKeputusanFormStep {
  lembaga('Informasi Lembaga'),
  surat('Informasi Surat'),
  kepengurusan('Informasi Kepengurusan'),
  tandaTangan('Tanda Tangan');

  final String title;

  const SuratKeputusanFormStep(this.title);

  static List<String> get allTitles => values.map((e) => e.title).toList();

  SuratKeputusanFormStep? get next =>
      index < values.length - 1 ? values[index + 1] : null;

  SuratKeputusanFormStep? get previous =>
      index > 0 ? values[index - 1] : null;

  static int get totalSteps => values.length;
}
```

**Tips**:
- Sesuaikan jumlah step dengan kebutuhan form
- Nama step harus deskriptif
- Helper methods (`next`, `previous`, `totalSteps`) sudah standard

---

## 📝 Langkah 9: Buat Step Navigation Manager

**Lokasi**: `lib/presentation/viewmodels/surat/{lembaga}/{nama_surat}/managers/{nama_surat}_step_navigation_manager.dart`

**Contoh**:

```dart
// lib/presentation/viewmodels/surat/ipnu/keputusan/managers/surat_keputusan_step_navigation_manager.dart

import 'package:get/get.dart';
import '../enum/surat_keputusan_form_step.dart';

class SuratKeputusanStepNavigationManager {
  final currentStep = Rx<SuratKeputusanFormStep>(
    SuratKeputusanFormStep.lembaga,
  );

  void nextStep() {
    final next = currentStep.value.next;
    if (next != null) {
      currentStep.value = next;
    }
  }

  void previousStep() {
    final previous = currentStep.value.previous;
    if (previous != null) {
      currentStep.value = previous;
    }
  }

  void goToStep(SuratKeputusanFormStep step) {
    currentStep.value = step;
  }

  void reset() {
    currentStep.value = SuratKeputusanFormStep.lembaga;
  }

  bool get canGoNext => currentStep.value.next != null;
  bool get canGoPrevious => currentStep.value.previous != null;
  bool get isLastStep =>
      currentStep.value == SuratKeputusanFormStep.tandaTangan;
  bool get isFirstStep =>
      currentStep.value == SuratKeputusanFormStep.lembaga;

  int get currentStepIndex => currentStep.value.index;
  String get currentStepTitle => currentStep.value.title;
}
```

**Tips**:
- Pattern ini standard untuk semua form
- Hanya perlu ganti nama enum & step awal

---

## 📝 Langkah 10: Buat ViewModel

**Lokasi**: `lib/presentation/viewmodels/surat/{lembaga}/{nama_surat}/{nama_surat}_viewmodel.dart`

**Contoh (file akan panjang, lihat referensi lengkap di IPNU/IPPNU)**:

```dart
// lib/presentation/viewmodels/surat/ipnu/keputusan/surat_keputusan_ipnu_viewmodel.dart

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gen_surat/core/helper/field_error_focus_helper.dart';
import 'package:gen_surat/core/validator/email_validator.dart';
import 'package:get/get.dart';

import '../../../../../core/exception/validation_exception.dart';
import '../../../../../core/services/file_operation_service.dart';
import '../../../../../core/services/notification_service.dart';
import '../../../../../domain/repositories/i_generated_file_repository.dart';
import '../../../../../domain/usecases/ipnu/generate_surat_keputusan_ipnu_usecase.dart';
import '../../base_surat_viewmodel.dart';
import 'enum/surat_keputusan_form_step.dart';
import 'managers/surat_keputusan_ipnu_form_validator.dart';
import 'managers/surat_keputusan_ipnu_form_data_manager.dart';
import 'managers/surat_keputusan_step_navigation_manager.dart';

class SuratKeputusanIpnuViewmodel extends BaseSuratViewModel {
  final GenerateSuratKeputusanIpnuUseCase _generateUseCase;

  final SuratKeputusanIpnuFormDataManager formDataManager;
  final SuratKeputusanIpnuFormValidator formValidator;
  final SuratKeputusanStepNavigationManager stepNavigationManager;

  SuratKeputusanIpnuViewmodel(
    this._generateUseCase,
    IGeneratedFileRepository fileRepository,
    NotificationService notificationService,
    FileOperationService fileOperationService,
  )   : formDataManager = SuratKeputusanIpnuFormDataManager(),
        formValidator = SuratKeputusanIpnuFormValidator(),
        stepNavigationManager = SuratKeputusanStepNavigationManager(),
        super(
          fileRepository: fileRepository,
          notificationService: notificationService,
          fileOperationService: fileOperationService,
        );

  // Reactive variables untuk file upload
  final ttdKetuaFile = Rxn<File>();
  final ttdSekretarisFile = Rxn<File>();

  @override
  String get fileType => 'surat_keputusan';

  @override
  String get lembagaType => 'IPNU'; // atau 'IPPNU'

  @override
  String getSuratDescription() =>
      'Surat Keputusan IPNU ${formDataManager.namaLembaga}';

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

  void removeTtdKetua() => ttdKetuaFile.value = null;
  void removeTtdSekretaris() => ttdSekretarisFile.value = null;

  // Error focus fields per step
  Map<SuratKeputusanFormStep, List<FocusErrorField>>
      get _stepErrorFields => {
            SuratKeputusanFormStep.lembaga: [
              FocusErrorField(
                hasError: () => formDataManager.jenisLembaga.isEmpty,
                focusNode: formDataManager.jenisLembagaFocus,
              ),
              FocusErrorField(
                hasError: () => formDataManager.namaLembaga.isEmpty,
                focusNode: formDataManager.namaLembagaFocus,
              ),
              // ... field lainnya
            ],
            // ... steps lainnya
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
    );

    if (!validationResult.isValid) {
      errorMessage.value = validationResult.errorMessage;
      return;
    }

    try {
      startLoading();

      final entity = formDataManager.toEntity(
        ttdKetuaPath: ttdKetuaFile.value!.path,
        ttdSekretarisPath: ttdSekretarisFile.value!.path,
      );

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
    ttdKetuaFile.value = null;
    ttdSekretarisFile.value = null;
    errorMessage.value = null;
    generatedFile.value = null;
    uploadProgress.value = 0.0;
    stepNavigationManager.reset();
    formKey.currentState?.reset();
  }
}
```

**Tips**:
- Extend `BaseSuratViewModel`
- Implement semua abstract methods
- Gunakan `Rxn<File>()` untuk file upload
- Handle error dengan try-catch
- Reset state dengan method `resetForm()`

---

## 📝 Langkah 11: Buat Widgets untuk Form

### Widget Step (per step form)

**Lokasi**: `lib/presentation/pages/surat/{lembaga}/{nama_surat}/widgets/step_{nama_step}_section.dart`

**Contoh - Step Lembaga**:

```dart
// lib/presentation/pages/surat/ipnu/keputusan/widgets/step_lembaga_section.dart

import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/keputusan/surat_keputusan_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

class StepLembagaSection extends StatelessWidget {
  final SuratKeputusanIpnuViewmodel viewModel;

  const StepLembagaSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Informasi Lembaga'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan informasi lengkap tentang lembaga.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        CustomTextField(
          controller: viewModel.formDataManager.jenisLembagaController,
          focusNode: viewModel.formDataManager.jenisLembagaFocus,
          label: 'Tingkatan Lembaga *',
          helpText: 'Contoh: Pimpinan Ranting, Pimpinan Komisariat',
          hint: 'Masukkan tingkatan lembaga',
          icon: Icons.account_balance,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Tingkatan lembaga'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaLembagaController,
          focusNode: viewModel.formDataManager.namaLembagaFocus,
          label: 'Nama Desa/Sekolah *',
          helpText: 'Contoh: Desa Ngepeh',
          hint: 'Masukkan nama desa/sekolah',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.location_city,
          validator: UiFieldValidators.required('Nama desa/sekolah'),
        ),
        // ... field lainnya
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
```

**Tips untuk Widget**:
- Gunakan `CustomTextField` untuk input text
- Gunakan `DatePickerField` untuk tanggal
- Gunakan `SectionHeader` untuk judul section
- Gunakan `AppDimensions` untuk spacing konsisten
- Tambahkan `helpText` untuk guidance user
- Atur `textInputAction` untuk keyboard navigation

---

### Widget Tanda Tangan

**Contoh**:

```dart
// lib/presentation/pages/surat/ipnu/keputusan/widgets/step_tanda_tangan_section.dart

import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/keputusan/surat_keputusan_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/file_picker_widget.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:get/get.dart';

class StepTandaTanganSection extends StatelessWidget {
  final SuratKeputusanIpnuViewmodel viewModel;

  const StepTandaTanganSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Tanda Tangan'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Upload tanda tangan digital. File harus berformat gambar (JPG, PNG).',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        
        // Info box
        Container(
          padding: const EdgeInsets.all(AppDimensions.spaceM),
          decoration: BoxDecoration(
            color: AppColors.warning.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            border: Border.all(color: AppColors.warning),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.warning),
                  const SizedBox(width: AppDimensions.spaceS),
                  Text(
                    'Petunjuk Upload Tanda Tangan',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.warning,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.spaceS),
              // ... info list
            ],
          ),
        ),
        
        const SizedBox(height: AppDimensions.spaceM),
        
        // File picker untuk ketua
        Obx(
          () => FilePickerWidget(
            label: 'Tanda Tangan Ketua *',
            file: viewModel.ttdKetuaFile.value,
            onPick: () async {
              final file = await ImagePickerHelper.pickImage(context);
              if (file != null) {
                viewModel.setTtdKetua(file);
              }
            },
            onRemove: viewModel.removeTtdKetua,
          ),
        ),
        
        const SizedBox(height: AppDimensions.spaceM),
        
        // File picker untuk sekretaris
        Obx(
          () => FilePickerWidget(
            label: 'Tanda Tangan Sekretaris *',
            file: viewModel.ttdSekretarisFile.value,
            onPick: () async {
              final file = await ImagePickerHelper.pickImage(context);
              if (file != null) {
                viewModel.setTtdSekretaris(file);
              }
            },
            onRemove: viewModel.removeTtdSekretaris,
          ),
        ),
        
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
```

**Tips**:
- Gunakan `FilePickerWidget` untuk upload file
- `ImagePickerHelper.pickImage()` sudah handle permission
- Wrap dengan `Obx()` untuk reactivity

---

## 📝 Langkah 12: Buat Page

**Lokasi**: `lib/presentation/pages/surat/{lembaga}/{nama_surat}/{nama_surat}_page.dart`

**Contoh**:

```dart
// lib/presentation/pages/surat/ipnu/keputusan/surat_keputusan_ipnu_page.dart

import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/pages/surat/widgets/form_navigation_button.dart';
import 'package:gen_surat/presentation/routes/app_routes.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/keputusan/surat_keputusan_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/form_stepper_progress.dart';
import 'package:gen_surat/presentation/widgets/error_message_widget.dart';
import 'package:gen_surat/presentation/widgets/generated_file_card.dart';
import 'package:gen_surat/presentation/widgets/file_location_dialog.dart';
import 'package:gen_surat/presentation/widgets/reset_confirmation_dialog.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/keputusan/widgets/step_lembaga_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/keputusan/widgets/step_surat_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/keputusan/widgets/step_tanda_tangan_section.dart';
import 'package:get/get.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/keputusan/enum/surat_keputusan_form_step.dart';

class SuratKeputusanIpnuPage extends StatelessWidget {
  const SuratKeputusanIpnuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<SuratKeputusanIpnuViewmodel>();

    return Scaffold(
      appBar: _buildAppBar(context, vm),
      body: Form(
        key: vm.formKey,
        child: Column(
          children: [
            Obx(
              () => FormStepperProgress(
                currentStep: vm.currentStep.value.index,
                totalSteps: vm.totalSteps,
                stepTitles: vm.stepTitles,
              ),
            ),
            Expanded(child: Obx(() => _buildStepContent(vm))),
            _buildBottomSection(context, vm),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(
    BuildContext context,
    SuratKeputusanIpnuViewmodel vm,
  ) {
    return AppBar(
      title: const Text('Surat Keputusan'),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ResetConfirmationDialog.show(context, vm.resetForm),
          tooltip: 'Reset Form',
        ),
      ],
    );
  }

  Widget _buildStepContent(SuratKeputusanIpnuViewmodel vm) {
    switch (vm.currentStep.value) {
      case SuratKeputusanFormStep.lembaga:
        return StepLembagaSection(viewModel: vm);
      case SuratKeputusanFormStep.surat:
        return StepSuratSection(viewModel: vm);
      case SuratKeputusanFormStep.tandaTangan:
        return StepTandaTanganSection(viewModel: vm);
    }
  }

  Widget _buildBottomSection(
    BuildContext context,
    SuratKeputusanIpnuViewmodel vm,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildErrorSection(vm),
            _buildNavigationButtons(context, vm),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(
    BuildContext context,
    SuratKeputusanIpnuViewmodel vm,
  ) {
    return Obx(() {
      return FormNavigationButton(
        isLoading: vm.isLoading.value,
        uploadProgress: vm.uploadProgress.value,
        hasGeneratedFile: vm.generatedFile.value != null,
        generatedFileWidget: vm.generatedFile.value != null
            ? GeneratedFileCard(
                fileName: vm.getFileName(),
                fileSize: vm.getFileSize(),
                onShowLocation: () =>
                    FileLocationDialog.show(context, vm.getFilePath()),
                onOpen: vm.openGeneratedFile,
                onShare: vm.shareGeneratedFile,
              )
            : null,
        canGoPrevious: vm.canGoPrevious(),
        canGoNext: vm.canGoNext(),
        isLastStep: vm.isLastStep(),
        onPrevious: vm.previousStep,
        onNext: vm.nextStep,
        onGenerate: vm.generateSurat,
        onCancelLoading: vm.cancelGenerate,
        onDone: AppRoutes.back,
      );
    });
  }

  Widget _buildErrorSection(SuratKeputusanIpnuViewmodel vm) {
    return Obx(() {
      if (vm.errorMessage.value != null) {
        return ErrorMessageWidget(message: vm.errorMessage.value!);
      }
      return const SizedBox.shrink();
    });
  }
}
```

**Tips**:
- Pattern ini standard untuk semua page
- `FormNavigationButton` handle navigasi step & generate button
- `FormStepperProgress` tampilkan progress bar
- Wrap reactive widget dengan `Obx()`

---

## 📝 Langkah 13: Buat Binding

**Lokasi**: `lib/presentation/routes/bindings/{nama_surat}_binding.dart`

**Contoh**:

```dart
// lib/presentation/routes/bindings/surat_keputusan_ipnu_binding.dart

import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/ipnu/generate_surat_keputusan_ipnu_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/keputusan/surat_keputusan_ipnu_viewmodel.dart';
import 'package:get/get.dart';

/// Binding untuk Surat Keputusan IPNU
/// Auto-dispose saat page ditutup
class SuratKeputusanIpnuBinding extends Bindings {
  @override
  void dependencies() {
    // ViewModel akan otomatis di-dispose saat page ditutup
    Get.lazyPut<SuratKeputusanIpnuViewmodel>(
      () => SuratKeputusanIpnuViewmodel(
        Get.find<GenerateSuratKeputusanIpnuUseCase>(),
        Get.find<IGeneratedFileRepository>(),
        Get.find<NotificationService>(),
        Get.find<FileOperationService>(),
      ),
    );
  }
}
```

**Tips**:
- Gunakan `lazyPut` bukan `put`
- Jangan set `permanent: true` (auto-dispose)
- Dependencies sudah di-inject dari Domain Bindings

---

## 📝 Langkah 14: Update Domain Bindings

**Lokasi**: `lib/core/di/domain_bindings.dart`

**Tambahkan**:

```dart
// Import
import '../../domain/usecases/ipnu/generate_surat_keputusan_ipnu_usecase.dart';

// Di method dependencies()
Get.put(
  GenerateSuratKeputusanIpnuUseCase(Get.find<ISuratRepository>()),
  permanent: true, // Persistent, tidak di-dispose
);
```

**Tips**:
- UseCase harus `permanent: true`
- Inject `ISuratRepository` yang sudah ada
- Tambahkan di section IPNU atau IPPNU sesuai lembaga

---

## 📝 Langkah 15: Update App Routes

**Lokasi**: `lib/presentation/routes/app_routes.dart`

**Tambahkan import**:

```dart
import 'package:gen_surat/presentation/pages/surat/ipnu/keputusan/surat_keputusan_ipnu_page.dart';
import 'package:gen_surat/presentation/routes/bindings/surat_keputusan_ipnu_binding.dart';
```

**Tambahkan route**:

```dart
GetPage(
  name: RouteNames.suratKeputusanIpnu,
  page: () => const SuratKeputusanIpnuPage(),
  binding: SuratKeputusanIpnuBinding(),
  transition: Transition.rightToLeft,
  transitionDuration: const Duration(milliseconds: 300),
),
```

**Update RouteNames** di `lib/presentation/routes/route_names.dart`:

```dart
static const String suratKeputusanIpnu = '/surat-keputusan-ipnu';
```

---

## 📝 Langkah 16: Update Document Constants

**Lokasi**: `lib/core/constants/document_constants.dart`

**Tambahkan/Update**:

```dart
DocumentItem(
  title: 'Surat Keputusan',
  description: 'Pembuatan surat keputusan untuk kepengurusan IPNU',
  icon: Icons.gavel,
  route: RouteNames.suratKeputusanIpnu,
  isAvailable: true, // Set true untuk aktifkan menu
  gradient: [AppColors.ipnuPrimaryLight, AppColors.ipnuPrimaryDark],
),
```

**Tips**:
- `isAvailable: false` untuk menu yang belum siap
- Gunakan gradien sesuai lembaga (ipnu/ippnu)
- Icon dari Material Icons

---

## 🎨 Best Practices

### 1. **Naming Convention**

```
✅ GOOD:
- surat_keputusan_ipnu_entity.dart
- SuratKeputusanIpnuEntity
- generateSuratKeputusanIpnu()

❌ BAD:
- SuratKeputusanEntity.dart
- ipnu_surat_keputusan_entity.dart
- generate_surat()
```

### 2. **Code Organization**

```dart
// ✅ GOOD: Grouped by functionality
class MyViewModel {
  // 1. Dependencies
  final UseCase _useCase;
  
  // 2. Managers
  final FormDataManager formDataManager;
  final FormValidator formValidator;
  
  // 3. Reactive variables
  final isLoading = false.obs;
  final errorMessage = Rxn<String>();
  
  // 4. Constructor
  MyViewModel(this._useCase) : formDataManager = ...;
  
  // 5. Override methods
  @override
  void onInit() { }
  
  // 6. Public methods
  void nextStep() { }
  
  // 7. Private methods
  void _validate() { }
}
```

### 3. **Error Handling**

```dart
// ✅ GOOD: Specific error handling
try {
  // ...
} on ValidationException catch (e) {
  handleValidationError(e);
} on DioException catch (e) {
  handleDioError(e);
} catch (e) {
  handleUnexpectedError(e);
} finally {
  stopLoading();
}

// ❌ BAD: Generic catch
try {
  // ...
} catch (e) {
  print(e);
}
```

### 4. **Validation**

```dart
// ✅ GOOD: Use validators
CustomTextField(
  validator: UiFieldValidators.required('Nama desa/sekolah'),
)

// ✅ GOOD: Combine validators
validator: UiFieldValidators.combine([
  UiFieldValidators.required('Email'),
  UiFieldValidators.email('Email'),
])

// ❌ BAD: Inline validation
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Field required';
  }
  return null;
}
```

### 5. **Reactive Programming**

```dart
// ✅ GOOD: Wrap reactive value
Obx(() => Text(viewModel.errorMessage.value ?? ''))

// ✅ GOOD: Multiple reactive values
Obx(() {
  if (vm.isLoading.value) {
    return CircularProgressIndicator();
  }
  return MyWidget();
})

// ❌ BAD: Access value without Obx
Text(viewModel.errorMessage.value ?? '') // Won't update!
```

---

## 🐛 Troubleshooting

### Issue 1: File tidak ter-upload

**Penyebab**: Path file tidak valid atau file tidak exists

**Solusi**:
```dart
// Validasi di UseCase
final file = File(entity.ttdKetuaPath);
if (!file.existsSync()) {
  throw ValidationException('File tidak ditemukan');
}
```

### Issue 2: Form tidak validasi

**Penyebab**: Lupa panggil `validateForm()` di ViewModel

**Solusi**:
```dart
void nextStep() {
  if (!validateForm()) { // Pastikan dipanggil
    // Handle error
    return;
  }
  // Continue
}
```

### Issue 3: Navigation tidak jalan

**Penyebab**: Route belum didaftarkan di `app_routes.dart`

**Solusi**:
```dart
// 1. Tambah di RouteNames
static const String myRoute = '/my-route';

// 2. Tambah di AppRoutes.routes
GetPage(
  name: RouteNames.myRoute,
  page: () => const MyPage(),
  binding: MyBinding(),
),
```

### Issue 4: Dependency tidak ditemukan

**Penyebab**: UseCase belum didaftarkan di Domain Bindings

**Solusi**:
```dart
// lib/core/di/domain_bindings.dart
Get.put(
  GenerateMyUseCase(Get.find<ISuratRepository>()),
  permanent: true,
);
```

### Issue 5: Widget tidak update

**Penyebab**: Lupa wrap dengan `Obx()`

**Solusi**:
```dart
// ❌ BAD
Text(viewModel.text.value)

// ✅ GOOD
Obx(() => Text(viewModel.text.value))
```

---

## 📚 Referensi Lengkap

### File Referensi untuk Copy-Paste

**Untuk IPNU**:
- Entity: `lib/domain/entities/ipnu/surat_permohonan_pengesahan_ipnu_entity.dart`
- Model: `lib/data/models/ipnu/surat_permohonan_pengesahan_ipnu_model.dart`
- Mapper: `lib/data/mappers/ipnu/surat_permohonan_pengesahan_ipnu_mapper.dart`
- UseCase: `lib/domain/usecases/ipnu/generate_surat_permohonan_pengesahan_ipnu_usecase.dart`
- ViewModel: `lib/presentation/viewmodels/surat/ipnu/permohonan_pengesahan/surat_permohonan_pengesahan_ipnu_viewmodel.dart`
- Page: `lib/presentation/pages/surat/ipnu/permohonan_pengesahan/surat_permohonan_pengesahan_ipnu_page.dart`

**Untuk IPPNU**:
- Entity: `lib/domain/entities/ippnu/surat_permohonan_pengesahan_ippnu_entity.dart`
- Model: `lib/data/models/ippnu/surat_permohonan_pengesahan_ippnu_model.dart`
- Mapper: `lib/data/mappers/ippnu/surat_permohonan_pengesahan_ippnu_mapper.dart`
- UseCase: `lib/domain/usecases/ippnu/generate_surat_permohonan_pengesahan_ippnu_usecase.dart`
- ViewModel: `lib/presentation/viewmodels/surat/ippnu/permohonan_pengesahan/surat_permohonan_pengesahan_ippnu_viewmodel.dart`
- Page: `lib/presentation/pages/surat/ippnu/permohonan_pengesahan/surat_permohonan_pengesahan_ippnu_page.dart`

---

## 🚀 Quick Start Checklist

Gunakan checklist ini untuk memastikan tidak ada yang terlewat:

```
□ 1. Copy & rename Entity dari referensi
□ 2. Copy & rename Model dari referensi
□ 3. Copy & rename Mapper dari referensi
□ 4. Copy & rename UseCase dari referensi
□ 5. Update API endpoint di api_constants.dart
□ 6. Copy & rename Form Data Manager dari referensi
□ 7. Copy & rename Form Validator dari referensi
□ 8. Copy & rename Enum Form Step dari referensi
□ 9. Copy & rename Step Navigation Manager dari referensi
□ 10. Copy & rename ViewModel dari referensi
□ 11. Copy & rename semua widget step dari referensi
□ 12. Copy & rename Page dari referensi
□ 13. Copy & rename Binding dari referensi
□ 14. Update domain_bindings.dart
□ 15. Update route_names.dart
□ 16. Update app_routes.dart
□ 17. Update document_constants.dart
□ 18. Format semua file dengan Dart Formatter
□ 19. Test manual di emulator/device
□ 20. Commit & push ke repository
```

---

## 📞 Support

Jika menemui masalah:
1. Cek [Troubleshooting](#troubleshooting) di atas
2. Review referensi file yang sudah ada
3. Pastikan semua dependencies sudah teregistrasi
4. Check Dart Analysis untuk error

---

**Happy Coding! 🎉**

*Dokumentasi ini dibuat untuk mempermudah penambahan fitur baru dengan pola yang konsisten.*
