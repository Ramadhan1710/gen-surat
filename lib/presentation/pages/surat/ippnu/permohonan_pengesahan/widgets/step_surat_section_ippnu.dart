import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/permohonan_pengesahan/surat_permohonan_pengesahan_ippnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:gen_surat/presentation/widgets/date_picker_field.dart';
import 'package:gen_surat/presentation/pages/surat/ippnu/permohonan_pengesahan/widgets/nomor_surat_form_widget_ippnu.dart';

/// Widget untuk step 2: Informasi Surat IPPNU
class StepSuratSectionIppnu extends StatelessWidget {
  final SuratPermohonanPengesahanIppnuViewmodel viewModel;

  const StepSuratSectionIppnu({
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
        NomorSuratFormWidgetIppnu(
          nomorSuratController: viewModel.formDataManager.nomorSuratController,
          validator: UiFieldValidators.required('Nomor surat'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        DatePickerField(
          controller: viewModel.formDataManager.tanggalRaptaController,
          label: 'Tanggal Rapat Anggota *',
          helpText:
              'Contoh: 1 September 2024, Tanggal rapat pemilihan pengurus baru (RAPTA) dilaksanakan.',
          hint: 'Masukkan tanggal rapat anggota',
          focusNode: viewModel.formDataManager.tanggalRaptaFocus,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Tanggal rapat anggota'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.nomorRaptaController,
          icon: Icons.format_list_numbered,
          label: 'Nomor RAPTA *',
          helpText: 'Contoh: IX, Periode RAPTA dilaksanakan.',
          hint: 'Masukkan nomor RAPTA',
          focusNode: viewModel.formDataManager.nomorRaptaFocus,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.characters,
          validator: UiFieldValidators.required('Nomor RAPTA'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tempatRaptaController,
          icon: Icons.place,
          label: 'Tempat Rapat Anggota *',
          helpText:
              'Contoh: Aula Gedung NU, Tempat dilaksanakannya rapat pemilihan pengurus baru (RAPTA).',
          hint: 'Masukkan tempat rapat anggota',
          focusNode: viewModel.formDataManager.tempatRaptaFocus,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          validator: UiFieldValidators.required('Tempat rapat anggota'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        DatePickerField(
          controller: viewModel.formDataManager.tanggalKeputusanController,
          label: 'Tanggal Keputusan *',
          helpText:
              'Contoh: 1 September 2024, Tanggal keputusan hasil Tim Formatur.',
          hint: 'Masukkan tanggal keputusan',
          focusNode: viewModel.formDataManager.tanggalKeputusanFocus,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Tanggal keputusan'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tanggalHijriahController,
          icon: Icons.calendar_today,
          label: 'Tanggal Pembuatan Surat (Hijriah) *',
          helpText:
              'Contoh: 1 Safar 1445, Tanggal pembuatan surat dalam format kalender Hijriah.',
          hint: 'Masukkan tanggal hijriah',
          focusNode: viewModel.formDataManager.tanggalHijriahFocus,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          validator: UiFieldValidators.required('Tanggal hijriah'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        DatePickerField(
          controller: viewModel.formDataManager.tanggalMasehiController,
          label: 'Tanggal Pembuatan Surat (Masehi) *',
          helpText:
              'Contoh: 10 September 2024, Tanggal pembuatan surat dalam format kalender Masehi.',
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
