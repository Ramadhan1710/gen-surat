# 📋 Dokumentasi Panduan Menambah Fitur Baru

> **Dokumen ini dibuat:** 1 Desember 2025  
> **Project:** Gen Surat - Flutter Application  
> **Architecture:** Clean Architecture + GetX State Management

---

## 🎯 Tujuan Dokumentasi

Dokumentasi ini menjadi panduan lengkap untuk menambahkan fitur dokumen/surat baru ke dalam aplikasi Gen Surat, memastikan konsistensi dengan pattern yang sudah ada.

---

## 📚 Referensi Pattern

Fitur yang digunakan sebagai referensi: **Berita Acara Pemilihan Ketua IPNU**

### Struktur File Referensi:
```
lib/
├── domain/
│   ├── entities/ipnu/
│   │   └── berita_acara_pemilihan_ketua_ipnu_entity.dart
│   └── usecases/ipnu/
│       └── generate_berita_acara_pemilihan_ketua_ipnu_usecase.dart
├── data/
│   ├── models/ipnu/
│   │   └── berita_acara_pemilihan_ketua_ipnu_model.dart
│   └── mappers/ipnu/
│       └── berita_acara_pemilihan_ketua_ipnu_mapper.dart
├── presentation/
│   ├── viewmodels/surat/berita_acara_pemilihan_ketua/
│   │   ├── berita_acara_pemilihan_ketua_ipnu_viewmodel.dart
│   │   ├── enum/
│   │   │   └── berita_acara_pemilihan_ketua_form_step.dart
│   │   └── managers/
│   │       ├── ipnu/
│   │       │   ├── berita_acara_pemilihan_ketua_ipnu_form_data_manager.dart
│   │       │   └── berita_acara_pemilihan_ketua_ipnu_form_validator.dart
│   │       └── berita_acara_pemilihan_ketua_step_navigation_manager.dart
│   ├── pages/surat/ipnu/berita_acara_pemilihan_ketua/
│   │   ├── berita_acara_pemilihan_ketua_ipnu_page.dart
│   │   └── widgets/
│   │       ├── step_lembaga_section.dart
│   │       ├── step_pemilihan_ketua_section.dart
│   │       ├── step_pencalonan_ketua_section.dart
│   │       ├── step_pemilihan_section.dart
│   │       ├── step_ketua_terpilih_section.dart
│   │       ├── step_formatur_section.dart
│   │       ├── step_penetapan_section.dart
│   │       └── step_tanda_tangan_section.dart
│   └── widgets/
│       └── (shared widgets)
└── core/
    ├── constants/
    │   ├── api_constants.dart
    │   └── type_surat_constants.dart
    └── di/
        ├── domain_bindings.dart
        └── app_bindings.dart
```

---

## 🚀 Langkah-langkah Menambah Fitur Baru

### **TAHAP 1: Data Layer (Entity, Model, Mapper)**

#### 1.1 Buat Entity (Domain Layer)
📁 **Lokasi:** `lib/domain/entities/{lembaga}/{nama_fitur}_entity.dart`

**Contoh:** `lib/domain/entities/ipnu/susunan_pengurus_ipnu_entity.dart`

**Pattern:**
```dart
class NamaFiturEntity {
  // Properties dasar (required)
  final String field1;
  final String field2;
  final int field3;
  
  // Properties opsional
  final String? optionalField;
  
  // Array/List fields
  final List<NestedEntity> arrayField;
  
  // Boolean flags untuk conditional logic
  final bool hasSpecialFeature;

  const NamaFiturEntity({
    required this.field1,
    required this.field2,
    required this.field3,
    this.optionalField,
    this.arrayField = const [],
    this.hasSpecialFeature = false,
  });
}

// Nested entities untuk array fields
class NestedEntity {
  final String nama;
  final String alamat;
  
  const NestedEntity({
    required this.nama,
    required this.alamat,
  });
}
```

**Prinsip Entity:**
- ✅ Pure Dart classes, no dependencies
- ✅ Immutable (final fields, const constructor)
- ✅ Domain-centric naming (bahasa bisnis)
- ✅ Nested entities untuk array kompleks
- ❌ Jangan ada logic serialization
- ❌ Jangan ada Flutter dependencies

---

#### 1.2 Buat Model (Data Layer)
📁 **Lokasi:** `lib/data/models/{lembaga}/{nama_fitur}_model.dart`

**Pattern:**
```dart
class NamaFiturModel {
  final String field1;
  final String field2;
  final int field3;
  final String? optionalField;
  final List<NestedModel> arrayField;
  final bool hasSpecialFeature;

  NamaFiturModel({
    required this.field1,
    required this.field2,
    required this.field3,
    this.optionalField,
    this.arrayField = const [],
    this.hasSpecialFeature = false,
  });

  // Serialization to API (snake_case)
  Map<String, dynamic> toMap() {
    return {
      'field_1': field1,
      'field_2': field2,
      'field_3': field3,
      if (optionalField != null) 'optional_field': optionalField,
      'array_field': arrayField.map((e) => e.toMap()).toList(),
      'has_special_feature': hasSpecialFeature,
    };
  }

  // Untuk upload multipart
  Map<String, dynamic> toMultipartMap() {
    final map = toMap();
    // Convert complex types to JSON strings if needed
    map['array_field'] = jsonEncode(arrayField.map((e) => e.toMap()).toList());
    return map;
  }
}

class NestedModel {
  final String nama;
  final String alamat;

  NestedModel({
    required this.nama,
    required this.alamat,
  });

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'alamat': alamat,
    };
  }
}
```

