import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/kartu_identitas/kartu_identitas_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/widgets/section_header.dart';

class InformasiLembagaSection extends StatelessWidget {
  final KartuIdentitasViewmodel viewModel;

  const InformasiLembagaSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Informasi Lembaga'),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.jenisLembagaController,
          icon: Icons.account_balance,
          label: 'Tingkatan Lembaga',
          hint: 'Masukkan tingkatan lembaga',
          helpText: 'Tingkatan lembaga, Contoh: Pimpinan Ranting, Pimpinan Komisariat',
          validator: viewModel.formValidator.validateJenisLembaga,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaLembagaController,
          icon: Icons.location_city,
          label: 'Nama Desa/Madrasah',
          hint: 'Masukkan nama desa atau madrasah',
          helpText: 'Nama desa atau madrasah, Contoh: Desa Ngepeh, Madrasah Aliyah Nahdlatul Ulama Mojosari',
          validator: viewModel.formValidator.validateNamaLembaga,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.periodeKepengurusanController,
          icon: Icons.calendar_today,
          label: 'Periode Kepengurusan',
          hint: 'Masukkan periode kepengurusan',
          helpText: 'Periode kepengurusan pimpinan IPNU, Contoh: 2024-2026',
          keyboardType: TextInputType.datetime,
          textInputAction: TextInputAction.done,
          validator: viewModel.formValidator.validatePeriodeKepengurusan,
        ),
      ],
    );
  }
}
