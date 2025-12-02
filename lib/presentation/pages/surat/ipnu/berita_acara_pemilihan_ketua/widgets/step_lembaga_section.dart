import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_pemilihan_ketua/berita_acara_pemilihan_ketua_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

class StepLembagaSection extends StatelessWidget {
  final BeritaAcaraPemilihanKetuaIpnuViewmodel viewModel;

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
          'Masukkan informasi lengkap tentang berita acara pemilihan ketua.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        CustomTextField(
          controller: viewModel.formDataManager.jenisLembagaController,
          label: 'Tingkatan Organisasi *',
          helpText: 
              'Contoh: Pimpinan Ranting, Pimpinan Komisariat, dll.',
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan tingkatan organisasi',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Tingkatan organisasi wajib diisi';
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaLembagaController,
          label: 'Nama Desa/Sekolah *',
          helpText:
              'Contoh: Desa Ngepeh, Madrasah Aliyah Nahdlatul Ulama',
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan nama desa/sekolah',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Nama desa/sekolah wajib diisi';
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.periodeKepengurusanController,
          label: 'Periode Kepengurusan *',
          helpText: 'Contoh: 2024-2026',
          hint: 'Masukkan periode kepengurusan',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Periode kepengurusan wajib diisi';
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
