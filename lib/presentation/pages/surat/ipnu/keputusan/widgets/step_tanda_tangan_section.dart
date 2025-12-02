import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/presentation/viewmodels/surat/keputusan/surat_keputusan_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/file_picker_widget.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:get/get.dart';

/// Widget untuk step 4: Tanda Tangan
/// Berisi upload 3 tanda tangan: ketua, sekretaris, dan anggota
class StepTandaTanganSection extends StatelessWidget {
  final SuratKeputusanIpnuViewmodel viewModel;

  const StepTandaTanganSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Tanda Tangan'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Upload tanda tangan digital untuk ketua, sekretaris, dan anggota. File harus berformat gambar (JPG, PNG).',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        _buildInfoCard(context),
        const SizedBox(height: AppDimensions.spaceL),
        Obx(
          () => FilePickerWidget(
            label: 'Tanda Tangan Ketua *',
            file: viewModel.ttdKetuaFile.value,
            onPick: () async {
              final file = await ImagePickerHelper.pickImage(context);
              if (file != null) {
                viewModel.setTtdKetua(file);
              }
            },
            onRemove: viewModel.removeTtdKetua,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        Obx(
          () => FilePickerWidget(
            label: 'Tanda Tangan Sekretaris *',
            file: viewModel.ttdSekretarisFile.value,
            onPick: () async {
              final file = await ImagePickerHelper.pickImage(context);
              if (file != null) {
                viewModel.setTtdSekretaris(file);
              }
            },
            onRemove: viewModel.removeTtdSekretaris,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        Obx(
          () => FilePickerWidget(
            label: 'Tanda Tangan Anggota *',
            file: viewModel.ttdAnggotaFile.value,
            onPick: () async {
              final file = await ImagePickerHelper.pickImage(context);
              if (file != null) {
                viewModel.setTtdAnggota(file);
              }
            },
            onRemove: viewModel.removeTtdAnggota,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(color: AppColors.warning),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: AppColors.warning,
                size: AppDimensions.iconM,
              ),
              const SizedBox(width: AppDimensions.spaceS),
              Text(
                'Petunjuk Upload Tanda Tangan',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.warning,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceS),
          _buildRowInformation(
            context,
            '1). ',
            'Pastikan tanda tangan jelas dan terbaca dengan baik.',
          ),
          _buildRowInformation(
            context,
            '2).',
            'Usahakan crop tanda tangan hingga hanya menyisakan area tanda tangan saja.',
          ),
          _buildRowInformation(
            context,
            '3).',
            'Usahakan gambar sudah di remove background atau transparan.',
          ),
          _buildRowInformation(
            context,
            '4).',
            'Surat keputusan memerlukan 3 tanda tangan (ketua, sekretaris, dan anggota).',
          ),
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
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.warning),
          ),
          const SizedBox(width: AppDimensions.spaceS),
          Expanded(
            child: Text(
              information,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.warning),
            ),
          ),
        ],
      ),
    );
  }
}
