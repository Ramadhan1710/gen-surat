import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/keputusan/surat_keputusan_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/widgets/section_header.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/widgets/date_picker_field.dart';

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
          textCapitalization: TextCapitalization.words,
          validator: _requiredValidator('Nomor surat'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tanggalHijriahController,
          label: 'Tanggal Hijriah *',
          helpText: 'Tanggal hijriah penetapan SK, Contoh: 15 Rajab 1446',
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan tanggal hijriah',
          validator: _requiredValidator('Tanggal hijriah'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        DatePickerField(
          controller: viewModel.formDataManager.tanggalMasehiController,
          label: 'Tanggal Masehi *',
          helpText: 'Tanggal masehi penetapan SK, Contoh: 15 Januari 2025',
          hint: 'Masukkan tanggal masehi',
          validator: _requiredValidator('Tanggal masehi'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.waktuPenetapanController,
          label: 'Waktu Penetapan *',
          helpText: 'Waktu penetapan surat keputusan, Contoh: 14.30',
          hint: 'Masukkan waktu penetapan',
          keyboardType: TextInputType.datetime,
          validator: _requiredValidator('Waktu penetapan'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaWilayahController,
          label: 'Nama Wilayah *',
          helpText: 'Nama wilayah/kota, Contoh: Nganjuk',
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan nama wilayah',
          validator: _requiredValidator('Nama wilayah'),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        const SectionHeader(title: 'Penandatangan'),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaKetuaController,
          label: 'Nama Ketua *',
          helpText: 'Nama lengkap ketua sidang RAPTA yang menandatangani',
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan nama ketua',
          validator: _requiredValidator('Nama ketua'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaSekretarisController,
          label: 'Nama Sekretaris *',
          helpText: 'Nama lengkap sekretaris sidang RAPTA yang menandatangani',
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan nama sekretaris',
          validator: _requiredValidator('Nama sekretaris'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaAnggotaController,
          label: 'Nama Anggota *',
          helpText: 'Nama lengkap anggota sidang RAPTA yang menandatangani',
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan nama anggota',
          validator: _requiredValidator('Nama anggota'),
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
