import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_pemilihan_ketua/berita_acara_pemilihan_ketua_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/widgets/section_header.dart';

class StepPemilihanKetuaSection extends StatelessWidget {
  final BeritaAcaraPemilihanKetuaIpnuViewmodel viewModel;

  const StepPemilihanKetuaSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Waktu & Tempat Pemilihan Ketua'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan informasi waktu dan tempat pelaksanaan pemilihan ketua.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        CustomTextField(
          controller: viewModel.formDataManager.tanggalController,
          label: 'Tanggal *',
          helpText: 'Tanggal rapat pemilihan ketua, Contoh: 15',
          hint: 'Tanggal',
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Tanggal wajib diisi';
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.bulanController,
          label: 'Bulan *',
          helpText: 'Bulan rapat pemilihan ketua, Contoh: Agustus',
          hint: 'Bulan',
          textCapitalization: TextCapitalization.words,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Bulan wajib diisi';
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tahunController,
          label: 'Tahun *',
          helpText: 'Tahun rapat pemilihan ketua, Contoh: 2024',
          hint: 'Tahun',
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Tahun wajib diisi';
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.waktuPemilihanKetuaController,
          label: 'Waktu Pemilihan Ketua *',
          helpText: 'Waktu rapat pemilihan ketua, Contoh: 10.00',
          hint: 'Masukkan waktu',
          keyboardType: TextInputType.datetime,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Waktu pemilihan ketua wajib diisi';
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tempatPemilihanKetuaController,
          label: 'Tempat Pemilihan Ketua *',
          helpText: 'Tempat rapat pemilihan ketua, Contoh: Aula Madrasah, dll.',
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan tempat',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Tempat pemilihan ketua wajib diisi';
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
