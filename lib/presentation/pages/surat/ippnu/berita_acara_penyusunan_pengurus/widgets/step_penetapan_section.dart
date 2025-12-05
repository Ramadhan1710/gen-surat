import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_penyusunan_pengurus/berita_acara_penyusunan_pengurus_ippnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

class StepPenetapanSection extends StatelessWidget {
  final BeritaAcaraPenyusunanPengurusIppnuViewmodel viewModel;

  const StepPenetapanSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Penetapan Berita Acara'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan informasi penetapan berita acara penyusunan pengurus.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        CustomTextField(
          controller: viewModel.formDataManager.tanggalPenyusunanController,
          label: 'Tanggal Penyusunan *',
          helpText: 'Contoh: 15 Februari 2024',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.tanggalPenyusunanFocus,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan tanggal penyusunan',
          icon: Icons.calendar_today,
          validator: UiFieldValidators.required('Tanggal penyusunan'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tempatPenyusunanController,
          label: 'Tempat Penyusunan *',
          helpText: 'Contoh: Aula Madrasah, Gedung NU',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.tempatPenyusunanFocus,
          textInputAction: TextInputAction.next,
          icon: Icons.location_on,
          hint: 'Masukkan tempat penyusunan',
          validator: UiFieldValidators.required('Tempat penyusunan'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaWilayahController,
          label: 'Nama Wilayah *',
          helpText: 'Contoh: Ngepeh, Macanan, Mojosari',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.namaWilayahFocus,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan nama wilayah',
          icon: Icons.location_on,
          validator: UiFieldValidators.required('Nama wilayah'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.hariPenyusunanController,
          label: 'Hari Penyusunan *',
          helpText: 'Contoh: Jumat',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.hariPenyusunanFocus,
          textInputAction: TextInputAction.next,
          icon: Icons.calendar_today,
          hint: 'Masukkan hari penyusunan',
          validator: UiFieldValidators.required('Hari penyusunan'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tanggalHijriahController,
          label: 'Tanggal Hijriah *',
          helpText: 'Contoh: 5 Rabiul Awal 1445',
          hint: 'Masukkan tanggal hijriah',
          validator: UiFieldValidators.required('Tanggal hijriah'),
          icon: Icons.calendar_today,
          focusNode: viewModel.formDataManager.tanggalHijriahFocus,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tanggalMasehiController,
          label: 'Tanggal Masehi *',
          helpText: 'Contoh: 15 Februari 2024',
          hint: 'Masukkan tanggal masehi',
          validator: UiFieldValidators.required('Tanggal masehi'),
          focusNode: viewModel.formDataManager.tanggalMasehiFocus,
          icon: Icons.calendar_today,
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
