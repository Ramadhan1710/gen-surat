import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/sertifikat_kaderisasi/sertifikat_kaderisasi_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

class InformasiLembagaSection extends StatelessWidget {
  final SertifikatKaderisasiViewmodel viewModel;

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
          focusNode: viewModel.formDataManager.jenisLembagaFocus,
          icon: Icons.account_balance,
          label: 'Tingkatan Lembaga',
          hint: 'Masukkan tingkatan lembaga',
          helpText:
              'Tingkatan lembaga, Contoh: Pimpinan Ranting, Pimpinan Komisariat',
          validator: UiFieldValidators.required('Tingkatan Lembaga'),
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaLembagaController,
          focusNode: viewModel.formDataManager.namaLembagaFocus,
          icon: Icons.location_city,
          label: 'Nama Desa/Madrasah',
          hint: 'Masukkan nama desa atau madrasah',
          helpText:
              'Nama desa atau madrasah, Contoh: Desa Ngepeh, Madrasah Aliyah Nahdlatul Ulama Mojosari',
          validator: UiFieldValidators.required('Nama Desa/Madrasah'),
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.periodeKepengurusanController,
          focusNode: viewModel.formDataManager.periodeKepengurusanFocus,
          icon: Icons.calendar_today,
          label: 'Periode Kepengurusan',
          hint: 'Masukkan periode kepengurusan',
          helpText: 'Periode kepengurusan pimpinan IPNU, Contoh: 2024-2026',
          keyboardType: TextInputType.datetime,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Periode Kepengurusan'),
        ),
      ],
    );
  }
}