**Prinsip Model:**
- ✅ Mirror Entity structure
- ✅ Implement toMap() dengan snake_case untuk API
- ✅ Implement toMultipartMap() untuk file upload
- ✅ Handle conditional serialization dengan `if`
- ✅ Nested models juga punya toMap()

---

#### 1.3 Buat Mapper (Data Layer)
📁 **Lokasi:** `lib/data/mappers/{lembaga}/{nama_fitur}_mapper.dart`

**Pattern:**
```dart
import 'package:gen_surat/data/models/{lembaga}/{nama_fitur}_model.dart';
import 'package:gen_surat/domain/entities/{lembaga}/{nama_fitur}_entity.dart';

class NamaFiturMapper {
  // Entity → Model (untuk dikirim ke API)
  static NamaFiturModel toModel(NamaFiturEntity entity) {
    return NamaFiturModel(
      field1: entity.field1,
      field2: entity.field2,
      field3: entity.field3,
      optionalField: entity.optionalField,
      arrayField: entity.arrayField
          .map((item) => NestedModel(
                nama: item.nama,
                alamat: item.alamat,
              ))
          .toList(),
      hasSpecialFeature: entity.hasSpecialFeature,
    );
  }

  // Model → Entity (jika perlu load dari API)
  static NamaFiturEntity toEntity(NamaFiturModel model) {
    return NamaFiturEntity(
      field1: model.field1,
      field2: model.field2,
      field3: model.field3,
      optionalField: model.optionalField,
      arrayField: model.arrayField
          .map((item) => NestedEntity(
                nama: item.nama,
                alamat: item.alamat,
              ))
          .toList(),
      hasSpecialFeature: model.hasSpecialFeature,
    );
  }
}
```

**Prinsip Mapper:**
- ✅ Static methods untuk conversion
- ✅ toModel() dan toEntity() bidirectional
- ✅ Map nested arrays dengan `.map()`

---

### **TAHAP 2: Domain Layer (UseCase)**

#### 2.1 Buat UseCase
📁 **Lokasi:** `lib/domain/usecases/{lembaga}/generate_{nama_fitur}_usecase.dart`

**Pattern:**
```dart
import 'dart:io';
import 'package:dio/dio.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/type_surat_constants.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/exception/validation_exception.dart';
import '../../../data/mappers/{lembaga}/{nama_fitur}_mapper.dart';
import '../../entities/{lembaga}/{nama_fitur}_entity.dart';
import '../../repositories/i_surat_repository.dart';

class GenerateNamaFiturUseCase {
  final ISuratRepository repository;
  
  GenerateNamaFiturUseCase(this.repository);

  Future<File> execute(
    NamaFiturEntity entity, {
    String? customSavePath,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    _validateEntity(entity);

    final model = NamaFiturMapper.toModel(entity);

    return await repository.generateSurat(
      data: model,
      lembaga: AppConstants.lembagaIpnu, // atau lembagaIppnu
      typeSurat: TypeSuratConstants.namaFitur,
      endpoint: ApiConstants.namaFiturEndpoint,
      toMultipartMap: (data) => data.toMultipartMap(),
      customSavePath: customSavePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  void _validateEntity(NamaFiturEntity entity) {
    // Validasi field required
    if (entity.field1.trim().isEmpty) {
      throw ValidationException('Field 1 tidak boleh kosong');
    }

    if (entity.field2.trim().isEmpty) {
      throw ValidationException('Field 2 tidak boleh kosong');
    }

    // Validasi array tidak kosong
    if (entity.arrayField.isEmpty) {
      throw ValidationException('Array field harus diisi minimal satu item');
    }

    // Validasi file jika ada
    if (entity.filePath.trim().isEmpty) {
      throw ValidationException('File path tidak boleh kosong');
    }

    final file = File(entity.filePath);
    if (!file.existsSync()) {
      throw ValidationException('File tidak ditemukan');
    }

    // Validasi conditional berdasarkan flag
    if (entity.hasSpecialFeature) {
      if (entity.optionalField == null || entity.optionalField!.trim().isEmpty) {
        throw ValidationException('Optional field wajib diisi jika special feature aktif');
      }
    }
  }
}
```

**Prinsip UseCase:**
- ✅ Single responsibility: generate surat
- ✅ Validasi entity sebelum kirim ke repository
- ✅ Mapping entity → model
- ✅ Return File hasil generate
- ✅ Support progress callback & cancel token

---

### **TAHAP 3: Presentation Layer - Form Components**

