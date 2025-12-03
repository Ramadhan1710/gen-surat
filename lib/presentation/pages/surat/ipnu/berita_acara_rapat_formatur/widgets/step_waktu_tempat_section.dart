import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_rapat_formatur/berita_acara_rapat_formatur_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

class StepWaktuTempatSection extends StatelessWidget {
  final BeritaAcaraRapatFormaturViewmodel viewModel;

  const StepWaktuTempatSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Waktu dan Tempat Rapat'),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tanggalController,
          focusNode: viewModel.formDataManager.tanggalFocus,
          label: 'Tanggal Rapat',
          hint: 'Masukkan tanggal rapat',
          helpText: 'Tanggal pelaksanaan rapat formatur, Contoh: 15',
          icon: Icons.calendar_today,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Tanggal Rapat'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.bulanController,
          focusNode: viewModel.formDataManager.bulanFocus,
          label: 'Bulan Rapat',
          hint: 'Masukkan bulan rapat',
          helpText: 'Bulan pelaksanaan rapat formatur, Contoh: Januari',
          icon: Icons.event,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Bulan Rapat'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tahunController,
          focusNode: viewModel.formDataManager.tahunFocus,
          label: 'Tahun Rapat',
          hint: 'Masukkan tahun rapat',
          helpText: 'Tahun pelaksanaan rapat formatur, Contoh: 2024',
          icon: Icons.date_range,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Tahun Rapat'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tempatRapatController,
          focusNode: viewModel.formDataManager.tempatRapatFocus,
          label: 'Tempat Rapat',
          hint: 'Masukkan tempat rapat',
          helpText:
              'Lokasi pelaksanaan rapat formatur, Contoh: Aula Desa Ngepeh',
          icon: Icons.location_on,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Tempat Rapat'),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        const SectionHeader(title: 'Informasi RAPTA'),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.periodeRaptaController,
          focusNode: viewModel.formDataManager.periodeRaptaFocus,
          label: 'Periode RAPTA',
          hint: 'Masukkan periode RAPTA',
          helpText: 'Periode rapat pemilihan pengurus baru (RAPTA), Contoh: IX',
          icon: Icons.numbers,
          textCapitalization: TextCapitalization.characters,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Periode RAPTA'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaWilayahController,
          focusNode: viewModel.formDataManager.namaWilayahFocus,
          label: 'Nama Wilayah Penetapan',
          hint: 'Masukkan nama wilayah',
          helpText:
              'Nama wilayah tempat penetapan berita acara, Contoh: Ngepeh, Macanan, Mojosari',
          icon: Icons.map,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Nama Wilayah Penetapan'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tanggalRapatController,
          focusNode: viewModel.formDataManager.tanggalRapatFocus,
          label: 'Tanggal Penetapan',
          hint: 'Masukkan tanggal penetapan',
          helpText:
              'Tanggal penetapan berita acara rapat formatur, Contoh: 20 Januari 2023',
          icon: Icons.event_note,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Tanggal Penetapan'),
        ),
      ],
    );
  }
}
