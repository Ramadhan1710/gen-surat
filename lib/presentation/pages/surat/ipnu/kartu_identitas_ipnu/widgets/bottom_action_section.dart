import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/presentation/routes/app_routes.dart';
import 'package:gen_surat/presentation/viewmodels/surat/kartu_identitas/kartu_identitas_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/error_message_widget.dart';
import 'package:gen_surat/presentation/widgets/loading_progress_widget.dart';
import 'package:gen_surat/presentation/widgets/generated_file_card.dart';
import 'package:gen_surat/presentation/widgets/file_location_dialog.dart';
import 'package:get/get.dart';

class BottomActionSection extends StatelessWidget {
  final KartuIdentitasViewmodel viewModel;

  const BottomActionSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildErrorSection(),
            _buildGeneratedFileSection(context),
            _buildActionButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorSection() {
    return Obx(() {
      if (viewModel.errorMessage.value == null) return const SizedBox.shrink();

      return ErrorMessageWidget(message: viewModel.errorMessage.value!);
    });
  }

  Widget _buildGeneratedFileSection(BuildContext context) {
    return Obx(() {
      if (viewModel.generatedFile.value == null) return const SizedBox.shrink();

      return Padding(
        padding: const EdgeInsets.only(bottom: AppDimensions.spaceM),
        child: GeneratedFileCard(
          fileName: viewModel.getFileName(),
          fileSize: viewModel.getFileSize(),
          onShowLocation:
              () => FileLocationDialog.show(context, viewModel.getFilePath()),
          onOpen: viewModel.openGeneratedFile,
          onShare: viewModel.shareGeneratedFile,
        ),
      );
    });
  }

  Widget _buildActionButton(BuildContext context) {
    return Obx(() {
      if (viewModel.isLoading.value) {
        return LoadingProgressWidget(
          progress: viewModel.uploadProgress.value,
          onCancel: viewModel.cancelGenerate,
        );
      }

      if (viewModel.generatedFile.value != null) {
        return FilledButton.icon(
          onPressed: AppRoutes.back,
          icon: Icon(
            Icons.check_circle_rounded,
            size: 20,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          label: Text(
            'Selesai',
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }

      return FilledButton(
        onPressed: viewModel.generateSurat,
        style: FilledButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Generate Surat',
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      );
    });
  }
}
