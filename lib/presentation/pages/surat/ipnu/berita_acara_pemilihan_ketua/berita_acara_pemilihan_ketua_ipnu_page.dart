import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/presentation/pages/surat/widgets/form_navigation_button.dart';
import 'package:gen_surat/presentation/routes/app_routes.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_pemilihan_ketua/enum/berita_acara_pemilihan_ketua_form_step.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_pemilihan_ketua/berita_acara_pemilihan_ketua_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/form_stepper_progress.dart';
import 'package:gen_surat/presentation/widgets/error_message_widget.dart';
import 'package:gen_surat/presentation/widgets/loading_progress_widget.dart';
import 'package:gen_surat/presentation/widgets/generated_file_card.dart';
import 'package:gen_surat/presentation/widgets/file_location_dialog.dart';
import 'package:gen_surat/presentation/widgets/reset_confirmation_dialog.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/berita_acara_pemilihan_ketua/widgets/step_lembaga_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/berita_acara_pemilihan_ketua/widgets/step_pemilihan_ketua_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/berita_acara_pemilihan_ketua/widgets/step_pencalonan_ketua_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/berita_acara_pemilihan_ketua/widgets/step_pemilihan_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/berita_acara_pemilihan_ketua/widgets/step_ketua_terpilih_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/berita_acara_pemilihan_ketua/widgets/step_formatur_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/berita_acara_pemilihan_ketua/widgets/step_penetapan_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/berita_acara_pemilihan_ketua/widgets/step_tanda_tangan_section.dart';
import 'package:get/get.dart';

class BeritaAcaraPemilihanKetuaIpnuPage extends StatelessWidget {
  const BeritaAcaraPemilihanKetuaIpnuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<BeritaAcaraPemilihanKetuaIpnuViewmodel>();

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
    BeritaAcaraPemilihanKetuaIpnuViewmodel vm,
  ) {
    return AppBar(
      title: const Text('Berita Acara Pemilihan Ketua IPNU'),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ResetConfirmationDialog.show(context, vm.resetForm),
          tooltip: 'Reset Form',
        ),
      ],
    );
  }

  Widget _buildStepContent(BeritaAcaraPemilihanKetuaIpnuViewmodel vm) {
    switch (vm.currentStep.value) {
      case BeritaAcaraPemilihanKetuaFormStep.lembaga:
        return StepLembagaSection(viewModel: vm);
      case BeritaAcaraPemilihanKetuaFormStep.pemilihanKetua:
        return StepPemilihanKetuaSection(viewModel: vm);
      case BeritaAcaraPemilihanKetuaFormStep.pencalonanKetua:
        return StepPencalonanKetuaSection(viewModel: vm);
      case BeritaAcaraPemilihanKetuaFormStep.pemilihan:
        return StepPemilihanSection(viewModel: vm);
      case BeritaAcaraPemilihanKetuaFormStep.ketuaTerpilih:
        return StepKetuaTerpilihSection(viewModel: vm);
      case BeritaAcaraPemilihanKetuaFormStep.formatur:
        return StepFormaturSection(viewModel: vm);
      case BeritaAcaraPemilihanKetuaFormStep.penetapan:
        return StepPenetapanSection(viewModel: vm);
      case BeritaAcaraPemilihanKetuaFormStep.tandaTangan:
        return StepTandaTanganSection(viewModel: vm);
    }
  }

  Widget _buildBottomSection(
    BuildContext context,
    BeritaAcaraPemilihanKetuaIpnuViewmodel vm,
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
    BeritaAcaraPemilihanKetuaIpnuViewmodel vm,
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

  Widget _buildErrorSection(BeritaAcaraPemilihanKetuaIpnuViewmodel vm) {
    return Obx(() {
      if (vm.errorMessage.value != null) {
        return ErrorMessageWidget(message: vm.errorMessage.value!);
      }
      return const SizedBox.shrink();
    });
  }
}
