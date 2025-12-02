import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/presentation/routes/app_routes.dart';
import 'package:gen_surat/presentation/viewmodels/surat/curriculum_vitae/curriculum_vitae_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/curriculum_vitae/enum/curriculum_vitae_form_step.dart';
import 'package:gen_surat/presentation/widgets/form_stepper_progress.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/widgets/error_message_widget.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/widgets/loading_progress_widget.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/widgets/generated_file_card.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/widgets/file_location_dialog.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/widgets/reset_confirmation_dialog.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/curriculum_vitae/widgets/step_lembaga_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/curriculum_vitae/widgets/step_data_ketua_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/curriculum_vitae/widgets/step_organisasi_pendidikan_ketua_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/curriculum_vitae/widgets/step_data_sekretaris_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/curriculum_vitae/widgets/step_organisasi_pendidikan_sekretaris_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/curriculum_vitae/widgets/step_data_bendahara_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/curriculum_vitae/widgets/step_organisasi_pendidikan_bendahara_section.dart';
import 'package:get/get.dart';

class CurriculumVitaePage extends StatelessWidget {
  const CurriculumVitaePage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<CurriculumVitaeViewmodel>();

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

  AppBar _buildAppBar(BuildContext context, CurriculumVitaeViewmodel vm) {
    return AppBar(
      title: const Text('Curriculum Vitae (CV) Pengurus Harian'),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ResetConfirmationDialog.show(context, vm.resetForm),
          tooltip: 'Reset Form',
        ),
      ],
    );
  }

  Widget _buildStepContent(CurriculumVitaeViewmodel vm) {
    switch (vm.currentStep.value) {
      case CurriculumVitaeFormStep.lembaga:
        return StepLembagaSection(viewModel: vm);
      case CurriculumVitaeFormStep.dataKetua:
        return StepDataKetuaSection(viewModel: vm);
      case CurriculumVitaeFormStep.organisasiPendidikanKetua:
        return StepOrganisasiPendidikanKetuaSection(viewModel: vm);
      case CurriculumVitaeFormStep.dataSekretaris:
        return StepDataSekretarisSection(viewModel: vm);
      case CurriculumVitaeFormStep.organisasiPendidikanSekretaris:
        return StepOrganisasiPendidikanSekretarisSection(viewModel: vm);
      case CurriculumVitaeFormStep.dataBendahara:
        return StepDataBendaharaSection(viewModel: vm);
      case CurriculumVitaeFormStep.organisasiPendidikanBendahara:
        return StepOrganisasiPendidikanBendaharaSection(viewModel: vm);
    }
  }

  Widget _buildBottomSection(BuildContext context, CurriculumVitaeViewmodel vm) {
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

  Widget _buildNavigationButtons(BuildContext context, CurriculumVitaeViewmodel vm) {
    return Obx(() {
      if (vm.isLoading.value) {
        return LoadingProgressWidget(
          progress: vm.uploadProgress.value,
          onCancel: vm.cancelGenerate,
        );
      }

      if (vm.generatedFile.value != null) {
        return TextButton.icon(
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
          if ((vm.canGoPrevious() && vm.canGoNext()) || vm.isLastStep())
            const SizedBox(width: AppDimensions.spaceM),
          Expanded(
            flex: vm.canGoPrevious() ? 1 : 2,
            child: vm.isLastStep()
                ? OutlinedButton(
                    onPressed: vm.generateSurat,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      'Generate CV',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
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
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
          ),
        ],
      );
    });
  }

  Widget _buildErrorSection(CurriculumVitaeViewmodel vm) {
    return Obx(() {
      if (vm.errorMessage.value != null) {
        return ErrorMessageWidget(message: vm.errorMessage.value!);
      }
      return const SizedBox.shrink();
    });
  }

  Widget _buildGeneratedFileSection(BuildContext context, CurriculumVitaeViewmodel vm) {
    return Obx(() {
      if (vm.generatedFile.value != null) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppDimensions.spaceM),
          child: GeneratedFileCard(
            fileName: vm.getFileName(),
            fileSize: vm.getFileSize(),
            onShowLocation: () => FileLocationDialog.show(context, vm.getFilePath()),
            onOpen: vm.openGeneratedFile,
            onShare: vm.shareGeneratedFile,
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
