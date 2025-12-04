import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_pemilihan_ketua/berita_acara_pemilihan_ketua_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_pemilihan_ketua/managers/berita_acara_pemilihan_ketua_form_data_manager.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

class StepPencalonanKetuaSection extends StatelessWidget {
  final BeritaAcaraPemilihanKetuaViewmodel viewModel;

  const StepPencalonanKetuaSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Data Tahap Pencalonan Ketua'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan data calon-calon ketua yang mengikuti pemilihan.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        Obx(() {
          // Use version to trigger rebuild
          final _ = viewModel.pencalonanKetuaVersion.value;
          return Column(
            children: [
              ...List.generate(
                viewModel.formDataManager.pencalonanKetua.length,
                (index) => _buildPencalonanKetuaCard(
                  context,
                  index,
                  viewModel.formDataManager.pencalonanKetua[index],
                ),
              ),
              // const SizedBox(height: AppDimensions.spaceM),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: viewModel.addPencalonanKetua,
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah Calon Ketua'),
                ),
              ),
            ],
          );
        }),
        const SizedBox(height: AppDimensions.spaceL),
        const SectionHeader(title: 'Total Perolehan Suara'),
        const SizedBox(height: AppDimensions.spaceM),
        Obx(() {
          final _ = viewModel.pencalonanKetuaVersion.value;
          final total = viewModel.formDataManager.computedTotalSuaraSahPencalonanKetua;
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
          controller:
              viewModel
                  .formDataManager
                  .totalSuaraTidakSahPencalonanKetuaController,
          label: 'Total Suara Tidak Sah *',
          helpText: 'Total suara tidak sah dalam pemilihan',
          hint: 'Masukkan total suara tidak sah',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Total suara tidak sah wajib diisi';
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }

  Widget _buildPencalonanKetuaCard(
    BuildContext context,
    int index,
    PencalonanKetuaData data,
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
                  onPressed: () => viewModel.removePencalonanKetua(index),
                  tooltip: 'Hapus calon ketua',
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
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: AppDimensions.spaceM),
            CustomTextField(
              controller: data.alamatController,
              label: 'Alamat *',
              helpText: 'Alamat calon ketua, Contoh: Dusun Krajan Desa Ngepeh',
              textCapitalization: TextCapitalization.words,
              hint: 'Masukkan alamat',
              maxLines: 2,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Alamat wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: AppDimensions.spaceM),
            CustomTextField(
              controller: data.jmlSuaraSahController,
              label: 'Jumlah Suara Sah *',
              helpText: 'Jumlah suara sah yang diperoleh',
              hint: 'Masukkan jumlah suara sah',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Jumlah suara sah wajib diisi';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
