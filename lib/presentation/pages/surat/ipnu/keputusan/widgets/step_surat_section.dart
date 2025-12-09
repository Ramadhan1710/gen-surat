import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/keputusan/surat_keputusan_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:gen_surat/presentation/widgets/date_picker_field.dart';

/// Widget untuk step 2: Informasi Surat
/// Berisi nomor surat, tanggal, waktu penetapan, wilayah, dan penandatangan
class StepSuratSection extends StatelessWidget {
  final SuratKeputusanIpnuViewmodel viewModel;

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
          'Masukkan informasi terkait surat keputusan dan data penetapan.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        CustomTextField(
          controller: viewModel.formDataManager.nomorSuratController,
          label: 'Nomor Surat *',
          helpText: 'Nomor surat keputusan pada dokumen RAPTA tentang PENGESAHAN HASIL SIDANG PEMILIHAN KETUA DAN FORMATUR, Contoh: 09/Rapta/XX/IPNU/VIII/2023',
          hint: 'Masukkan nomor surat',
          focusNode: viewModel.formDataManager.nomorSuratFocus,
          textInputAction: TextInputAction.next,
          icon: Icons.description,
          textCapitalization: TextCapitalization.words,
          validator: UiFieldValidators.required('Nomor surat'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tanggalHijriahController,
          label: 'Tanggal Hijriah *',
          helpText: 'Tanggal hijriah penetapan SK, Contoh: 15 Rajab 1446',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.tanggalHijriahFocus,
          textInputAction: TextInputAction.next,
          icon: Icons.calendar_month,
          hint: 'Masukkan tanggal hijriah',
          validator: UiFieldValidators.required('Tanggal hijriah'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        DatePickerField(
          controller: viewModel.formDataManager.tanggalMasehiController,
          label: 'Tanggal Masehi *',
          helpText: 'Tanggal masehi penetapan SK, Contoh: 15 Januari 2025',
          hint: 'Masukkan tanggal masehi',
          focusNode: viewModel.formDataManager.tanggalMasehiFocus,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Tanggal masehi'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.waktuPenetapanController,
          label: 'Waktu Penetapan *',
          helpText: 'Waktu penetapan surat keputusan, Contoh: 14.30',
          hint: 'Masukkan waktu penetapan',
          keyboardType: TextInputType.text,
          icon: Icons.access_time,
          focusNode: viewModel.formDataManager.waktuPenetapanFocus,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Waktu penetapan'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaWilayahController,
          label: 'Nama Wilayah *',
          helpText: 'Nama wilayah penetapan, Contoh: Nganjuk, Ngepeh, dll.',
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan nama wilayah',
          icon: Icons.place,
          focusNode: viewModel.formDataManager.namaWilayahFocus,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Nama wilayah'),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        const SectionHeader(title: 'Penandatangan'),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaKetuaController,
          label: 'Nama Ketua Sidang *',
          helpText: 'Nama lengkap ketua sidang RAPTA yang menandatangani',
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan nama ketua sidang',
          icon: Icons.person,
          focusNode: viewModel.formDataManager.namaKetuaFocus,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Nama ketua Sidang'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaSekretarisController,
          label: 'Nama Sekretaris Sidang *',
          helpText: 'Nama lengkap sekretaris sidang RAPTA yang menandatangani',
          textCapitalization: TextCapitalization.words,
          icon: Icons.person,
          hint: 'Masukkan nama sekretaris sidang',
          focusNode: viewModel.formDataManager.namaSekretarisFocus,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Nama sekretaris sidang'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaAnggotaController,
          label: 'Nama Anggota Sidang *',
          helpText: 'Nama lengkap anggota sidang RAPTA yang menandatangani',
          icon: Icons.person,
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan nama anggota sidang',
          focusNode: viewModel.formDataManager.namaAnggotaFocus,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Nama anggota sidang'),
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
