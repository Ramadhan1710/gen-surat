import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/keputusan/surat_keputusan_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

/// Widget untuk step 1: Informasi Lembaga
/// Berisi informasi lembaga, periode kepengurusan, dan ketua terpilih
class StepLembagaSection extends StatelessWidget {
  final SuratKeputusanIpnuViewmodel viewModel;

  const StepLembagaSection({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Informasi Lembaga'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan informasi lengkap tentang lembaga yang mengeluarkan surat keputusan.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        CustomTextField(
          controller: viewModel.formDataManager.jenisLembagaController,
          label: 'Jenis Lembaga *',
          helpText:
              'Jenis lembaga yang mengeluarkan SK, Contoh: Pimpinan Ranting atau Pimpinan Komisariat',
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan jenis lembaga',
          validator: _requiredValidator('Jenis lembaga'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaLembagaController,
          label: 'Nama Desa/Sekolah *',
          helpText: 'Nama lengkap desa atau sekolah, Contoh: Desa Ngepeh atau Madrasah Aliyah Nahdlatul Ulama',
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan nama desa atau sekolah',
          validator: _requiredValidator('Nama lembaga'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.periodeKepengurusanController,
          label: 'Periode Kepengurusan *',
          helpText: 'Periode kepengurusan yang akan disahkan, Contoh: 2025-2027',
          hint: 'Masukkan periode kepengurusan',
          validator: _requiredValidator('Periode kepengurusan'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.ketuaTerpilihController,
          label: 'Ketua Terpilih *',
          helpText: 'Nama ketua yang terpilih, Contoh: Ahmad Fauzi',
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan nama ketua terpilih',
          validator: _requiredValidator('Ketua terpilih'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.periodeRaptaController,
          label: 'Periode RAPTA *',
          helpText:
              'Periode rapat anggota, Contoh: I, II, atau III',
          
          hint: 'Masukkan periode RAPTA',
          textCapitalization: TextCapitalization.characters,
          validator: _requiredValidator('Periode RAPTA'),
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }

  String? Function(String?) _requiredValidator(String fieldName) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return '$fieldName wajib diisi';
      }
      return null;
    };
  }
}
