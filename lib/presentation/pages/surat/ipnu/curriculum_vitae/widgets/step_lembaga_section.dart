import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/curriculum_vitae/curriculum_vitae_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/widgets/section_header.dart';

class StepLembagaSection extends StatelessWidget {
  final CurriculumVitaeViewmodel viewModel;

  const StepLembagaSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Informasi Lembaga'),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.jenisLembagaController,
          label: 'Tingkatan Lembaga',
          helpText: 'Tingkatan lembaga, Contoh: Pimpinan Ranting, Pimpinan Komisariat',
          hint: 'Masukkan tingkatan lembaga',
          validator: viewModel.formValidator.validateJenisLembaga,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.account_balance,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaLembagaController,
          label: 'Nama Desa/Madrasah',
          hint: 'Masukkan nama desa atau madrasah',
          helpText: 'Nama desa atau madrasah, Contoh: Desa Ngepeh, Madrasah Aliyah Nahdlatul Ulama Mojosari',
          validator: viewModel.formValidator.validateNamaLembaga,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.location_city,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.periodeKepengurusanController,
          label: 'Periode Kepengurusan',
          hint: 'Masukkan periode kepengurusan',
          helpText: 'Periode kepengurusan pimpinan IPNU, Contoh: 2024-2026',
          keyboardType: TextInputType.datetime,
          textInputAction: TextInputAction.done,
          icon: Icons.calendar_today,
          validator: viewModel.formValidator.validatePeriodeKepengurusan,
        ),
      ],
    );
  }
}
