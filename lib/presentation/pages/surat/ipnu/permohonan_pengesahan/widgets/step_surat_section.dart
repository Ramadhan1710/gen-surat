import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/permohonan_pengesahan/surat_permohonan_pengesahan_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:gen_surat/presentation/widgets/date_picker_field.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/widgets/nomor_surat_form_widget.dart';

/// Widget untuk step 2: Informasi Surat
class StepSuratSection extends StatelessWidget {
  final SuratPermohonanPengesahanIpnuViewmodel viewModel;

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
          nomorSuratController: viewModel.formDataManager.nomorSuratController,
          validator: UiFieldValidators.required('Nomor surat'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        DatePickerField(
          controller: viewModel.formDataManager.tanggalRapatController,
          label: 'Tanggal Rapat *',
          helpText: 'Tanggal pelaksanaan RAPTA (Rapat Anggota), Contoh: 15 Januari 2025',
          hint: 'Masukkan tanggal rapat',
          focusNode: viewModel.formDataManager.tanggalRapatFocus,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Tanggal rapat'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tanggalHijriahController,
          helpText: 'Tanggal hijriah penetapan surat, Contoh: 15 Rajab 1446',
          label: 'Tanggal Hijriah *',
          focusNode: viewModel.formDataManager.tanggalHijriahFocus,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan tanggal hijriah',
          validator: UiFieldValidators.required('Tanggal hijriah'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        DatePickerField(
          controller: viewModel.formDataManager.tanggalMasehiController,
          label: 'Tanggal Masehi *',
          helpText: 'Tanggal masehi penetapan surat, Contoh: 15 Januari 2025',
          hint: 'Masukkan tanggal masehi',
          focusNode: viewModel.formDataManager.tanggalMasehiFocus,
          textInputAction: TextInputAction.done,
          validator: UiFieldValidators.required('Tanggal masehi'),
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
