import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/permohonan_pengesahan/surat_permohonan_pengesahan_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

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
          focusNode: viewModel.formDataManager.periodeKepengurusanFocus,
          textInputAction: TextInputAction.next,
          icon: Icons.date_range,
          textCapitalization: TextCapitalization.words,
          validator: UiFieldValidators.required('Periode kepengurusan'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaKetuaTerpilihController,
          label: 'Nama Ketua Terpilih *',
          helpText: 'Nama lengkap ketua terpilih, Contoh: Ahmad Fauzi',
          hint: 'Masukkan nama lengkap ketua',
          focusNode: viewModel.formDataManager.namaKetuaTerpilihFocus,
          icon: Icons.person,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          validator: UiFieldValidators.required('Nama ketua terpilih'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller:
              viewModel.formDataManager.namaSekretarisTerpilihController,
          label: 'Nama Sekretaris Terpilih *',
          helpText: 'Nama lengkap sekretaris terpilih, Contoh: Budi Santoso',
          hint: 'Masukkan nama lengkap sekretaris',
          focusNode: viewModel.formDataManager.namaSekretarisTerpilihFocus,
          
          icon: Icons.person,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          validator: UiFieldValidators.required('Nama sekretaris terpilih'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.jenisLembagaIndukController,
          label: 'Jenis Lembaga Induk *',
          helpText:
              'Jenis lembaga induk, Contoh: Untuk PR : Ranting, Untuk PK : Madrasah/Sekolah, dll.',
          hint: 'Masukkan Tingkatan Pimpinan induk',
          focusNode: viewModel.formDataManager.jenisLembagaIndukFocus,
          icon: Icons.account_balance,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.done,
          validator: UiFieldValidators.required('Jenis lembaga induk'),
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
