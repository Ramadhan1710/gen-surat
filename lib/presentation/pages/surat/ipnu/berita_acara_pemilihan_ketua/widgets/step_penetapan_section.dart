import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_pemilihan_ketua/berita_acara_pemilihan_ketua_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

class StepPenetapanSection extends StatelessWidget {
  final BeritaAcaraPemilihanKetuaViewmodel viewModel;

  const StepPenetapanSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Informasi Penetapan'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan informasi penetapan hasil pemilihan ketua.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        CustomTextField(
          controller: viewModel.formDataManager.namaWilayahController,
          label: 'Wilayah *',
          helpText: 'Wilayah penetapan, \nContoh: Ngepeh, Mojosari, dll',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.namaWilayahFocus,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan wilayah',
          validator: UiFieldValidators.required('Wilayah'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        const SectionHeader(title: 'Tanggal Penetapan'),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tanggalHijriahController,
          label: 'Tanggal Hijriah *',
          helpText: 'Contoh: 15 Ramadhan 1446',
          focusNode: viewModel.formDataManager.tanggalHijriahFocus,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan tanggal hijriah',
          validator: UiFieldValidators.required('Tanggal hijriah'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tanggalMasehiController,
          label: 'Tanggal Masehi *',
          helpText: 'Contoh: 15 Maret 2025',
          focusNode: viewModel.formDataManager.tanggalMasehiFocus,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan tanggal masehi',
          validator: UiFieldValidators.required('Tanggal masehi'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.waktuPenetapanController,
          label: 'Waktu Penetapan *',
          helpText: 'Contoh: 14.00',
          focusNode: viewModel.formDataManager.waktuPenetapanFocus,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          hint: 'Masukkan waktu',
          validator: UiFieldValidators.required('Waktu penetapan'),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        const SectionHeader(
          title: 'Pimpinan Sidang Pleno Pemilihan Ketua dan Formatur',
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaKetuaController,
          label: 'Nama Ketua Sidang *',
          helpText: 'Nama ketua sidang pleno pemilihan ketua dan formatur',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.namaKetuaFocus,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan nama ketua sidang',
          validator: UiFieldValidators.required('Nama ketua sidang'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaSekretarisController,
          label: 'Sekretaris Sidang *',
          helpText: 'Nama sekretaris sidang pleno pemilihan ketua dan formatur',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.namaSekretarisFocus,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan nama sekretaris sidang',
          validator: UiFieldValidators.required('Sekretaris sidang'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaAnggotaController,
          label: 'Anggota sidang *',
          helpText: 'Nama anggota sidang pleno pemilihan ketua dan formatur',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.namaAnggotaFocus,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan nama anggota sidang',
          validator: UiFieldValidators.required('Anggota sidang'),
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
