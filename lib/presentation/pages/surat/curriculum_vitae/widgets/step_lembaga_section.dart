import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/curriculum_vitae/curriculum_vitae_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

class StepLembagaSection extends StatelessWidget {
  final CurriculumVitaeViewmodel viewModel;

  const StepLembagaSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Informasi Pimpinan'),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.jenisLembagaController,
          focusNode: viewModel.formDataManager.jenisLembagaFocus,
          label: 'Tingkatan Pimpinan',
          helpText: 'Contoh: Pimpinan Ranting, Pimpinan Komisariat',
          hint: 'Masukkan tingkatan pimpinan',
          validator: UiFieldValidators.required('Tingkatan pimpinan'),
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.account_balance,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaLembagaController,
          focusNode: viewModel.formDataManager.namaLembagaFocus,
          label: 'Nama Desa/Sekolah',
          hint: 'Masukkan nama desa atau sekolah',
          helpText: 'Contoh: Desa Ngepeh, Madrasah Aliyah Nahdlatul Ulama Mojosari',
          validator: UiFieldValidators.required('Nama Desa/Sekolah'),
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.location_city,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.periodeKepengurusanController,
          focusNode: viewModel.formDataManager.periodeKepengurusanFocus,
          label: 'Periode Kepengurusan',
          hint: 'Masukkan periode kepengurusan',
          helpText: 'Contoh: 2024-2026',
          keyboardType: TextInputType.datetime,
          textInputAction: TextInputAction.next,
          icon: Icons.calendar_today,
          validator: UiFieldValidators.required('Periode Kepengurusan'),
        ),
      ],
    );
  }
}
