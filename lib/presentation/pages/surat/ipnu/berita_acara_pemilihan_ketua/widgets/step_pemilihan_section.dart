import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:get/get.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_pemilihan_ketua/berita_acara_pemilihan_ketua_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_pemilihan_ketua/managers/berita_acara_pemilihan_ketua_form_data_manager.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

class StepPemilihanSection extends StatelessWidget {
  final BeritaAcaraPemilihanKetuaViewmodel viewModel;

  const StepPemilihanSection({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Tahap Pemilihan Ketua'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan data hasil pemilihan ketua.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        Obx(() {
          // Use version to trigger rebuild
          final _ = viewModel.pemilihanKetuaVersion.value;
          return Column(
            children: [
              ...List.generate(
                viewModel.formDataManager.pemilihanKetua.length,
                (index) => _buildPemilihanKetuaCard(
                  context,
                  index,
                  viewModel.formDataManager.pemilihanKetua[index],
                ),
              ),
              const SizedBox(height: AppDimensions.spaceM),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: viewModel.addPemilihanKetua,
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah Data Pemilihan'),
                ),
              ),
            ],
          );
        }),
        const SizedBox(height: AppDimensions.spaceL),
        const SectionHeader(title: 'Total Perolehan Suara Tahap Pemilihan'),
        const SizedBox(height: AppDimensions.spaceM),
        Obx(() {
          final _ = viewModel.pemilihanKetuaVersion.value;
          final total = viewModel.formDataManager.computedTotalSuaraSahPemilihanKetua;
          return Card(
            margin: const EdgeInsets.only(bottom: AppDimensions.spaceM),
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.spaceM),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Total Suara Sah',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  Text(
                    total.toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel
              .formDataManager.totalSuaraTidakSahPemilihanKetuaController,
          label: 'Total Suara Tidak Sah *',
          helpText: 'Total suara tidak sah dalam pemilihan',
          hint: 'Masukkan total suara tidak sah',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: UiFieldValidators.required('Total suara tidak sah'),
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }

  Widget _buildPemilihanKetuaCard(
    BuildContext context,
    int index,
    PemilihanKetuaData data,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceM),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spaceM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Calon Ketua ${index + 1}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => viewModel.removePemilihanKetua(index),
                  tooltip: 'Hapus data pemilihan',
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spaceM),
            CustomTextField(
              controller: data.namaController,
              label: 'Nama Calon Ketua *',
              helpText: 'Nama lengkap calon ketua',
              textCapitalization: TextCapitalization.words,
              hint: 'Masukkan nama',
              validator: UiFieldValidators.required('Nama calon ketua'),
            ),
            const SizedBox(height: AppDimensions.spaceM),
            CustomTextField(
              controller: data.alamatController,
              label: 'Alamat *',
              helpText: 'Alamat lengkap calon ketua,\nContoh: Desa Ngepeh/Dusun Krajan',
              textCapitalization: TextCapitalization.words,
              hint: 'Masukkan alamat',
              maxLines: 2,
              validator: UiFieldValidators.required('Alamat calon ketua'),
            ),
            const SizedBox(height: AppDimensions.spaceM),
            CustomTextField(
              controller: data.jmlSuaraSahController,
              label: 'Jumlah Suara Sah *',
              helpText: 'Jumlah suara sah yang diperoleh',
              hint: 'Masukkan jumlah suara sah',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: UiFieldValidators.required('Jumlah suara sah'),
            ),
          ],
        ),
      ),
    );
  }
}
