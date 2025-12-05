import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/susunan_pengurus/susunan_pengurus_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/susunan_pengurus/managers/ipnu/susunan_pengurus_ipnu_form_data_manager.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:get/get.dart';

class StepPelindungPembinaSection extends StatelessWidget {
  final SusunanPengurusIpnuViewmodel viewModel;

  const StepPelindungPembinaSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        // ========== PELINDUNG SECTION ==========
        const SectionHeader(title: 'Pelindung Organisasi'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan data pelindung organisasi.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        Obx(() {
          // Trigger rebuild when jenisLembaga changes
          viewModel.formDataManager.jenisLembagaVersion.value;

          if (viewModel.formDataManager.isRanting) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Data Pimpinan Ranting',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppDimensions.spaceM),
                CustomTextField(
                  controller:
                      viewModel.formDataManager.namaRoisSyuriyahController,
                  label: 'Nama Rois Syuriyah',
                  helpText:
                      'Contoh: KH. Ahmad Dahlan, Nama lengkap rois syuriyah PRNU.',
                  hint: 'Masukkan nama Rois Syuriyah',
                  textCapitalization: TextCapitalization.words,
                  validator: UiFieldValidators.required('Nama Rois Syuriyah'),
                ),
                const SizedBox(height: AppDimensions.spaceM),
                CustomTextField(
                  controller:
                      viewModel.formDataManager.namaKetuaTanfidziyahController,
                  label: 'Nama Ketua Tanfidziyah PRNU',
                  helpText:
                      'Contoh: Drs. H. Muhsin, Nama lengkap ketua tanfidziyah PRNU.',
                  hint: 'Masukkan nama Ketua Tanfidziyah',
                  textCapitalization: TextCapitalization.words,
                  validator: UiFieldValidators.required('Nama Ketua Tanfidziyah'),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        }),
        Obx(() {
          // Trigger rebuild when jenisLembaga changes
          viewModel.formDataManager.jenisLembagaVersion.value;

          if (viewModel.formDataManager.isKomisariat) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Data Pimpinan Komisariat',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppDimensions.spaceM),
                CustomTextField(
                  controller:
                      viewModel.formDataManager.namaKepalaMadrasahController,
                  label: 'Nama Kepala Madrasah',
                  helpText:
                      'Contoh: Drs. H. Muhsin, Nama lengkap kepala madrasah tempat komisariat berada.',
                  hint: 'Masukkan nama Kepala Madrasah',
                  textCapitalization: TextCapitalization.words,
                  validator: UiFieldValidators.required('Nama Kepala Madrasah'),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        }),
        const SizedBox(height: AppDimensions.spaceXL),
        // ========== PEMBINA SECTION ==========
        const SectionHeader(title: 'Pembina Organisasi'),
        const SizedBox(height: AppDimensions.spaceS),
        _buildInfoCard(
          context: context,
          title: 'Informasi Pembina Organisasi',
          informations: [
            _buildRowInformation(
              context,
              '1). ',
              'Untuk PR IPNU, diisi dengan Ketua Demisioner Pimpinan setempat, jika belum ada bisa diisi dengan nama PAC IPNU.',
            ),
            _buildRowInformation(
              context,
              '2).',
              'Untuk PK IPNU, diisi dengan nama Pembina Osis, PAC IPNU dan Ketua Demisioner PK IPNU setempat jika sebelumnya sudah ada.',
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceM),

        Obx(() {
          // Trigger rebuild
          viewModel.pembinaVersion.value;
          final pembinaList = viewModel.formDataManager.pembina;

          return Column(
            children: [
              if (pembinaList.isEmpty)
                Container(
                  padding: const EdgeInsets.all(AppDimensions.spaceL),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Belum ada pembina. Klik "Tambah Pembina" untuk menambahkan.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.5),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              else
                ...List.generate(
                  pembinaList.length,
                  (index) =>
                      _buildPembinaCard(context, index, pembinaList[index]),
                ),
              const SizedBox(height: AppDimensions.spaceM),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: viewModel.addPembina,
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah Pembina'),
                ),
              ),
            ],
          );
        }),

        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }

  Widget _buildPembinaCard(BuildContext context, int index, PembinaData data) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceM),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
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
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.spaceS,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'No. ${index + 1}',
                        style: Theme.of(
                          context,
                        ).textTheme.labelMedium?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimensions.spaceS),
                    Text(
                      'Pembina ${index + 1}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => viewModel.removePembina(index),
                  tooltip: 'Hapus pembina',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spaceM),
            CustomTextField(
              controller: data.namaController,
              label: 'Nama Pembina',
              helpText: 'Nama lengkap pembina',
              textCapitalization: TextCapitalization.words,
              hint: 'Masukkan nama pembina',
              validator: UiFieldValidators.required('Nama pembina'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required BuildContext context,
    required String title,
    required List<Widget> informations,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(color: AppColors.info),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: AppColors.info,
                size: AppDimensions.iconM,
              ),
              const SizedBox(width: AppDimensions.spaceS),
              Text(
                title,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.info,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceS),
          ...informations,
        ],
      ),
    );
  }

  Widget _buildRowInformation(
    BuildContext context,
    String nomor,
    String information,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.spaceXS),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nomor,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.info),
          ),
          const SizedBox(width: AppDimensions.spaceS),
          Expanded(
            child: Text(
              information,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.info),
            ),
          ),
        ],
      ),
    );
  }
}
