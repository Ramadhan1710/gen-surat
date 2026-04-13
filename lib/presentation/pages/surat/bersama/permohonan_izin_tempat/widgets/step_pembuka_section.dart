import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/permohonan_izin_tempat/surat_permohonan_izin_tempat_bersama_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

class StepPembukaSection extends StatelessWidget {
  final SuratPermohonanIzinTempatBersamaViewmodel viewModel;

  const StepPembukaSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Bagian Pembuka Surat'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Isikan bagian pembuka surat dengan informasi yang sesuai.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        CustomTextField(
          controller: viewModel.formDataManager.nomorSuratController,
          focusNode: viewModel.formDataManager.nomorSuratFocus,
          label: 'Nomor Surat *',
          helpText: 'Contoh: 001/PAC/A/IX/7354.7355/V/2025',
          hint: 'Masukkan nomor surat',
          icon: Icons.numbers,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Nomor surat'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.lampiranController,
          focusNode: viewModel.formDataManager.lampiranFocus,
          label: 'Jumlah Lampiran *',
          helpText: 'Contoh: 1 Lampiran',
          hint: 'Masukkan jumlah lampiran',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.attach_file,
          validator: UiFieldValidators.required('Jumlah lampiran'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tujuanSuratController,
          focusNode: viewModel.formDataManager.tujuanSuratFocus,
          label: 'Tujuan Surat *',
          helpText: 'Contoh: Pimpinan Cabang IPNU Kab. Nganjuk',
          hint: 'Masukkan tujuan surat',
          icon: Icons.description,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.done,
          validator: UiFieldValidators.required('Tujuan surat'),
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
