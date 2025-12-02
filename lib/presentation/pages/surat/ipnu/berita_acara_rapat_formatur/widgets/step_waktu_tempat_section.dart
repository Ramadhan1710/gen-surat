import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_rapat_formatur/berita_acara_rapat_formatur_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/widgets/section_header.dart';

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
          label: 'Tanggal Rapat',
          hint: 'Masukkan tanggal rapat',
          helpText: 'Tanggal pelaksanaan rapat formatur, Contoh: 15',
          icon: Icons.calendar_today,
          textInputAction: TextInputAction.next,
          validator: viewModel.formValidator.validateTanggal,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.bulanController,
          label: 'Bulan Rapat',
          hint: 'Masukkan bulan rapat',
          helpText: 'Bulan pelaksanaan rapat formatur, Contoh: Januari',
          icon: Icons.event,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          validator: viewModel.formValidator.validateBulan,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tahunController,
          label: 'Tahun Rapat',
          hint: 'Masukkan tahun rapat',
          helpText: 'Tahun pelaksanaan rapat formatur, Contoh: 2024',
          icon: Icons.date_range,
          textInputAction: TextInputAction.next,
          validator: viewModel.formValidator.validateTahun,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tempatRapatController,
          label: 'Tempat Rapat',
          hint: 'Masukkan tempat rapat',
          helpText:
              'Lokasi pelaksanaan rapat formatur, Contoh: Aula Desa Ngepeh',
          icon: Icons.location_on,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          validator: viewModel.formValidator.validateTempatRapat,
        ),
        const SizedBox(height: AppDimensions.spaceL),
        const SectionHeader(title: 'Informasi RAPTA'),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.periodeRaptaController,
          label: 'Periode RAPTA',
          hint: 'Masukkan periode RAPTA',
          helpText: 'Periode rapat pemilihan pengurus baru (RAPTA), Contoh: IX',
          icon: Icons.numbers,
          textCapitalization: TextCapitalization.characters,
          textInputAction: TextInputAction.next,
          validator: viewModel.formValidator.validatePeriodeRapta,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaWilayahController,
          label: 'Nama Wilayah Penetapan',
          hint: 'Masukkan nama wilayah',
          helpText:
              'Nama wilayah tempat penetapan berita acara, Contoh: Ngepeh, Macanan, Mojosari',
          icon: Icons.map,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          validator: viewModel.formValidator.validateNamaWilayah,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tanggalRapatController,
          label: 'Tanggal Penetapan',
          hint: 'Masukkan tanggal penetapan',
          helpText:
              'Tanggal penetapan berita acara rapat formatur, Contoh: 20 Januari 2023',
          icon: Icons.event_note,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.done,
          validator: viewModel.formValidator.validateTanggalRapat,
        ),
      ],
    );
  }
}
