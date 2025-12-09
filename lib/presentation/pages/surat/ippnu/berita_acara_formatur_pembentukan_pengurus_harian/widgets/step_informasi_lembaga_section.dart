import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_formatur_pembentukan_pengurus_harian/berita_acara_formatur_pembentukan_pengurus_harian_ippnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

class StepInformasiLembagaSection extends StatelessWidget {
  final BeritaAcaraFormaturPembentukanPengurusHarianIppnuViewmodel viewModel;

  const StepInformasiLembagaSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Informasi Pimpinan'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan informasi lengkap tentang pimpinan.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        CustomTextField(
          controller: viewModel.formDataManager.jenisLembagaController,
          label: 'Tingkatan Pimpinan *',
          icon: Icons.apartment,
          helpText: 'Contoh: Pimpinan Ranting, Pimpinan Komisariat, dll.',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.jenisLembagaFocus,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan tingkatan pimpinan',
          validator: UiFieldValidators.required('Tingkatan pimpinan'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaLembagaController,
          label: 'Nama Desa/Sekolah *',
          helpText: 'Contoh: Desa Ngepeh, Madrasah Aliyah Nahdlatul Ulama',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.namaLembagaFocus,
          icon: Icons.location_city,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan nama desa/sekolah',
          validator: UiFieldValidators.required('Nama desa/sekolah'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.periodeKepengurusanController,
          label: 'Periode Kepengurusan *',
          helpText: 'Contoh: 2024-2026',
          hint: 'Masukkan periode kepengurusan',
          icon: Icons.calendar_today,
          validator: UiFieldValidators.required('Periode kepengurusan'),
          focusNode: viewModel.formDataManager.periodeKepengurusanFocus,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tingkatLembagaController,
          icon: Icons.apartment,
          label: 'Tingkat Pimpinan *',
          helpText: 'Untuk PR: Ranting, Untuk PK: Komisariat',
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan tingkat pimpinan',
          validator: UiFieldValidators.required('Tingkat pimpinan'),
          focusNode: viewModel.formDataManager.tingkatLembagaFocus,
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
