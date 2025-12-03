import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/susunan_pengurus/managers/ipnu/susunan_pengurus_ipnu_form_data_manager.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/susunan_pengurus/susunan_pengurus_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:get/get.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/susunan_pengurus/widgets/lembaga_ipnu_info_dialog.dart';

class StepLembagaInternalSection extends StatelessWidget {
  final SusunanPengurusIpnuViewmodel viewModel;

  const StepLembagaInternalSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Lembaga Internal',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                onPressed: () => LembagaIpnuInfoDialog.show(context),
                icon: const Icon(Icons.info_outline, size: 20),
                style: IconButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spaceM,
                    vertical: AppDimensions.spaceS,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceS),
          Text(
            'Kelola lembaga-lembaga internal yang ada di kepengurusan. Lembaga Pers dan Penerbitan wajib ada.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: AppDimensions.spaceM),

          Obx(() {
            // Trigger rebuild
            final version = viewModel.lembagaVersion.value;

            final lembagaList = viewModel.formDataManager.lembagaInternal;

            if (lembagaList.isEmpty) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.spaceL),
                  child: Center(
                    child: Text(
                      'Belum ada lembaga internal. Klik "Tambah Lembaga" untuk menambahkan.',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }

            return Column(
              key: ValueKey('lembaga_list_$version'),
              children: [
                for (int index = 0; index < lembagaList.length; index++) ...[
                  _buildLembagaCard(context, lembagaList[index], index),
                  if (index < lembagaList.length - 1)
                    const SizedBox(height: AppDimensions.spaceM),
                ],
              ],
            );
          }),
          const SizedBox(height: AppDimensions.spaceM),
          OutlinedButton.icon(
            onPressed: viewModel.addLembaga,
            icon: const Icon(Icons.add),
            label: const Text('Tambah Lembaga'),
          ),
        ],
      ),
    );
  }

  Widget _buildLembagaCard(BuildContext context, LembagaData lembaga, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      key: ValueKey('lembaga_card_$index'),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spaceM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lembaga ${index + 1}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => viewModel.removeLembaga(index),
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.error,
                  tooltip: 'Hapus Lembaga',
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: AppDimensions.spaceS),

            CustomTextField(
              controller: lembaga.namaController,
              label: 'Nama Lembaga',
              helpText: 'Nama lengkap lembaga, Contoh Pers dan Penerbitan',
              hint: 'Masukkan nama lembaga',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama lembaga tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: AppDimensions.spaceM),

            CustomTextField(
              controller: lembaga.direkturController,
              label: 'Direktur Lembaga',
              helpText: 'Nama direktur lembaga, Contoh: Ahmad Suharto',
              hint: 'Masukkan nama direktur',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Direktur tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: AppDimensions.spaceM),

            CustomTextField(
              controller: lembaga.alamatDirekturController,
              label: 'Alamat Direktur',
              helpText: 'Alamat lengkap direktur lembaga, Contoh: Dusun Sono atau Desa Ngepeh',
              hint: 'Masukkan alamat direktur',
              maxLines: 2,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Alamat direktur lembaga tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: AppDimensions.spaceM),
            CustomTextField(
              controller: lembaga.sekretarisController,
              label: 'Sekretaris Lembaga',
              helpText: 'Nama sekretaris lembaga, Contoh: Budi Santoso',
              hint: 'Masukkan nama sekretaris',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Sekretaris tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: AppDimensions.spaceM),

            CustomTextField(
              controller: lembaga.alamatSekretarisController,
              label: 'Alamat Sekretaris',
              helpText: 'Alamat lengkap sekretaris lembaga, Contoh: Dusun Sono atau Desa Ngepeh',
              hint: 'Masukkan alamat sekretaris',
              maxLines: 2,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Alamat sekretaris lembaga tidak boleh kosong';
                }
                return null;
              },
            ),

            const SizedBox(height: AppDimensions.spaceM),
            const Divider(),

            // Anggota Section
            Text(
              'Anggota Lembaga',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: AppDimensions.spaceM),

            if (lembaga.anggota.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.spaceM,
                ),
                child: Text(
                  'Belum ada anggota. Klik "Tambah Anggota" untuk menambahkan.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
              )
            else
              Column(
                children: [
                  for (
                    int anggotaIndex = 0;
                    anggotaIndex < lembaga.anggota.length;
                    anggotaIndex++
                  ) ...[
                    _buildAnggotaItem(
                      context,
                      lembaga.anggota[anggotaIndex],
                      anggotaIndex,
                      index,
                    ),
                    if (anggotaIndex < lembaga.anggota.length - 1) ...[
                      const SizedBox(height: AppDimensions.spaceS),
                      const Divider(),
                      const SizedBox(height: AppDimensions.spaceS),
                    ]
                      
                  ],
                ],
              ),
            const SizedBox(height: AppDimensions.spaceM),
            OutlinedButton.icon(
              onPressed: () => viewModel.addAnggotaLembaga(index),
              icon: const Icon(Icons.add),
              label: const Text('Tambah Anggota'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnggotaItem(
    BuildContext context,
    AnggotaData anggota,
    int anggotaIndex,
    int lembagaIndex,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.spaceXS,
                horizontal: AppDimensions.spaceS,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Anggota ${anggotaIndex + 1}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            IconButton(
              onPressed:
                  () => viewModel.removeAnggotaLembaga(
                    lembagaIndex,
                    anggotaIndex,
                  ),
              icon: const Icon(Icons.close, size: 20),
              color: Theme.of(context).colorScheme.error,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              tooltip: 'Hapus Anggota',
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceM),
    
        CustomTextField(
          controller: anggota.namaController,
          label: 'Nama Anggota',
          hint: 'Masukkan nama anggota',
          helpText: 'Nama lengkap anggota lembaga, Contoh: Joko Widodo',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Nama anggota tidak boleh kosong';
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimensions.spaceM),
    
        CustomTextField(
          controller: anggota.alamatController,
          label: 'Alamat Anggota',
          helpText: 'Alamat lengkap anggota lembaga, Contoh: Dusun Sono atau Desa Ngepeh',
          hint: 'Masukkan alamat anggota',
          maxLines: 2,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Alamat anggota tidak boleh kosong';
            }
            return null;
          },
        ),
      ],
    );
  }
}
