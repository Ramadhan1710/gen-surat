import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_pemilihan_ketua/berita_acara_pemilihan_ketua_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

class StepLembagaSection extends StatelessWidget {
  final BeritaAcaraPemilihanKetuaViewmodel viewModel;

  const StepLembagaSection({super.key, required this.viewModel});

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
          helpText: 'Contoh: Pimpinan Ranting atau Pimpinan Komisariat',
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
          helpText: 'Contoh: Desa Ngepeh atau Madrasah Aliyah Nahdlatul Ulama',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.namaLembagaFocus,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan nama desa atau sekolah',
          validator: UiFieldValidators.required('Nama desa/sekolah'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.periodeKepengurusanController,
          label: 'Periode Kepengurusan *',
          helpText: 'Contoh: 2024-2026',
          focusNode: viewModel.formDataManager.periodeKepengurusanFocus,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan periode kepengurusan',
          validator: UiFieldValidators.required('Periode kepengurusan'),
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