#### 3.1 Buat Form Step Enum
📁 **Lokasi:** `lib/presentation/viewmodels/surat/{nama_fitur}/enum/{nama_fitur}_form_step.dart`

**Pattern:**
```dart
enum NamaFiturFormStep {
  step1('Informasi Dasar'),
  step2('Data Array 1'),
  step3('Data Array 2'),
  step4('Informasi Tambahan'),
  step5('Tanda Tangan');

  final String title;

  const NamaFiturFormStep(this.title);

  static List<String> get allTitles => values.map((e) => e.title).toList();

  NamaFiturFormStep? get next =>
      index < values.length - 1 ? values[index + 1] : null;

  NamaFiturFormStep? get previous =>
      index > 0 ? values[index - 1] : null;

  static int get totalSteps => values.length;
}
```

**Tips:**
- Pisahkan step berdasarkan logical grouping
- Step terakhir biasanya untuk tanda tangan/konfirmasi
- Jumlah step: 5-8 untuk user experience yang baik

---

#### 3.2 Buat Form Data Manager
📁 **Lokasi:** `lib/presentation/viewmodels/surat/{nama_fitur}/managers/{lembaga}/{nama_fitur}_form_data_manager.dart`

**Pattern:**
```dart
import 'package:flutter/material.dart';
import 'package:gen_surat/domain/entities/{lembaga}/{nama_fitur}_entity.dart';

class NamaFiturFormDataManager {
  // ========== Simple Fields Controllers ==========
  final field1Controller = TextEditingController();
  final field2Controller = TextEditingController();
  final field3Controller = TextEditingController();

  // ========== Getters ==========
  String get field1 => field1Controller.text.trim();
  String get field2 => field2Controller.text.trim();
  int get field3 => int.tryParse(field3Controller.text.trim()) ?? 0;

  // ========== Array Management ==========
  final List<ArrayItemData> _arrayItems = [];
  
  List<ArrayItemData> get arrayItems => _arrayItems;
  int get arrayItemsCount => _arrayItems.length;

  // Listener untuk real-time updates
  VoidCallback? _onArrayItemChanged;

  void setOnArrayItemChangedListener(VoidCallback callback) {
    _onArrayItemChanged = callback;
    // Attach to existing items
    for (var item in _arrayItems) {
      item.someController.removeListener(_onArrayItemChanged!);
      item.someController.addListener(_onArrayItemChanged!);
    }
  }

  void addArrayItem({
    String nama = '',
    String alamat = '',
  }) {
    final controller = TextEditingController(text: '');
    if (_onArrayItemChanged != null) {
      controller.addListener(_onArrayItemChanged!);
    }
    
    _arrayItems.add(
      ArrayItemData(
        nomor: _arrayItems.length + 1,
        namaController: TextEditingController(text: nama),
        alamatController: TextEditingController(text: alamat),
        someController: controller,
      ),
    );
  }

  void removeArrayItem(int index) {
    if (index >= 0 && index < _arrayItems.length) {
      _arrayItems[index].dispose();
      _arrayItems.removeAt(index);
      _updateArrayItemNumbering();
    }
  }

  void _updateArrayItemNumbering() {
    for (int i = 0; i < _arrayItems.length; i++) {
      _arrayItems[i].nomor = i + 1;
    }
  }

  void clearArrayItems() {
    for (var item in _arrayItems) {
      item.dispose();
    }
    _arrayItems.clear();
  }

  // ========== Computed Properties ==========
  // Contoh: total dari array
  int get computedTotal {
    return _arrayItems.fold(
      0, 
      (int sum, ArrayItemData item) => sum + item.someValue,
    );
  }

  // ========== Clear & Dispose ==========
  void clear() {
    field1Controller.clear();
    field2Controller.clear();
    field3Controller.clear();
    clearArrayItems();
  }

  void dispose() {
    field1Controller.dispose();
    field2Controller.dispose();
    field3Controller.dispose();
    clearArrayItems();
  }

  // ========== To Entity ==========
  NamaFiturEntity toEntity({
    required String filePath, // jika ada file upload
  }) {
    return NamaFiturEntity(
      field1: field1,
      field2: field2,
      field3: field3,
      arrayField: _arrayItems
          .map((item) => NestedEntity(
                nama: item.namaController.text.trim(),
                alamat: item.alamatController.text.trim(),
              ))
          .toList(),
      filePath: filePath,
    );
  }
}

// ========== Data Classes ==========
class ArrayItemData {
  int nomor;
  final TextEditingController namaController;
  final TextEditingController alamatController;
  final TextEditingController someController;

  ArrayItemData({
    required this.nomor,
    required this.namaController,
    required this.alamatController,
    required this.someController,
  });

  void dispose() {
    namaController.dispose();
    alamatController.dispose();
    someController.dispose();
  }

  String get nama => namaController.text.trim();
  String get alamat => alamatController.text.trim();
  int get someValue => int.tryParse(someController.text.trim()) ?? 0;

  bool get isValid => nama.isNotEmpty && alamat.isNotEmpty;
}
```

