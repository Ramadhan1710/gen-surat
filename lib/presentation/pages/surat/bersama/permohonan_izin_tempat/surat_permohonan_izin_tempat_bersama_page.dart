import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/pages/surat/bersama/permohonan_izin_tempat/widgets/step_isi_section.dart';
import 'package:gen_surat/presentation/pages/surat/bersama/permohonan_izin_tempat/widgets/step_pembuka_section.dart';
import 'package:gen_surat/presentation/pages/surat/bersama/permohonan_izin_tempat/widgets/step_penutup_section.dart';
import 'package:gen_surat/presentation/pages/surat/widgets/form_navigation_button.dart';
import 'package:gen_surat/presentation/routes/app_routes.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/permohonan_izin_tempat/enum/surat_permohonan_izin_tempat_bersama_form_step.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/permohonan_izin_tempat/surat_permohonan_izin_tempat_bersama_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/undangan/surat_undangan_bersama_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/form_stepper_progress.dart';
import 'package:gen_surat/presentation/widgets/error_message_widget.dart';
import 'package:gen_surat/presentation/widgets/generated_file_card.dart';
import 'package:gen_surat/presentation/widgets/file_location_dialog.dart';
import 'package:gen_surat/presentation/widgets/reset_confirmation_dialog.dart';
import 'package:get/get.dart';

class SuratPermohonanIzinTempatBersamaPage extends StatelessWidget {
  const SuratPermohonanIzinTempatBersamaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<SuratPermohonanIzinTempatBersamaViewmodel>();

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
    SuratPermohonanIzinTempatBersamaViewmodel vm,
  ) {
    return AppBar(
      title: const Text('Form Surat Permohonan Izin Tempat Bersama'),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ResetConfirmationDialog.show(context, vm.resetForm),
          tooltip: 'Reset Form',
        ),
      ],
    );
  }

  Widget _buildStepContent(SuratPermohonanIzinTempatBersamaViewmodel vm) {
    switch (vm.currentStep.value) {
      case SuratPermohonanIzinTempatBersamaFormStep.pembuka:
        return StepPembukaSection(viewModel: vm);
      case SuratPermohonanIzinTempatBersamaFormStep.isi:
        return StepIsiSection(viewModel: vm);
      case SuratPermohonanIzinTempatBersamaFormStep.penutup:
        return StepPenutupSection(viewModel: vm);
    }
  }

  Widget _buildBottomSection(
    BuildContext context,
    SuratPermohonanIzinTempatBersamaViewmodel vm,
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
    SuratPermohonanIzinTempatBersamaViewmodel vm,
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

  Widget _buildErrorSection(SuratPermohonanIzinTempatBersamaViewmodel vm) {
    return Obx(() {
      if (vm.errorMessage.value != null) {
        return ErrorMessageWidget(message: vm.errorMessage.value!);
      }
      return const SizedBox.shrink();
    });
  }
}
