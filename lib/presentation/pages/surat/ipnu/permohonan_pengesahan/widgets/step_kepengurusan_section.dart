import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/permohonan_pengesahan/surat_permohonan_pengesahan_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/widgets/section_header.dart';

/// Widget untuk step 3: Informasi Kepengurusan
class StepKepengurusanSection extends StatelessWidget {
  final SuratPermohonanPengesahanIpnuViewmodel viewModel;

  const StepKepengurusanSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Informasi Kepengurusan'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan informasi tentang kepengurusan yang akan disahkan.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        CustomTextField(
          controller: viewModel.formDataManager.periodeKepengurusanController,
          label: 'Periode Kepengurusan *',
          helpText:
              'Periode kepengurusan yang akan disahkan, Contoh: 2025-2027',
          hint: 'Masukkan periode kepengurusan',
          validator: _requiredValidator('Periode kepengurusan'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaKetuaTerpilihController,
          label: 'Nama Ketua Terpilih *',
          helpText: 'Nama lengkap ketua terpilih, Contoh: Ahmad Fauzi',
          hint: 'Masukkan nama lengkap ketua',
          validator: _requiredValidator('Nama ketua terpilih'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller:
              viewModel.formDataManager.namaSekretarisTerpilihController,
          label: 'Nama Sekretaris Terpilih *',
          helpText: 'Nama lengkap sekretaris terpilih, Contoh: Budi Santoso',
          hint: 'Masukkan nama lengkap sekretaris',
          validator: _requiredValidator('Nama sekretaris terpilih'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.jenisLembagaIndukController,
          label: 'Jenis Lembaga Induk *',
          helpText:
              'Jenis lembaga induk, Contoh: Untuk PR : Ranting, Untuk PK : Madrasah/Sekolah, dll.',
          hint: 'Masukkan jenis lembaga induk',
          validator: _requiredValidator('Jenis lembaga induk'),
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
