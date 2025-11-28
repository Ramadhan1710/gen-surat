import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/surat_permohonan_pengesahan_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/pages/surat/widgets/section_header.dart';
import 'package:gen_surat/presentation/pages/surat/widgets/date_picker_field.dart';
import 'package:gen_surat/presentation/pages/surat/widgets/nomor_surat_form_widget.dart';

/// Widget untuk step 2: Informasi Surat
class StepSuratSection extends StatelessWidget {
  final SuratPermohonanPengesahanIpnuViewModel viewModel;

  const StepSuratSection({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Informasi Surat'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan informasi terkait surat permohonan pengesahan dan tanggal rapat.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        NomorSuratFormWidget(
          nomorSuratController: viewModel.nomorSuratController,
          validator: _requiredValidator('Nomor surat'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        DatePickerField(
          controller: viewModel.tanggalRapatController,
          label: 'Tanggal Rapat *',
          helpText: 'Tanggal pelaksanaan RAPTA (Rapat Anggota), Contoh: 15 Januari 2025',
          hint: 'Masukkan tanggal rapat',
          validator: _requiredValidator('Tanggal rapat'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.tanggalHijriahController,
          helpText: 'Tanggal hijriah penetapan surat, Contoh: 15 Rajab 1446',
          label: 'Tanggal Hijriah *',
          hint: 'Masukkan tanggal hijriah',
          validator: _requiredValidator('Tanggal hijriah'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        DatePickerField(
          controller: viewModel.tanggalMasehiController,
          label: 'Tanggal Masehi *',
          helpText: 'Tanggal masehi penetapan surat, Contoh: 15 Januari 2025',
          hint: 'Masukkan tanggal masehi',
          validator: _requiredValidator('Tanggal masehi'),
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
