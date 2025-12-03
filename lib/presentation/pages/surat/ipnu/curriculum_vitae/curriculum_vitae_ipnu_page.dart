import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/pages/surat/widgets/form_navigation_button.dart';
import 'package:gen_surat/presentation/routes/app_routes.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/curriculum_vitae/curriculum_vitae_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/curriculum_vitae/enum/curriculum_vitae_ipnu_form_step.dart';
import 'package:gen_surat/presentation/widgets/form_stepper_progress.dart';
import 'package:gen_surat/presentation/widgets/error_message_widget.dart';
import 'package:gen_surat/presentation/widgets/generated_file_card.dart';
import 'package:gen_surat/presentation/widgets/file_location_dialog.dart';
import 'package:gen_surat/presentation/widgets/reset_confirmation_dialog.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/curriculum_vitae/widgets/step_lembaga_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/curriculum_vitae/widgets/step_data_ketua_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/curriculum_vitae/widgets/step_organisasi_pendidikan_ketua_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/curriculum_vitae/widgets/step_data_sekretaris_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/curriculum_vitae/widgets/step_organisasi_pendidikan_sekretaris_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/curriculum_vitae/widgets/step_data_bendahara_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/curriculum_vitae/widgets/step_organisasi_pendidikan_bendahara_section.dart';
import 'package:get/get.dart';

class CurriculumVitaeIpnuPage extends StatelessWidget {
  const CurriculumVitaeIpnuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<CurriculumVitaeIpnuViewmodel>();

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

  AppBar _buildAppBar(BuildContext context, CurriculumVitaeIpnuViewmodel vm) {
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

  Widget _buildStepContent(CurriculumVitaeIpnuViewmodel vm) {
    switch (vm.currentStep.value) {
      case CurriculumVitaeIpnuFormStep.lembaga:
        return StepLembagaSection(viewModel: vm);
      case CurriculumVitaeIpnuFormStep.dataKetua:
        return StepDataKetuaSection(viewModel: vm);
      case CurriculumVitaeIpnuFormStep.organisasiPendidikanKetua:
        return StepOrganisasiPendidikanKetuaSection(viewModel: vm);
      case CurriculumVitaeIpnuFormStep.dataSekretaris:
        return StepDataSekretarisSection(viewModel: vm);
      case CurriculumVitaeIpnuFormStep.organisasiPendidikanSekretaris:
        return StepOrganisasiPendidikanSekretarisSection(viewModel: vm);
      case CurriculumVitaeIpnuFormStep.dataBendahara:
        return StepDataBendaharaSection(viewModel: vm);
      case CurriculumVitaeIpnuFormStep.organisasiPendidikanBendahara:
        return StepOrganisasiPendidikanBendaharaSection(viewModel: vm);
    }
  }

  Widget _buildBottomSection(
    BuildContext context,
    CurriculumVitaeIpnuViewmodel vm,
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
    CurriculumVitaeIpnuViewmodel vm,
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

  Widget _buildErrorSection(CurriculumVitaeIpnuViewmodel vm) {
    return Obx(() {
      if (vm.errorMessage.value != null) {
        return ErrorMessageWidget(message: vm.errorMessage.value!);
      }
      return const SizedBox.shrink();
    });
  }
}
