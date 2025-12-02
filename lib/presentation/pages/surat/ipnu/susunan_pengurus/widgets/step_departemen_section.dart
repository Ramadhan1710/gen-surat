import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/susunan_pengurus/susunan_pengurus_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:get/get.dart';

class StepDepartemenSection extends StatelessWidget {
  final SusunanPengurusIpnuViewmodel viewModel;

  const StepDepartemenSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Departemen', style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceM),

          Obx(() {
            // Trigger rebuild
            final version = viewModel.departemenVersion.value;

            final departemenList = viewModel.formDataManager.departemen;

            if (departemenList.isEmpty) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.spaceL),
                  child: Center(
                    child: Text(
                      'Belum ada departemen. Klik "Tambah Departemen" untuk menambahkan.',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }

            return Column(
              key: ValueKey('dept_list_$version'),
              children: [
                for (int index = 0; index < departemenList.length; index++) ...[
                  _buildDepartemenCard(context, departemenList[index], index),
                  if (index < departemenList.length - 1)
                    const SizedBox(height: AppDimensions.spaceM),
                ],
              ],
            );
          }),
          const SizedBox(height: AppDimensions.spaceM),
          OutlinedButton.icon(
            onPressed: viewModel.addDepartemen,
            icon: const Icon(Icons.add),
            label: const Text('Tambah Departemen'),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartemenCard(BuildContext context, dynamic dept, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      key: ValueKey('dept_card_$index'),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spaceM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Departemen ${index + 1}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => viewModel.removeDepartemen(index),
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.error,
                  tooltip: 'Hapus Departemen',
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: AppDimensions.spaceS),

            CustomTextField(
              controller: dept.namaController,
              label: 'Nama Departemen',
              hint: 'Contoh: Kaderisasi',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama departemen tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: AppDimensions.spaceS),

            CustomTextField(
              controller: dept.koordinatorController,
              label: 'Koordinator',
              hint: 'Nama koordinator departemen',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Koordinator tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: AppDimensions.spaceS),

            CustomTextField(
              controller: dept.alamatKoordinatorController,
              label: 'Alamat Koordinator',
              hint: 'Alamat lengkap koordinator',
              maxLines: 2,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Alamat koordinator tidak boleh kosong';
                }
                return null;
              },
            ),

            const SizedBox(height: AppDimensions.spaceM),
            const Divider(),

            const SizedBox(height: AppDimensions.spaceS),

            if (dept.anggota.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.spaceS,
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
                key: ValueKey('anggota_list_dept_$index'),
                children: [
                  for (
                    int anggotaIndex = 0;
                    anggotaIndex < dept.anggota.length;
                    anggotaIndex++
                  ) ...[
                    _buildAnggotaItem(
                      context,
                      dept.anggota[anggotaIndex],
                      anggotaIndex,
                      index,
                    ),
                    if (anggotaIndex < dept.anggota.length - 1)
                      const SizedBox(height: AppDimensions.spaceS),
                  ],
                ],
              ),
            const SizedBox(height: AppDimensions.spaceM),
            OutlinedButton.icon(
              onPressed: () => viewModel.addAnggotaDepartemen(index),
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
    dynamic anggota,
    int anggotaIndex,
    int departemenIndex,
  ) {
    return Container(
      key: ValueKey('anggota_${departemenIndex}_$anggotaIndex'),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Anggota ${anggotaIndex + 1}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              IconButton(
                onPressed:
                    () => viewModel.removeAnggotaDepartemen(
                      departemenIndex,
                      anggotaIndex,
                    ),
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.delete, size: 20),
                color: Theme.of(context).colorScheme.error,
                tooltip: 'Hapus Anggota',
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceXS),

          CustomTextField(
            controller: anggota.namaController,
            label: 'Nama Anggota',
            hint: 'Masukkan nama anggota',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Nama anggota tidak boleh kosong';
              }
              return null;
            },
          ),
          const SizedBox(height: AppDimensions.spaceXS),

          CustomTextField(
            controller: anggota.alamatController,
            label: 'Alamat Anggota',
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
      ),
    );
  }
}
