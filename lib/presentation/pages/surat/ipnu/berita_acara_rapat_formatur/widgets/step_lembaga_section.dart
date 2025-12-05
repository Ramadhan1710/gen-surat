import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/berita_acara_rapat_formatur/berita_acara_rapat_formatur_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

class StepLembagaSection extends StatelessWidget {
  final BeritaAcaraRapatFormaturIpnuViewmodel viewModel;

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
          label: 'Tingkatan Pimpinan *',
          hint: 'Masukkan tingkatan pimpinan',
          helpText:
              'Tingkatan Pimpinan yang mengadakan rapat formatur, Contoh: Pimpinan Ranting (PR) atau Pimpinan Komisariat (PK)',
          icon: Icons.corporate_fare,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Tingkatan pimpinan'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaLembagaController,
          focusNode: viewModel.formDataManager.namaLembagaFocus,
          label: 'Nama Desa/Sekolah *',
          hint: 'Masukkan nama desa/sekolah',
          helpText:
              'Contoh: Desa Ngepeh, Madrasah Aliyah Nahdlatul Ulama Mojosari',
          icon: Icons.business,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Nama Desa/Sekolah'),
        ),
      ],
    );
  }
}
