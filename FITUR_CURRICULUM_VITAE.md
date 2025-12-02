# Fitur Curriculum Vitae (CV) Pengurus Harian

## Ringkasan
Fitur ini memungkinkan pembuatan dokumen Curriculum Vitae (CV) untuk pengurus harian (Ketua, Sekretaris, dan Bendahara) dari suatu lembaga IPNU.

## Struktur File yang Dibuat

### 1. Domain Layer
**Entity:**
- `lib/domain/entities/ipnu/curriculum_vitae_entity.dart`
  - `CurriculumVitaeEntity`: Data utama CV
  - `OrganisasiEntity`: Data pengalaman organisasi
  - `PendidikanEntity`: Data riwayat pendidikan

**UseCase:**
- `lib/domain/usecases/ipnu/generate_curriculum_vitae_usecase.dart`
  - Validasi lengkap untuk semua field
  - Generate CV menggunakan repository pattern

### 2. Data Layer
**Model:**
- `lib/data/models/ipnu/curriculum_vitae_model.dart`
  - Mapping ke multipart form untuk upload file
  - Support upload foto untuk 3 pengurus

**Mapper:**
- `lib/data/mappers/ipnu/curriculum_vitae_mapper.dart`
  - Konversi antara Entity dan Model

### 3. Presentation Layer

**ViewModel:**
- `lib/presentation/viewmodels/surat/curriculum_vitae/curriculum_vitae_viewmodel.dart`
  - Extends `BaseSuratViewModel`
  - Manage state untuk 7 step form
  - Handle image picker untuk foto pengurus

**Form Managers:**
- `lib/presentation/viewmodels/surat/curriculum_vitae/managers/curriculum_vitae_form_data_manager.dart`
  - Manage semua TextEditingController
  - Handle dynamic list (organisasi & pendidikan)
  
- `lib/presentation/viewmodels/surat/curriculum_vitae/managers/curriculum_vitae_form_validator.dart`
  - Validasi untuk semua field
  
- `lib/presentation/viewmodels/surat/curriculum_vitae/managers/curriculum_vitae_step_navigation_manager.dart`
  - Manage navigasi antar step

**Enum:**
- `lib/presentation/viewmodels/surat/curriculum_vitae/enum/curriculum_vitae_form_step.dart`
  - 7 step: Lembaga, Data Ketua, Org&Pend Ketua, Data Sekretaris, Org&Pend Sekretaris, Data Bendahara, Org&Pend Bendahara

**Pages & Widgets:**
- `lib/presentation/pages/surat/ipnu/curriculum_vitae/curriculum_vitae_page.dart`
  - Main page dengan stepper progress
  - Navigation buttons
  - Generated file card

**Widget Sections:**
- `lib/presentation/pages/surat/ipnu/curriculum_vitae/widgets/step_lembaga_section.dart`
- `lib/presentation/pages/surat/ipnu/curriculum_vitae/widgets/step_data_ketua_section.dart`
- `lib/presentation/pages/surat/ipnu/curriculum_vitae/widgets/step_organisasi_pendidikan_ketua_section.dart`
- `lib/presentation/pages/surat/ipnu/curriculum_vitae/widgets/step_data_sekretaris_section.dart`
- `lib/presentation/pages/surat/ipnu/curriculum_vitae/widgets/step_organisasi_pendidikan_sekretaris_section.dart`
- `lib/presentation/pages/surat/ipnu/curriculum_vitae/widgets/step_data_bendahara_section.dart`
- `lib/presentation/pages/surat/ipnu/curriculum_vitae/widgets/step_organisasi_pendidikan_bendahara_section.dart`

### 4. Routing & Dependency Injection
**Binding:**
- `lib/presentation/routes/bindings/curriculum_vitae_binding.dart`

**Route:**
- Route name: `curriculumVitaeIpnu` di `route_names.dart`
- Route configuration di `app_routes.dart`
- Path: `/curriculum-vitae-ipnu`

