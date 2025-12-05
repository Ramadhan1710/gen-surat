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
        const SectionHeader(title: 'Informasi Pimpinan'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan informasi lengkap tentang pimpinan yang mengeluarkan surat keputusan.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        CustomTextField(
          controller: viewModel.formDataManager.jenisLembagaController,
          label: 'Tingkatan Pimpinan *',
          helpText:
              'Tingkatan Pimpinan yang mengeluarkan SK, Contoh: Pimpinan Ranting atau Pimpinan Komisariat',
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
          helpText:
              'Nama lengkap desa atau sekolah, Contoh: Desa Ngepeh atau Madrasah Aliyah Nahdlatul Ulama Mojosari',
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
          helpText:
              'Periode kepengurusan yang akan disahkan, Contoh: 2025-2027',
          hint: 'Masukkan periode kepengurusan',
          validator: UiFieldValidators.required('Periode kepengurusan'),
          focusNode: viewModel.formDataManager.periodeKepengurusanFocus,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.datetime,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.ketuaTerpilihController,
          label: 'Ketua Terpilih *',
          helpText: 'Nama ketua yang terpilih, Contoh: Ahmad Fauzi',
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan nama ketua terpilih',
          validator: UiFieldValidators.required('Ketua terpilih'),
          focusNode: viewModel.formDataManager.ketuaTerpilihFocus,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.periodeRaptaController,
          label: 'Periode RAPTA *',
          helpText: 'Periode rapat anggota, Contoh: I, II, atau III',
          hint: 'Masukkan periode RAPTA',
          textCapitalization: TextCapitalization.characters,
          validator: UiFieldValidators.required('Periode RAPTA'),
          focusNode: viewModel.formDataManager.periodeRaptaFocus,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
