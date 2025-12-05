import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:get/get.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_pemilihan_ketua/berita_acara_pemilihan_ketua_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_pemilihan_ketua/managers/berita_acara_pemilihan_ketua_form_data_manager.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

class StepFormaturSection extends StatelessWidget {
  final BeritaAcaraPemilihanKetuaViewmodel viewModel;

  const StepFormaturSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Tahap Pemilihan Tim Formatur'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan data anggota tim formatur yang dipilih.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        Container(
          padding: const EdgeInsets.all(AppDimensions.spaceM),
          decoration: BoxDecoration(
            color: AppColors.info.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.info),
          ),
          child: Text(
            'Anggota 1 (Ketua Terpilih) dan Anggota 2 (Ketua Demisioner) memiliki daerah pengkaderan yang sudah ditentukan.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.info),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        Obx(() {
          // Use version to trigger rebuild
          final _ = viewModel.formaturVersion.value;
          return Column(
            children: [
              ...List.generate(
                viewModel.formDataManager.formatur.length,
                (index) => _buildFormaturCard(
                  context,
                  index,
                  viewModel.formDataManager.formatur[index],
                ),
              ),
              const SizedBox(height: AppDimensions.spaceM),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: viewModel.addFormatur,
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah Anggota Formatur'),
                ),
              ),
            ],
          );
        }),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }

  Widget _buildFormaturCard(
    BuildContext context,
    int index,
    FormaturData data,
  ) {
    final isReadOnly = data.isDaerahPengkaderanReadOnly;
    final badgeText =
        index == 0
            ? 'Ketua Terpilih'
            : index == 1
            ? 'Ketua Demisioner'
            : null;

    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceM),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spaceM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'Anggota ${index + 1}',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      if (badgeText != null) ...[
                        const SizedBox(width: AppDimensions.spaceS),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.spaceS,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            badgeText,
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => viewModel.removeFormatur(index),
                  tooltip: 'Hapus anggota formatur',
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spaceM),
            CustomTextField(
              controller: data.namaController,
              label: 'Nama Anggota *',
              helpText: 'Nama lengkap anggota formatur',
              textCapitalization: TextCapitalization.words,
              hint: 'Masukkan nama',
              validator: UiFieldValidators.required('Nama anggota formatur'),
            ),
            const SizedBox(height: AppDimensions.spaceM),
            CustomTextField(
              controller: data.alamatController,
              label: 'Alamat *',
              helpText: 'Alamat anggota. \nContoh: Desa Ngepeh/Dusun Krajan',
              textCapitalization: TextCapitalization.words,
              hint: 'Masukkan alamat',
              maxLines: 2,
              validator: UiFieldValidators.required('Alamat anggota formatur'),
            ),
            const SizedBox(height: AppDimensions.spaceM),
            CustomTextField(
              controller: data.daerahPengkaderanController,
              label: 'Daerah Pengkaderan *',
              helpText:
                  isReadOnly
                      ? 'Sudah diatur otomatis'
                      : 'Daerah pengkaderan anggota, Contoh: Zona I, Zona II.\n'
                          'Untuk PK, cukup isi dengan tanda -',
              textCapitalization: TextCapitalization.words,
              hint: 'Masukkan daerah pengkaderan',
              enabled: !isReadOnly,
              validator: UiFieldValidators.required('Daerah pengkaderan'),
            ),
            if (isReadOnly)
              Padding(
                padding: const EdgeInsets.only(top: AppDimensions.spaceS),
                child: Row(
                  children: [
                    Icon(
                      Icons.lock_outline,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: AppDimensions.spaceXS),
                    Expanded(
                      child: Text(
                        'Daerah pengkaderan ini sudah ditentukan dan tidak dapat diubah',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
