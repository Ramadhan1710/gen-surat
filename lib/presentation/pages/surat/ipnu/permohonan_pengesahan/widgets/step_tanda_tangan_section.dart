import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/helper/file_helper.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/presentation/viewmodels/surat/permohonan_pengesahan/surat_permohonan_pengesahan_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/file_picker_widget.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/widgets/section_header.dart';
import 'package:get/get.dart';

import '../../../../../viewmodels/surat/permohonan_pengesahan/surat_permohonan_pengesahan_ipnu_viewmodel.dart';

class StepTandaTanganSection extends StatelessWidget {
  final SuratPermohonanPengesahanIpnuViewmodel viewModel;

  const StepTandaTanganSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Tanda Tangan'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Upload tanda tangan digital untuk ketua dan sekretaris. File harus berformat gambar (JPG, PNG).',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        Container(
          padding: const EdgeInsets.all(AppDimensions.spaceM),
          decoration: BoxDecoration(
            color: AppColors.warning.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            border: Border.all(color: AppColors.warning),
          ),
          child: Column(
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
            ],
          ),
        ),

        const SizedBox(height: AppDimensions.spaceM),
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
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }

  Widget _buildRowInformation(
    BuildContext context,
    String nomor,
    String information,
  ) {
    return Row(
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
    );
  }
}