**Prinsip Form Data Manager:**
- ✅ Mengelola semua TextEditingController
- ✅ Array management dengan add/remove/clear
- ✅ Listener support untuk real-time updates
- ✅ Computed properties untuk nilai kalkulasi
- ✅ toEntity() untuk convert ke domain entity
- ✅ dispose() untuk cleanup memory

---

#### 3.3 Buat Form Validator
📁 **Lokasi:** `lib/presentation/viewmodels/surat/{nama_fitur}/managers/{lembaga}/{nama_fitur}_form_validator.dart`

**Pattern:**
```dart
import 'dart:io';
import '../../../../../../core/exception/form_validation_result.dart';
import '../../../../../../core/validator/required_validator.dart';
import '../../enum/{nama_fitur}_form_step.dart';
import '{nama_fitur}_form_data_manager.dart';

class NamaFiturFormValidator {
  // Validasi per step
  FormValidationResult validateStep1({
    required String field1,
    required String field2,
  }) {
    return FormValidationResult.combine([
      RequiredValidator('Field 1').validate(field1),
      RequiredValidator('Field 2').validate(field2),
    ]);
  }

  FormValidationResult validateStep2({
    required List<ArrayItemData> arrayItems,
  }) {
    if (arrayItems.isEmpty) {
      return const FormValidationResult.error(
        'Array items harus diisi minimal satu item',
      );
    }

    // Validasi setiap item dalam array
    for (var i = 0; i < arrayItems.length; i++) {
      final item = arrayItems[i];
      final nama = item.namaController.text.trim();
      final alamat = item.alamatController.text.trim();

      final namaValidation = RequiredValidator(
        'Nama item no. ${i + 1}',
      ).validate(nama);
      if (!namaValidation.isValid) {
        return namaValidation;
      }

      final alamatValidation = RequiredValidator(
        'Alamat item no. ${i + 1}',
      ).validate(alamat);
      if (!alamatValidation.isValid) {
        return alamatValidation;
      }
    }

    return const FormValidationResult.success();
  }

  FormValidationResult validateFileStep({
    required File? file,
  }) {
    if (file == null) {
      return const FormValidationResult.error(
        'File belum dipilih',
      );
    }
    return const FormValidationResult.success();
  }

  // Master validator untuk dipanggil dari ViewModel
  FormValidationResult validateStep(
    NamaFiturFormStep step,
    NamaFiturFormDataManager formData, {
    File? file,
  }) {
    switch (step) {
      case NamaFiturFormStep.step1:
        return validateStep1(
          field1: formData.field1,
          field2: formData.field2,
        );
      case NamaFiturFormStep.step2:
        return validateStep2(
          arrayItems: formData.arrayItems,
        );
      case NamaFiturFormStep.step5:
        return validateFileStep(file: file);
      default:
        return const FormValidationResult.success();
    }
  }
}
```

**Prinsip Form Validator:**
- ✅ Validasi per step terpisah
- ✅ Gunakan RequiredValidator dari core
- ✅ Return FormValidationResult
- ✅ Validasi array dengan loop
- ✅ Master validateStep() untuk router

---

#### 3.4 Buat Step Navigation Manager
📁 **Lokasi:** `lib/presentation/viewmodels/surat/{nama_fitur}/managers/{nama_fitur}_step_navigation_manager.dart`

**Pattern:**
```dart
import 'package:get/get.dart';
import '../enum/{nama_fitur}_form_step.dart';

class NamaFiturStepNavigationManager {
  final currentStep = Rx<NamaFiturFormStep>(
    NamaFiturFormStep.step1,
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

  void goToStep(NamaFiturFormStep step) {
    currentStep.value = step;
  }

  void reset() {
    currentStep.value = NamaFiturFormStep.step1;
  }

  bool get canGoNext => currentStep.value.next != null;
  bool get canGoPrevious => currentStep.value.previous != null;
  bool get isLastStep => currentStep.value == NamaFiturFormStep.step5;
  bool get isFirstStep => currentStep.value == NamaFiturFormStep.step1;

  int get currentStepIndex => currentStep.value.index;
  String get currentStepTitle => currentStep.value.title;
}
```

---

#### 3.5 Buat ViewModel
📁 **Lokasi:** `lib/presentation/viewmodels/surat/{nama_fitur}/{nama_fitur}_{lembaga}_viewmodel.dart`

