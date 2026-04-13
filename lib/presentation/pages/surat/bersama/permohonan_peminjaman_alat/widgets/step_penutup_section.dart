import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/permohonan_peminjaman_alat/surat_permohonan_peminjaman_alat_bersama_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

class StepPenutupSection extends StatelessWidget {
  final SuratPermohonanPeminjamanAlatBersamaViewmodel viewModel;

  const StepPenutupSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Bagian Penutup Surat'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Isikan bagian penutup surat dengan informasi yang sesuai.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        CustomTextField(
          controller: viewModel.formDataManager.tanggalHijriahController,
          focusNode: viewModel.formDataManager.tanggalHijriahFocus,
          label: 'Tanggal Hijriah *',
          helpText: 'Contoh: 12 Rojab 1446',
          hint: 'Masukkan tanggal hijriah pembuatan surat',
          icon: Icons.event,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Tanggal hijriah'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tanggalMasehiController,
          focusNode: viewModel.formDataManager.tanggalMasehiFocus,
          label: 'Tanggal Masehi *',
          helpText: 'Contoh: 26 Juni 2025',
          hint: 'Masukkan tanggal masehi pembuatan surat',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.attach_file,
          validator: UiFieldValidators.required('Tanggal masehi'),
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
