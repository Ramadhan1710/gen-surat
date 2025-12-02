import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/berita_acara_rapat_formatur/widgets/step_lembaga_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/berita_acara_rapat_formatur/widgets/step_waktu_tempat_section.dart';
import 'package:gen_surat/presentation/routes/app_routes.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_rapat_formatur/berita_acara_rapat_formatur_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_rapat_formatur/enum/berita_acara_rapat_formatur_form_step.dart';
import 'package:gen_surat/presentation/widgets/form_stepper_progress.dart';
import 'package:gen_surat/presentation/widgets/error_message_widget.dart';
import 'package:gen_surat/presentation/widgets/loading_progress_widget.dart';
import 'package:gen_surat/presentation/widgets/generated_file_card.dart';
import 'package:gen_surat/presentation/widgets/file_location_dialog.dart';
import 'package:gen_surat/presentation/widgets/reset_confirmation_dialog.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/berita_acara_rapat_formatur/widgets/step_tim_formatur_section.dart';
import 'package:get/get.dart';

class BeritaAcaraRapatFormaturPage extends StatelessWidget {
  const BeritaAcaraRapatFormaturPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<BeritaAcaraRapatFormaturViewmodel>();

    return Scaffold(
      appBar: _buildAppBar(context, vm),
      body: Form(
        key: vm.formDataManager.formKey,
        child: Column(
          children: [
            Obx(
              () => FormStepperProgress(
                currentStep: vm.currentStep.value.index,
                totalSteps: vm.totalSteps,
                stepTitles: vm.stepTitles,
              ),
            ),
            Expanded(child: Obx(() => _buildStepContent(vm))),
            _buildBottomSection(context, vm),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(
    BuildContext context,
    BeritaAcaraRapatFormaturViewmodel vm,
  ) {
    return AppBar(
      title: const Text('Berita Acara Rapat Formatur IPNU'),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ResetConfirmationDialog.show(context, vm.resetForm),
          tooltip: 'Reset Form',
        ),
      ],
    );
  }

  Widget _buildStepContent(BeritaAcaraRapatFormaturViewmodel vm) {
    switch (vm.currentStep.value) {
      case BeritaAcaraRapatFormaturFormStep.lembaga:
        return StepLembagaSection(viewModel: vm);
      case BeritaAcaraRapatFormaturFormStep.waktuTempat:
        return StepWaktuTempatSection(viewModel: vm);
      case BeritaAcaraRapatFormaturFormStep.timFormatur:
        return StepTimFormaturSection(viewModel: vm);
    }
  }

  Widget _buildBottomSection(
    BuildContext context,
    BeritaAcaraRapatFormaturViewmodel vm,
  ) {
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
            _buildErrorSection(vm),
            _buildGeneratedFileSection(context, vm),
            _buildNavigationButtons(context, vm),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(
    BuildContext context,
    BeritaAcaraRapatFormaturViewmodel vm,
  ) {
    return Obx(() {
      if (vm.isLoading.value) {
        return LoadingProgressWidget(
          progress: vm.uploadProgress.value,
          onCancel: vm.cancelGenerate,
        );
      }

      if (vm.generatedFile.value != null) {
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
          style: TextButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      }

      return Row(
        children: [
          if (vm.canGoPrevious())
            Expanded(
              child: OutlinedButton.icon(
                onPressed: vm.previousStep,
                icon: const Icon(Icons.arrow_back),
                label: Text(
                  'Sebelumnya',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
              ),
            ),
          if (vm.canGoPrevious()) const SizedBox(width: AppDimensions.spaceM),
          Expanded(
            child:
                vm.isLastStep()
                    ? OutlinedButton.icon(
                      onPressed: vm.generateSurat,
                      label: Text(
                        'Generate Surat',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                      ),
                    )
                    : OutlinedButton.icon(
                      onPressed: vm.nextStep,
                      icon: const Icon(Icons.arrow_forward),
                      label: Text(
                        'Selanjutnya',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                      ),
                    ),
          ),
        ],
      );
    });
  }

  Widget _buildErrorSection(BeritaAcaraRapatFormaturViewmodel vm) {
    return Obx(() {
      if (vm.errorMessage.value == null) return const SizedBox.shrink();

      return Padding(
        padding: const EdgeInsets.only(bottom: AppDimensions.spaceM),
        child: ErrorMessageWidget(message: vm.errorMessage.value!),
      );
    });
  }

  Widget _buildGeneratedFileSection(
    BuildContext context,
    BeritaAcaraRapatFormaturViewmodel vm,
  ) {
    return Obx(() {
      if (vm.generatedFile.value == null) return const SizedBox.shrink();

      return Padding(
        padding: const EdgeInsets.only(bottom: AppDimensions.spaceM),
        child: GeneratedFileCard(
          fileName: vm.getFileName(),
          fileSize: vm.getFileSize(),
          onShowLocation:
              () => FileLocationDialog.show(context, vm.getFilePath()),
          onOpen: vm.openGeneratedFile,
          onShare: vm.shareGeneratedFile,
        ),
      );
    });
  }
}
