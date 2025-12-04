import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_penyusunan_pengurus/berita_acara_penyusunan_pengurus_ippnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

class StepInformasiLembagaSection extends StatelessWidget {
  final BeritaAcaraPenyusunanPengurusIppnuViewmodel viewModel;

  const StepInformasiLembagaSection({super.key, required this.viewModel});

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
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        CustomTextField(
          controller: viewModel.formDataManager.jenisLembagaController,
          label: 'Jenis Lembaga *',
          helpText: 'Contoh: Pimpinan Ranting, Pimpinan Komisariat, dll.',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.jenisLembagaFocus,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan jenis lembaga',
          validator: UiFieldValidators.required('Jenis lembaga'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaLembagaController,
          label: 'Nama Lembaga *',
          helpText:
              'Contoh: Desa Ngepeh, Madrasah Aliyah Nahdlatul Ulama, dll.',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.namaLembagaFocus,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan nama lembaga',
          validator: UiFieldValidators.required('Nama lembaga'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.periodeKepengurusanController,
          label: 'Periode Kepengurusan *',
          helpText: 'Contoh: 2024-2026',
          hint: 'Masukkan periode kepengurusan',
          validator: UiFieldValidators.required('Periode kepengurusan'),
          focusNode: viewModel.formDataManager.periodeKepengurusanFocus,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.datetime,
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