**Pattern:**
```dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gen_surat/core/exception/validation_exception.dart';
import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/usecases/{lembaga}/generate_{nama_fitur}_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/surat/base_surat_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/{nama_fitur}/enum/{nama_fitur}_form_step.dart';
import 'package:gen_surat/presentation/viewmodels/surat/{nama_fitur}/managers/{lembaga}/{nama_fitur}_form_data_manager.dart';
import 'package:gen_surat/presentation/viewmodels/surat/{nama_fitur}/managers/{lembaga}/{nama_fitur}_form_validator.dart';
import 'package:gen_surat/presentation/viewmodels/surat/{nama_fitur}/managers/{nama_fitur}_step_navigation_manager.dart';
import 'package:get/get.dart';

class NamaFiturViewmodel extends BaseSuratViewModel {
  final GenerateNamaFiturUseCase _generateNamaFiturUseCase;

  // Managers - composition pattern
  final NamaFiturFormDataManager formDataManager;
  final NamaFiturFormValidator formValidator;
  final NamaFiturStepNavigationManager stepNavigationManager;

  NamaFiturViewmodel(
    this._generateNamaFiturUseCase,
    IGeneratedFileRepository fileRepository,
    NotificationService notificationService,
    FileOperationService fileOperationService,
  )   : formDataManager = NamaFiturFormDataManager(),
        formValidator = NamaFiturFormValidator(),
        stepNavigationManager = NamaFiturStepNavigationManager(),
        super(
          fileRepository: fileRepository,
          notificationService: notificationService,
          fileOperationService: fileOperationService,
        ) {
    // Setup listeners untuk real-time updates
    formDataManager.setOnArrayItemChangedListener(() {
      _arrayItemVersion.value++;
    });
  }

  // ========== Specific State ==========
  final uploadedFile = Rxn<File>();
  
  // Observable counters untuk array rebuilds
  final _arrayItemVersion = 0.obs;

  // ========== Override Abstract Properties ==========
  @override
  String get fileType => 'nama_fitur';

  @override
  String get lembagaType => 'IPNU'; // atau 'IPPNU'

  @override
  String getSuratDescription() => 'Nama Fitur ${formDataManager.field1}';

  @override
  String getNomorSurat() => '';

  @override
  String getNamaLembaga() => formDataManager.field1;

  // ========== Specific Getters ==========
  Rx<NamaFiturFormStep> get currentStep => stepNavigationManager.currentStep;
  int get totalSteps => NamaFiturFormStep.totalSteps;
  List<String> get stepTitles => NamaFiturFormStep.allTitles;

  @override
  void onClose() {
    formDataManager.dispose();
    uploadedFile.close();
    super.onClose();
  }

  // ========== File Management ==========
  void setUploadedFile(File file) {
    uploadedFile.value = file;
    clearError();
  }

  void clearUploadedFile() {
    uploadedFile.value = null;
  }

  // ========== Array Management Delegates ==========
  void addArrayItem() {
    formDataManager.addArrayItem();
    _arrayItemVersion.value++;
  }

  void removeArrayItem(int index) {
    formDataManager.removeArrayItem(index);
    _arrayItemVersion.value++;
  }

  // ========== Navigation ==========
  Future<void> nextStep() async {
    // Trigger validation display
    formKey.currentState?.validate();
    
    final validation = formValidator.validateStep(
      currentStep.value,
      formDataManager,
      file: uploadedFile.value,
    );

    if (!validation.isValid) {
      showValidationError(validation.errorMessage ?? 'Validasi gagal');
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
  Future<void> generateSurat() async {
    try {
      setLoading(true);
      clearError();

      // Validasi final
      final validation = formValidator.validateStep(
        currentStep.value,
        formDataManager,
        file: uploadedFile.value,
      );

      if (!validation.isValid) {
        throw ValidationException(
          validation.errorMessage ?? 'Validasi gagal',
        );
      }

      final entity = formDataManager.toEntity(
        filePath: uploadedFile.value?.path ?? '',
      );

      final file = await _generateNamaFiturUseCase.execute(
        entity,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = (received / total * 100).toInt();
            setProgress(progress);
          }
        },
        cancelToken: cancelToken,
      );

      await saveGeneratedFile(
        file: file,
        description: getSuratDescription(),
        nomorSurat: getNomorSurat(),
        namaLembaga: getNamaLembaga(),
      );

      notificationService.showSuccess(
        'Surat berhasil dibuat',
        'File: ${file.path.split('/').last}',
      );

      resetForm();
    } on ValidationException catch (e) {
      setError(e.message);
      notificationService.showError('Validasi Gagal', e.message);
    } catch (e) {
      final errorMsg = 'Terjadi kesalahan: ${e.toString()}';
      setError(errorMsg);
      notificationService.showError('Gagal Generate Surat', errorMsg);
    } finally {
      setLoading(false);
      setProgress(0);
    }
  }

  @override
  void resetForm() {
    formDataManager.clear();
    clearUploadedFile();
    stepNavigationManager.reset();
    clearError();
    setProgress(0);
  }

  @override
  void cancelGeneration() {
    cancelToken.cancel('Dibatalkan oleh pengguna');
    setLoading(false);
    setProgress(0);
    notificationService.showInfo(
      'Dibatalkan',
      'Generate surat dibatalkan',
    );
  }
}
```

**Prinsip ViewModel:**
- ✅ Extends BaseSuratViewModel
- ✅ Composition: gunakan managers
- ✅ Observable counters untuk trigger Obx rebuilds
- ✅ Delegate array operations ke FormDataManager
- ✅ Validasi sebelum next step
- ✅ Generate surat dengan progress tracking

---

### **TAHAP 4: UI Layer**

#### 4.1 Buat Main Page
📁 **Lokasi:** `lib/presentation/pages/surat/{lembaga}/{nama_fitur}/{nama_fitur}_{lembaga}_page.dart`

