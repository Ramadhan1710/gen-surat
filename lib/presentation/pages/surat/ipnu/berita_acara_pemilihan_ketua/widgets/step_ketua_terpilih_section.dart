import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_pemilihan_ketua/berita_acara_pemilihan_ketua_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

class StepKetuaTerpilihSection extends StatelessWidget {
  final BeritaAcaraPemilihanKetuaIpnuViewmodel viewModel;

  const StepKetuaTerpilihSection({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Data Ketua Terpilih'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan informasi ketua yang terpilih dalam pemilihan.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        CustomTextField(
          controller: viewModel.formDataManager.namaKetuaTerpilihController,
          label: 'Nama Ketua Terpilih *',
          helpText: 'Nama lengkap ketua yang terpilih',
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan nama ketua terpilih',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Nama ketua terpilih wajib diisi';
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.alamatKetuaTerpilihController,
          label: 'Alamat Ketua Terpilih *',
          helpText: 'Alamat ketua terpilih, Contoh: Dusun Lorubung, Desa Ngepeh',
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan alamat',
          maxLines: 2,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Alamat ketua terpilih wajib diisi';
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller:
              viewModel.formDataManager.totalSuaraKetuaTerpilihController,
          label: 'Total Suara yang Diperoleh *',
          helpText: 'Jumlah total suara sah yang diperoleh ketua terpilih',
          hint: 'Masukkan total suara',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Total suara wajib diisi';
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
