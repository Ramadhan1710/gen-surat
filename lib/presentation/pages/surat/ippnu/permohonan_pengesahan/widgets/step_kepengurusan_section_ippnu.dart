import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/permohonan_pengesahan/surat_permohonan_pengesahan_ippnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

/// Widget untuk step 3: Informasi Kepengurusan IPPNU
class StepKepengurusanSectionIppnu extends StatelessWidget {
  final SuratPermohonanPengesahanIppnuViewmodel viewModel;

  const StepKepengurusanSectionIppnu({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Informasi Kepengurusan'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan informasi tentang kepengurusan yang akan disahkan.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        CustomTextField(
          controller: viewModel.formDataManager.periodeKepengurusanController,
          label: 'Periode Kepengurusan *',
          helpText:
              'Contoh: 2024-2026, Periode kepengurusan pengurus yang terpilih.',
          hint: 'Masukkan periode kepengurusan',
          focusNode: viewModel.formDataManager.periodeKepengurusanFocus,
          keyboardType: TextInputType.datetime,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Periode kepengurusan'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaKetuaTerpilihController,
          label: 'Nama Ketua Terpilih *',
          helpText:
              'Contoh: Siti Zahro, Nama lengkap ketua terpilih dalam rapat pemilihan pengurus.',
          hint: 'Masukkan nama lengkap ketua',
          focusNode: viewModel.formDataManager.namaKetuaTerpilihFocus,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          validator: UiFieldValidators.required('Nama ketua terpilih'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller:
              viewModel.formDataManager.namaSekretarisTerpilihController,
          label: 'Nama Sekretaris Terpilih *',
          helpText:
              'Contoh: Siti Aminah, Nama lengkap sekretaris terpilih dalam rapat pemilihan pengurus.',
          hint: 'Masukkan nama lengkap sekretaris',
          focusNode: viewModel.formDataManager.namaSekretarisTerpilihFocus,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          validator: UiFieldValidators.required('Nama sekretaris terpilih'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaLembagaIndukController,
          label: 'Nama Lembaga Induk *',
          helpText:
              'Contoh: PR NU Desa Ngepeh atau Kepala Madrasah, Nama lembaga induk dari lembaga yang bersangkutan.',
          hint: 'Masukkan nama desa/sekolah induk',
          focusNode: viewModel.formDataManager.namaLembagaIndukFocus,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          validator: UiFieldValidators.required('Nama lembaga induk'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tingkatLembagaController,
          label: 'Tingkat Lembaga *',
          helpText:
              'Contoh: Untuk PR : Ranting, Untuk PK : Komisariat, dll.',
          hint: 'Masukkan tingkat lembaga',
          focusNode: viewModel.formDataManager.tingkatLembagaFocus,
          textInputAction: TextInputAction.done,
          textCapitalization: TextCapitalization.words,
          validator: UiFieldValidators.required('Tingkat lembaga'),
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
