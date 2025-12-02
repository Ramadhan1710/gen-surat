import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_rapat_formatur/berita_acara_rapat_formatur_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/widgets/section_header.dart';

class StepLembagaSection extends StatelessWidget {
  final BeritaAcaraRapatFormaturViewmodel viewModel;

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
          hint: 'Masukkan tingkatan lembaga',
          helpText:
              'Tingkatan lembaga yang mengadakan rapat formatur, Contoh: Pimpinan Ranting (PR) atau Pimpinan Komisariat (PK)',
          icon: Icons.corporate_fare,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          validator: viewModel.formValidator.validateJenisLembaga,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaLembagaController,
          label: 'Nama Desa/Sekolah',
          hint: 'Masukkan nama desa/sekolah',
          helpText: 'Contoh: Desa Ngepeh, Madrasah Aliyah Nahdlatul Ulama Mojosari',
          icon: Icons.business,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.done,
          validator: viewModel.formValidator.validateNamaLembaga,
        ),
      ],
    );
  }
}
