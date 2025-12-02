import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_pemilihan_ketua/berita_acara_pemilihan_ketua_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/widgets/section_header.dart';

class StepPenetapanSection extends StatelessWidget {
  final BeritaAcaraPemilihanKetuaIpnuViewmodel viewModel;

  const StepPenetapanSection({
    super.key,
    required this.viewModel,
  });

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
          helpText: 'Wilayah penetapan',
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan wilayah',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Wilayah wajib diisi';
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimensions.spaceM),
        const SectionHeader(title: 'Tanggal Penetapan'),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tanggalHijriahController,
          label: 'Tanggal Hijriah *',
          helpText: 'Contoh: 15 Ramadhan 1446',
          hint: 'Masukkan tanggal hijriah',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Tanggal hijriah wajib diisi';
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.tanggalMasehiController,
          label: 'Tanggal Masehi *',
          helpText: 'Contoh: 15 Maret 2025',
          hint: 'Masukkan tanggal masehi',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Tanggal masehi wajib diisi';
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.waktuPenetapanController,
          label: 'Waktu Penetapan *',
          helpText: 'Contoh: 14.00',
          keyboardType: TextInputType.datetime,
          hint: 'Masukkan waktu',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Waktu penetapan wajib diisi';
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimensions.spaceL),
        const SectionHeader(title: 'Pimpinan Sidang Pleno Pemilihan Ketua dan Formatur'),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaKetuaController,
          label: 'Nama Ketua *',
          helpText: 'Nama ketua sidang pleno pemilihan ketua dan formatur',
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan nama ketua',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Nama ketua sidang pleno wajib diisi';
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaSekretarisController,
          label: 'Sekretaris *',
          helpText: 'Nama sekretaris sidang pleno pemilihan ketua dan formatur',
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan nama sekretaris',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Nama sekretaris sidang pleno wajib diisi';
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaAnggotaController,
          label: 'Anggota *',
          helpText: 'Nama anggota sidang pleno pemilihan ketua dan formatur',
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan nama anggota',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Nama anggota sidang pleno wajib diisi';
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