**Pattern:**
```dart
import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/{nama_fitur}/enum/{nama_fitur}_form_step.dart';
import 'package:gen_surat/presentation/viewmodels/surat/{nama_fitur}/{nama_fitur}_{lembaga}_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/form_stepper_progress.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/widgets/error_message_widget.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/widgets/loading_progress_widget.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/widgets/generated_file_card.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/widgets/file_location_dialog.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/widgets/reset_confirmation_dialog.dart';
import 'package:gen_surat/presentation/pages/surat/{lembaga}/{nama_fitur}/widgets/step_1_section.dart';
import 'package:gen_surat/presentation/pages/surat/{lembaga}/{nama_fitur}/widgets/step_2_section.dart';
// Import semua step sections...
import 'package:get/get.dart';

class NamaFiturPage extends StatelessWidget {
  const NamaFiturPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<NamaFiturViewmodel>();

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

  AppBar _buildAppBar(BuildContext context, NamaFiturViewmodel vm) {
    return AppBar(
      title: const Text('Nama Fitur'),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ResetConfirmationDialog.show(context, vm.resetForm),
          tooltip: 'Reset Form',
        ),
      ],
    );
  }

  Widget _buildStepContent(NamaFiturViewmodel vm) {
    switch (vm.currentStep.value) {
      case NamaFiturFormStep.step1:
        return Step1Section(viewModel: vm);
      case NamaFiturFormStep.step2:
        return Step2Section(viewModel: vm);
      // ... semua steps
      default:
        return const SizedBox();
    }
  }

  Widget _buildBottomSection(BuildContext context, NamaFiturViewmodel vm) {
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() {
            if (vm.errorMessage.value.isNotEmpty) {
              return ErrorMessageWidget(message: vm.errorMessage.value);
            }
            if (vm.isLoading.value) {
              return LoadingProgressWidget(progress: vm.progress.value);
            }
            if (vm.generatedFile.value != null) {
              return GeneratedFileCard(
                file: vm.generatedFile.value!,
                onOpen: vm.openFile,
                onShare: vm.shareFile,
                onShowLocation: () =>
                    FileLocationDialog.show(context, vm.generatedFile.value!),
              );
            }
            return const SizedBox.shrink();
          }),
          const SizedBox(height: AppDimensions.spaceM),
          _buildNavigationButtons(vm),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(NamaFiturViewmodel vm) {
    return Obx(() {
      final isLastStep = vm.stepNavigationManager.isLastStep;
      final isFirstStep = vm.stepNavigationManager.isFirstStep;
      final isLoading = vm.isLoading.value;

      return Row(
        children: [
          if (!isFirstStep)
            Expanded(
              child: OutlinedButton.icon(
                onPressed: isLoading ? null : vm.previousStep,
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali'),
              ),
            ),
          if (!isFirstStep) const SizedBox(width: AppDimensions.spaceM),
          Expanded(
            flex: isFirstStep ? 1 : 2,
            child: FilledButton.icon(
              onPressed: isLoading
                  ? null
                  : (isLastStep ? vm.generateSurat : vm.nextStep),
              icon: Icon(isLastStep ? Icons.check : Icons.arrow_forward),
              label: Text(isLastStep ? 'Generate Surat' : 'Lanjut'),
            ),
          ),
        ],
      );
    });
  }
}
```

---

#### 4.2 Buat Step Section Widgets
📁 **Lokasi:** `lib/presentation/pages/surat/{lembaga}/{nama_fitur}/widgets/step_X_section.dart`

**Pattern untuk simple fields:**
```dart
import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/{nama_fitur}/{nama_fitur}_{lembaga}_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';

class Step1Section extends StatelessWidget {
  final NamaFiturViewmodel viewModel;

  const Step1Section({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informasi Dasar',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppDimensions.spaceM),
          
          CustomTextField(
            controller: viewModel.formDataManager.field1Controller,
            label: 'Field 1',
            hintText: 'Masukkan field 1',
            prefixIcon: Icons.info,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Field 1 tidak boleh kosong';
              }
              return null;
            },
          ),
          const SizedBox(height: AppDimensions.spaceS),
          
          CustomTextField(
            controller: viewModel.formDataManager.field2Controller,
            label: 'Field 2',
            hintText: 'Masukkan field 2',
            prefixIcon: Icons.edit,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Field 2 tidak boleh kosong';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
```

