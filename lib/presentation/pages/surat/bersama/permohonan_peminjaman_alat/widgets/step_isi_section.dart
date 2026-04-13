import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/permohonan_peminjaman_alat/surat_permohonan_peminjaman_alat_bersama_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

class StepIsiSection extends StatelessWidget {
  final SuratPermohonanPeminjamanAlatBersamaViewmodel viewModel;

  const StepIsiSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Bagian Isi Surat'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Isikan bagian isi surat dengan informasi yang sesuai.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        CustomTextField(
          controller: viewModel.formDataManager.namaKegiatanController,
          focusNode: viewModel.formDataManager.namaKegiatanFocus,
          label: 'Nama Kegiatan *',
          helpText: 'Contoh: Latihan Kader Muda (LAKMUD) 2025',
          hint: 'Masukkan nama kegiatan',
          icon: Icons.event,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Nama kegiatan'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.hariTanggalController,
          focusNode: viewModel.formDataManager.hariTanggalFocus,
          label: 'Hari dan Tanggal *',
          helpText: 'Contoh:  Selasa-Kamis/24-26 Juni 2025',
          hint: 'Masukkan hari dan tanggal',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.attach_file,
          validator: UiFieldValidators.required('Hari dan tanggal'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.waktuController,
          focusNode: viewModel.formDataManager.waktuFocus,
          label: 'Waktu *',
          helpText: 'Contoh: 09.00 - 16.00 WIB',
          hint: 'Masukkan waktu',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.access_time,
          validator: UiFieldValidators.required('Waktu'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tempatController,
          focusNode: viewModel.formDataManager.tempatFocus,
          label: 'Tempat *',
          helpText: 'Contoh: Gedung Serbaguna, Kab. Nganjuk',
          hint: 'Masukkan tempat',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.done,
          icon: Icons.place,
          validator: UiFieldValidators.required('Tujuan surat'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.alatController,
          focusNode: viewModel.formDataManager.alatFocus,
          label: 'Nama Alat *',
          helpText: 'Contoh: Proyektor dan Laptop',
          hint: 'Masukkan nama alat',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.done,
          icon: Icons.build,
          validator: UiFieldValidators.required('Nama alat'),
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
