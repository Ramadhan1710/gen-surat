import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/berita_acara_rapat_formatur/widgets/step_lembaga_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/berita_acara_rapat_formatur/widgets/step_waktu_tempat_section.dart';
import 'package:gen_surat/presentation/pages/surat/widgets/form_navigation_button.dart';
import 'package:gen_surat/presentation/routes/app_routes.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/berita_acara_rapat_formatur/berita_acara_rapat_formatur_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/berita_acara_rapat_formatur/enum/berita_acara_rapat_formatur_ipnu_form_step.dart';
import 'package:gen_surat/presentation/widgets/form_stepper_progress.dart';
import 'package:gen_surat/presentation/widgets/error_message_widget.dart';
import 'package:gen_surat/presentation/widgets/generated_file_card.dart';
import 'package:gen_surat/presentation/widgets/file_location_dialog.dart';
import 'package:gen_surat/presentation/widgets/reset_confirmation_dialog.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/berita_acara_rapat_formatur/widgets/step_tim_formatur_section.dart';
import 'package:get/get.dart';

class BeritaAcaraRapatFormaturIpnuPage extends StatelessWidget {
  const BeritaAcaraRapatFormaturIpnuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<BeritaAcaraRapatFormaturIpnuViewmodel>();

    return Scaffold(
      appBar: _buildAppBar(context, vm),
      body: Form(
        key: vm.formKey,
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
    BeritaAcaraRapatFormaturIpnuViewmodel vm,
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

  Widget _buildStepContent(BeritaAcaraRapatFormaturIpnuViewmodel vm) {
    switch (vm.currentStep.value) {
      case BeritaAcaraRapatFormaturIpnuFormStep.lembaga:
        return StepLembagaSection(viewModel: vm);
      case BeritaAcaraRapatFormaturIpnuFormStep.waktuTempat:
        return StepWaktuTempatSection(viewModel: vm);
      case BeritaAcaraRapatFormaturIpnuFormStep.timFormatur:
        return StepTimFormaturSection(viewModel: vm);
    }
  }

  Widget _buildBottomSection(
    BuildContext context,
    BeritaAcaraRapatFormaturIpnuViewmodel vm,
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
            _buildNavigationButtons(context, vm),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(
    BuildContext context,
    BeritaAcaraRapatFormaturIpnuViewmodel vm,
  ) {
    return Obx(() {
      return FormNavigationButton(
        isLoading: vm.isLoading.value,
        uploadProgress: vm.uploadProgress.value,
        hasGeneratedFile: vm.generatedFile.value != null,
        generatedFileWidget:
            vm.generatedFile.value != null
                ? GeneratedFileCard(
                  fileName: vm.getFileName(),
                  fileSize: vm.getFileSize(),
                  onShowLocation:
                      () => FileLocationDialog.show(context, vm.getFilePath()),
                  onOpen: vm.openGeneratedFile,
                  onShare: vm.shareGeneratedFile,
                )
                : null,
        canGoPrevious: vm.canGoPrevious(),
        canGoNext: vm.canGoNext(),
        isLastStep: vm.isLastStep(),
        onPrevious: vm.previousStep,
        onNext: vm.nextStep,
        onGenerate: vm.generateSurat,
        onCancelLoading: vm.cancelGenerate,
        onDone: AppRoutes.back,
      );
    });
  }

  Widget _buildErrorSection(BeritaAcaraRapatFormaturIpnuViewmodel vm) {
    return Obx(() {
      if (vm.errorMessage.value == null) return const SizedBox.shrink();

      return ErrorMessageWidget(message: vm.errorMessage.value!);
    });
  }
}