**Pattern untuk array fields:**
```dart
import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/{nama_fitur}/{nama_fitur}_{lembaga}_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:get/get.dart';

class Step2Section extends StatelessWidget {
  final NamaFiturViewmodel viewModel;

  const Step2Section({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Data Array',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              FilledButton.icon(
                onPressed: viewModel.addArrayItem,
                icon: const Icon(Icons.add),
                label: const Text('Tambah'),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceM),
          
          Obx(() {
            // Use version counter to trigger rebuild
            viewModel._arrayItemVersion.value;
            
            final items = viewModel.formDataManager.arrayItems;
            
            if (items.isEmpty) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.spaceL),
                  child: Center(
                    child: Text(
                      'Belum ada data. Klik "Tambah" untuk menambahkan.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              );
            }
            
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppDimensions.spaceS),
              itemBuilder: (context, index) {
                final item = items[index];
                return _buildArrayItemCard(context, item, index);
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildArrayItemCard(
    BuildContext context,
    ArrayItemData item,
    int index,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spaceM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Item ${item.nomor}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  onPressed: () => viewModel.removeArrayItem(index),
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.error,
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spaceS),
            
            CustomTextField(
              controller: item.namaController,
              label: 'Nama',
              hintText: 'Masukkan nama',
              prefixIcon: Icons.person,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: AppDimensions.spaceS),
            
            CustomTextField(
              controller: item.alamatController,
              label: 'Alamat',
              hintText: 'Masukkan alamat',
              prefixIcon: Icons.location_on,
              maxLines: 2,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Alamat tidak boleh kosong';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

---

### **TAHAP 5: Integration**

#### 5.1 Update API Constants
📁 **File:** `lib/core/constants/api_constants.dart`

```dart
static const String namaFiturIpnuEndpoint = "/ipnu/nama-fitur";
```

---

#### 5.2 Update Type Surat Constants
📁 **File:** `lib/core/constants/type_surat_constants.dart`

```dart
static const String namaFitur = 'nama_fitur';
```

---

#### 5.3 Register UseCase di Domain Bindings
📁 **File:** `lib/core/di/domain_bindings.dart`

```dart
Get.lazyPut(
  () => GenerateNamaFiturUseCase(
    Get.find<ISuratRepository>(),
  ),
  fenix: true,
);
```

---

#### 5.4 Register ViewModel di App Bindings
📁 **File:** `lib/core/di/app_bindings.dart`

```dart
Get.lazyPut(
  () => NamaFiturViewmodel(
    Get.find<GenerateNamaFiturUseCase>(),
    Get.find<IGeneratedFileRepository>(),
    Get.find<NotificationService>(),
    Get.find<FileOperationService>(),
  ),
  fenix: true,
);
```

---

#### 5.5 Add Route
📁 **File:** `lib/presentation/routes/route_names.dart`

```dart
static const String namaFiturIpnu = '/nama-fitur-ipnu';
```

📁 **File:** `lib/presentation/routes/app_routes.dart`

```dart
GetPage(
  name: RouteNames.namaFiturIpnu,
  page: () => const NamaFiturPage(),
  transition: Transition.rightToLeft,
  transitionDuration: const Duration(milliseconds: 300),
),
```

---

#### 5.6 Add to Document Menu
📁 **File:** `lib/core/constants/document_constants.dart`

```dart
DocumentModel(
  id: 'nama_fitur_ipnu',
  title: 'Nama Fitur',
  description: 'Deskripsi fitur',
  icon: Icons.description, // pilih icon yang sesuai
  route: RouteNames.namaFiturIpnu,
  organizationType: OrganizationType.ipnu,
  category: DocumentCategory.administrative, // sesuaikan kategori
),
```

---

## 📋 Checklist Lengkap

Gunakan checklist ini saat menambah fitur baru:

### Data Layer
- [ ] Entity created (`domain/entities/{lembaga}/{nama}_entity.dart`)
- [ ] Nested entities for arrays defined
- [ ] Model created (`data/models/{lembaga}/{nama}_model.dart`)
- [ ] Nested models for arrays defined
- [ ] toMap() implemented for all models
- [ ] toMultipartMap() implemented if needed
- [ ] Mapper created (`data/mappers/{lembaga}/{nama}_mapper.dart`)
- [ ] toModel() and toEntity() implemented

### Domain Layer
- [ ] UseCase created (`domain/usecases/{lembaga}/generate_{nama}_usecase.dart`)
- [ ] Entity validation implemented in UseCase
- [ ] File validation implemented if needed

### Presentation Layer - Form
- [ ] Form step enum created
- [ ] Form data manager created
- [ ] Array data classes created
- [ ] Array management methods implemented
- [ ] Listeners for real-time updates set up
- [ ] toEntity() method implemented
- [ ] Form validator created
- [ ] Validation per step implemented
- [ ] Step navigation manager created

### Presentation Layer - ViewModel
- [ ] ViewModel extends BaseSuratViewModel
- [ ] Managers instantiated (composition)
- [ ] Observable counters for arrays
- [ ] File state management (if needed)
- [ ] Override abstract properties
- [ ] Navigation methods (next/previous)
- [ ] Generate surat method
- [ ] Reset form method
- [ ] Cleanup in onClose()

### UI Layer
- [ ] Main page created
- [ ] AppBar with reset button
- [ ] Form stepper progress
- [ ] Step content router (switch case)
- [ ] Bottom section (error/loading/success)
- [ ] Navigation buttons
- [ ] All step section widgets created
- [ ] Simple fields sections
- [ ] Array fields sections with Obx

### Integration
- [ ] API endpoint constant added
- [ ] Type surat constant added
- [ ] UseCase registered in DomainBindings
- [ ] ViewModel registered in AppBindings
- [ ] Route name added
- [ ] Route page added
- [ ] Document added to DocumentConstants
- [ ] Test navigation dari menu

### Testing
- [ ] Form bisa diakses dari menu
- [ ] Semua field bisa diisi
- [ ] Array add/remove berfungsi
- [ ] Validasi per step berfungsi
- [ ] Navigation next/previous berfungsi
- [ ] Real-time updates berfungsi (jika ada)
- [ ] Generate surat berhasil
- [ ] File tersimpan dengan benar
- [ ] Reset form berfungsi

---

## 🎯 Tips & Best Practices

### 1. Naming Convention
- **Entity:** `{Nama}Entity` (PascalCase)
- **Model:** `{Nama}Model` (PascalCase)
- **Mapper:** `{Nama}Mapper` (PascalCase)
- **UseCase:** `Generate{Nama}UseCase` (PascalCase dengan "Generate" prefix)
- **FormDataManager:** `{Nama}FormDataManager`
- **FormValidator:** `{Nama}FormValidator`
- **ViewModel:** `{Nama}Viewmodel` (bukan ViewModel)
- **Page:** `{Nama}Page`
- **Section:** `Step{X}Section`

### 2. File Organization
```
Satu fitur = satu folder induk
├── viewmodels/surat/{nama_fitur}/
│   ├── {nama}_viewmodel.dart
│   ├── enum/
│   └── managers/
│       ├── {lembaga}/
│       └── step_navigation_manager.dart
└── pages/surat/{lembaga}/{nama_fitur}/
    ├── {nama}_page.dart
    └── widgets/