**UseCase Registration:**
- `GenerateCurriculumVitaeUseCase` di `domain_bindings.dart`

## Data yang Dikumpulkan

### Informasi Lembaga
- Jenis Lembaga
- Nama Lembaga
- Periode Kepengurusan

### Data Per Pengurus (Ketua, Sekretaris, Bendahara)
**Data Pribadi:**
- Nama Lengkap
- Tempat Tanggal Lahir
- NIA (Nomor Induk Anggota)
- Alamat
- Motto Hidup
- Nomor HP
- Email
- Foto (upload file)

**Pengalaman Organisasi (Dynamic List):**
- Nama Organisasi

**Riwayat Pendidikan (Dynamic List):**
- Tingkat Pendidikan
- Nama Institusi

## Fitur Utama

### 1. Multi-Step Form (7 Steps)
- Progress indicator untuk tracking
- Validasi per step
- Navigation yang smooth

### 2. Dynamic Form Fields
- Tambah/Hapus pengalaman organisasi
- Tambah/Hapus riwayat pendidikan
- Real-time update dengan Obx

### 3. File Upload
- Support upload foto untuk 3 pengurus
- Image picker integration
- Preview nama file yang dipilih

### 4. Validation
- Field validation per input
- Step validation sebelum lanjut
- Final validation sebelum generate

### 5. Generate & Preview
- Generate CV ke format .docx
- Preview file yang dihasilkan
- Share & Open file
- Show file location

## API Endpoint
```
POST /ipnu/curriculum-vitae
Content-Type: multipart/form-data
```

## Cara Menggunakan

1. **Navigasi ke Halaman CV**
   ```dart
   AppRoutes.toNamed(RouteNames.curriculumVitaeIpnu);
   ```

2. **Isi Form Bertahap**
   - Step 1: Informasi Lembaga
   - Step 2-7: Data Ketua, Sekretaris, Bendahara beserta organisasi & pendidikan

3. **Upload Foto**
   - Klik tombol pilih foto
   - Pilih dari galeri/kamera
   - Lihat preview nama file

4. **Generate CV**
   - Klik tombol "Generate CV"
   - Tunggu proses upload
   - File akan tersimpan otomatis

5. **Aksi File**
   - Buka file
   - Share file
   - Lihat lokasi file

## Pattern yang Digunakan

### Clean Architecture
- **Domain Layer**: Entity, UseCase, Repository Interface
- **Data Layer**: Model, Mapper, Repository Implementation  
- **Presentation Layer**: ViewModel, Pages, Widgets

### Design Patterns
- **Repository Pattern**: Abstraksi data access
- **Mapper Pattern**: Konversi Entity ↔ Model
- **Manager Pattern**: Separation of concerns (FormDataManager, FormValidator, NavigationManager)
- **MVVM**: ViewModel manage state, View observe & display

### State Management
- **GetX**: Reactive programming dengan Obx
- **Observable**: Rx variables untuk reactive update
- **Version Counter**: Trigger rebuild untuk dynamic lists

## Catatan Penting

1. **Validation**
   - Semua field required kecuali yang explicitly optional
   - Email & phone number validation
   - Minimal 1 organisasi & 1 pendidikan per pengurus

2. **File Upload**
   - Support .jpg & .png untuk foto
   - File akan di-compress jika terlalu besar (handled by backend)

3. **Memory Management**
   - Semua TextEditingController di-dispose dengan benar
   - ViewModel auto-dispose saat leave page (GetX LazyPut)
   - Clear lists saat reset form

4. **Error Handling**
   - ValidationException untuk validasi error
   - Network error handling di usecase
   - User-friendly error messages

## TODO (Opsional untuk Enhancement)

- [ ] Add offline storage untuk draft CV
- [ ] Add preview PDF sebelum download
- [ ] Add template selection untuk berbagai format CV
- [ ] Add export to multiple formats (PDF, Word)
- [ ] Add batch upload foto
- [ ] Add crop & resize foto
- [ ] Add auto-save draft
- [ ] Add history CV yang pernah dibuat
