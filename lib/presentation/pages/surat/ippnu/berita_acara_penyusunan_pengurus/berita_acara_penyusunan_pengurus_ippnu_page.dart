import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/pages/surat/widgets/form_navigation_button.dart';
import 'package:gen_surat/presentation/routes/app_routes.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_penyusunan_pengurus/enum/berita_acara_penyusunan_pengurus_ippnu_form_step.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_penyusunan_pengurus/berita_acara_penyusunan_pengurus_ippnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/form_stepper_progress.dart';
import 'package:gen_surat/presentation/widgets/error_message_widget.dart';
import 'package:gen_surat/presentation/widgets/generated_file_card.dart';
import 'package:gen_surat/presentation/widgets/file_location_dialog.dart';
import 'package:gen_surat/presentation/widgets/reset_confirmation_dialog.dart';
import 'package:gen_surat/presentation/pages/surat/ippnu/berita_acara_penyusunan_pengurus/widgets/step_informasi_lembaga_section.dart';
import 'package:gen_surat/presentation/pages/surat/ippnu/berita_acara_penyusunan_pengurus/widgets/step_data_pengurus_harian_section.dart';
import 'package:gen_surat/presentation/pages/surat/ippnu/berita_acara_penyusunan_pengurus/widgets/step_data_pelindung_pembina_section.dart';
import 'package:gen_surat/presentation/pages/surat/ippnu/berita_acara_penyusunan_pengurus/widgets/step_data_pengurus_inti_section.dart';
import 'package:gen_surat/presentation/pages/surat/ippnu/berita_acara_penyusunan_pengurus/widgets/step_data_departemen_section.dart';
import 'package:gen_surat/presentation/pages/surat/ippnu/berita_acara_penyusunan_pengurus/widgets/step_data_lembaga_section.dart';
import 'package:gen_surat/presentation/pages/surat/ippnu/berita_acara_penyusunan_pengurus/widgets/step_penetapan_section.dart';
import 'package:gen_surat/presentation/pages/surat/ippnu/berita_acara_penyusunan_pengurus/widgets/step_review_section.dart';
import 'package:get/get.dart';

class BeritaAcaraPenyusunanPengurusIppnuPage extends StatelessWidget {
  const BeritaAcaraPenyusunanPengurusIppnuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<BeritaAcaraPenyusunanPengurusIppnuViewmodel>();

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
    BeritaAcaraPenyusunanPengurusIppnuViewmodel vm,
  ) {
    return AppBar(
      title: const Text(
        'Berita Acara Penyusunan Pengurus IPPNU',
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ResetConfirmationDialog.show(context, vm.resetForm),
          tooltip: 'Reset Form',
        ),
      ],
    );
  }

  Widget _buildStepContent(BeritaAcaraPenyusunanPengurusIppnuViewmodel vm) {
    switch (vm.currentStep.value) {
      case BeritaAcaraPenyusunanPengurusIppnuFormStep.informasiLembaga:
        return StepInformasiLembagaSection(viewModel: vm);
      case BeritaAcaraPenyusunanPengurusIppnuFormStep.dataPengurusHarian:
        return StepDataPengurusHarianSection(viewModel: vm);
      case BeritaAcaraPenyusunanPengurusIppnuFormStep.dataPelindungPembina:
        return StepDataPelindungPembinaSection(viewModel: vm);
      case BeritaAcaraPenyusunanPengurusIppnuFormStep.dataPengurusInti:
        return StepDataPengurusIntiSection(viewModel: vm);
      case BeritaAcaraPenyusunanPengurusIppnuFormStep.dataDepartemen:
        return StepDataDepartemenSection(viewModel: vm);
      case BeritaAcaraPenyusunanPengurusIppnuFormStep.dataLembaga:
        return StepDataLembagaSection(viewModel: vm);
      case BeritaAcaraPenyusunanPengurusIppnuFormStep.penetapan:
        return StepPenetapanSection(viewModel: vm);
      case BeritaAcaraPenyusunanPengurusIppnuFormStep.review:
        return StepReviewSection(viewModel: vm);
    }
  }

  Widget _buildBottomSection(
    BuildContext context,
    BeritaAcaraPenyusunanPengurusIppnuViewmodel vm,
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
    BeritaAcaraPenyusunanPengurusIppnuViewmodel vm,
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

  Widget _buildErrorSection(BeritaAcaraPenyusunanPengurusIppnuViewmodel vm) {
    return Obx(() {
      if (vm.errorMessage.value == null) {
        return const SizedBox.shrink();
      }
      return Padding(
        padding: const EdgeInsets.only(bottom: AppDimensions.spaceM),
        child: ErrorMessageWidget(
          message: vm.errorMessage.value!,
        ),
      );
    });
  }
}