```

### 3. Array Management Pattern
- Gunakan observable counter untuk trigger rebuild
- Attach listener saat item ditambahkan
- Update numbering setelah remove
- Dispose controllers saat clear/remove

### 4. Real-time Updates
```dart
// Setup listener di constructor ViewModel
formDataManager.setOnArrayChangedListener(() {
  _arrayVersion.value++;
});

// Di UI gunakan Obx dengan version counter
Obx(() {
  viewModel._arrayVersion.value; // trigger
  final items = viewModel.formDataManager.items;
  // render items...
})
```

### 5. Validation Display
```dart
// Di nextStep() ViewModel
Future<void> nextStep() async {
  // Trigger validation display
  formKey.currentState?.validate();
  
  // Lalu validasi logic
  final validation = formValidator.validateStep(...);
  // ...
}
```

### 6. Conditional Fields
```dart
// Di Model toMap()
Map<String, dynamic> toMap() {
  return {
    'field': value,
    if (hasFeature) 'conditional_field': conditionalValue,
  };
}
```

### 7. Computed Properties
```dart
// Di FormDataManager
int get computedTotal {
  return _items.fold(0, (sum, item) => sum + item.value);
}

// Gunakan di toEntity()
totalField: computedTotal,
```

---

## ⚠️ Common Pitfalls

1. **Lupa dispose controllers** → Memory leak
2. **Tidak pakai version counter di Obx** → UI tidak update
3. **Validasi tidak dipanggil** → formKey.currentState?.validate()
4. **Array numbering tidak update** → Panggil _updateNumbering()
5. **Lupa register di DI** → Fitur tidak bisa diakses
6. **Entity mutable** → Gunakan final dan const
7. **Snake_case tidak konsisten di toMap()** → API error

---

## 📝 Contoh Kasus: Susunan Pengurus IPNU

Berikut contoh penerapan untuk fitur **Susunan Pengurus IPNU**:

### Karakteristik:
- 27 simple fields (text, number, boolean)
- 7 array fields (pelindung, pembina, wakil_ketua, dll)
- Nested arrays (departemen.anggota, lembaga.anggota)
- Conditional fields (hasLembagaCBP, hasDivisi)
- 2 computed fields (uppercase transformations)

### Steps yang direkomendasikan:
1. **Step 1:** Informasi Lembaga (jenis, nama, alamat, periode)
2. **Step 2:** Pelindung & Pembina (2 array)
3. **Step 3:** Ketua & Wakil (simple fields + array wakil ketua)
4. **Step 4:** Sekretaris & Wakil (simple fields + array wakil sekretaris)
5. **Step 5:** Bendahara & Wakil (simple fields)
6. **Step 6:** Departemen (array dengan nested anggota)
7. **Step 7:** Lembaga (array dengan nested anggota)
8. **Step 8:** CBP & Divisi (conditional, array divisi)

### Array Management:
- Simple array: Pelindung (nama saja)
- Complex array: Departemen (nama, koordinator, alamat, + anggota[])
- Conditional array: Divisi (hanya muncul jika hasDivisi = true)

---

## 🔄 Update Log

| Tanggal | Perubahan |
|---------|-----------|
| 2025-12-01 | Dokumentasi awal dibuat berdasarkan pattern Berita Acara Pemilihan Ketua IPNU |

---

## 📞 Support

Jika ada pertanyaan atau menemukan pattern yang perlu diupdate, silakan hubungi tim development.

---

**Happy Coding! 🚀**
