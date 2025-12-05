import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_formatur_pembentukan_pengurus_harian/berita_acara_formatur_pembentukan_pengurus_harian_ippnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

class StepPenetapanSection extends StatelessWidget {
  final BeritaAcaraFormaturPembentukanPengurusHarianIppnuViewmodel viewModel;

  const StepPenetapanSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Penetapan Berita Acara'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan informasi penetapan berita acara formatur.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        CustomTextField(
          controller: viewModel.formDataManager.tanggalPenyusunanController,
          label: 'Tanggal Penyusunan *',
          helpText: 'Contoh: 15 Januari 2024',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.tanggalPenyusunanFocus,
          textInputAction: TextInputAction.next,
          icon: Icons.date_range,
          hint: 'Masukkan tanggal penyusunan',
          validator: UiFieldValidators.required('Tanggal penyusunan'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tempatPenyusunanController,
          label: 'Tempat Penyusunan *',
          helpText: 'Contoh: Gedung NU, Aula Masjid',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.tempatPenyusunanFocus,
          icon: Icons.location_on,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan tempat penyusunan',
          validator: UiFieldValidators.required('Tempat penyusunan'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaWilayahController,
          label: 'Nama Wilayah *',
          helpText: 'Contoh: Nganjuk, Ngepeh, Mojosari, dll',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.namaWilayahFocus,
          icon: Icons.location_city,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan nama wilayah',
          validator: UiFieldValidators.required('Nama wilayah'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tanggalHijriahController,
          label: 'Tanggal Hijriah *',
          helpText: 'Contoh: 15 Rajab 1445',
          hint: 'Masukkan tanggal hijriah',
          icon: Icons.calendar_today,
          validator: UiFieldValidators.required('Tanggal hijriah'),
          focusNode: viewModel.formDataManager.tanggalHijriahFocus,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tanggalMasehiController,
          label: 'Tanggal Masehi *',
          helpText: 'Contoh: 15 Januari 2024',
          hint: 'Masukkan tanggal masehi',
          icon: Icons.calendar_today,
          validator: UiFieldValidators.required('Tanggal masehi'),
          focusNode: viewModel.formDataManager.tanggalMasehiFocus,
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
