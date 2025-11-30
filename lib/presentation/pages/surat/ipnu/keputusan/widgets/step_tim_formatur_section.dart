import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/presentation/viewmodels/surat/keputusan/surat_keputusan_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/widgets/section_header.dart';
import 'package:get/get.dart';

class StepTimFormaturSection extends StatelessWidget {
  final SuratKeputusanIpnuViewmodel viewModel;

  const StepTimFormaturSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppDimensions.spaceM),
            children: [
              const SectionHeader(title: 'Tim Formatur'),
              const SizedBox(height: AppDimensions.spaceS),
              Text(
                'Masukkan daftar anggota tim formatur. Minimal 1 anggota.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: AppDimensions.spaceM),
              _buildInfoCard(context),
              const SizedBox(height: AppDimensions.spaceL),
              Obx(() {
                viewModel.timFormaturVersion.value;
                return _buildTimFormaturList(context);
              }),
              const SizedBox(height: AppDimensions.spaceXXL),
            ],
          ),
        ),
        _buildAddButton(context),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(color: AppColors.info.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: AppColors.info,
            size: AppDimensions.iconM,
          ),
          const SizedBox(width: AppDimensions.spaceM),
          Expanded(
            child: Text(
              'Tim formatur adalah tim yang ditunjuk untuk mengatur kepengurusan baru.\n'
              'Anggota 1 adalah Ketua Terpilih / Ketua Formatur.\n'
              'Anggota 2 adalah Ketua Demisioner.\n'
              'Anggota selanjutnya adalah anggota formatur lainnya.',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.info),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimFormaturList(BuildContext context) {
    if (viewModel.timFormatur.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(AppDimensions.spaceXL),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.group_add,
              size: 48,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            ),
            const SizedBox(height: AppDimensions.spaceM),
            Text(
              'Belum ada anggota tim formatur',
              style: AppTextStyles.bodyMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: AppDimensions.spaceS),
            Text(
              'Tap tombol "+ Tambah Anggota" untuk menambahkan',
              style: AppTextStyles.bodySmall.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: List.generate(
        viewModel.timFormatur.length,
        (index) => _buildTimFormaturCard(context, index),
      ),
    );
  }

  Widget _buildTimFormaturCard(BuildContext context, int index) {
    final anggota = viewModel.timFormatur[index];

    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceM),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spaceM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.spaceM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Anggota ${index + 1}',
                        style: AppTextStyles.titleSmall.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      if (anggota.isDaerahPengkaderanReadOnly)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.info.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: AppColors.info.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            anggota.daerahPengkaderan,
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.info,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline, color: AppColors.error),
                  onPressed: () => _showDeleteConfirmation(context, index),
                  tooltip: 'Hapus anggota',
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spaceM),
            CustomTextField(
              controller: anggota.namaController,
              label: 'Nama Anggota *',
              hint: 'Masukkan nama lengkap',
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama anggota wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: AppDimensions.spaceM),
            CustomTextField(
              controller: anggota.daerahPengkaderanController,
              label: 'Daerah Pengkaderan *',
              hint: 'Masukkan daerah pengkaderan',
              helpText: anggota.isDaerahPengkaderanReadOnly 
                  ? 'Daerah pengkaderan untuk anggota ini sudah ditetapkan'
                  : 'Contoh: Zona I, Zona II, dll.',
              textCapitalization: TextCapitalization.words,
              enabled: !anggota.isDaerahPengkaderanReadOnly,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Daerah pengkaderan wajib diisi';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: AppDimensions.spaceM,
        right: AppDimensions.spaceM,
        top: AppDimensions.spaceM,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: OutlinedButton.icon(
          onPressed: () => viewModel.addTimFormatur(),
          icon: const Icon(Icons.add),
          label: const Text('Tambah Anggota'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Hapus Anggota'),
            content: Text(
              'Apakah Anda yakin ingin menghapus anggota ${index + 1} dari tim formatur?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Batal'),
              ),
              TextButton(
                onPressed: () {
                  viewModel.removeTimFormatur(index);
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(foregroundColor: AppColors.error),
                child: const Text('Hapus'),
              ),
            ],
          ),
    );
  }
}
