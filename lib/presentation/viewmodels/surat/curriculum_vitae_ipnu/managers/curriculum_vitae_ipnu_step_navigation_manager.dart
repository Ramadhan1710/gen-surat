import 'package:get/get.dart';
import 'package:gen_surat/presentation/viewmodels/surat/curriculum_vitae_ipnu/enum/curriculum_vitae_ipnu_form_step.dart';

class CurriculumVitaeIpnuStepNavigationManager {
  final currentStep = CurriculumVitaeIpnuFormStep.lembaga.obs;

  bool get canGoPrevious => currentStep.value.index > 0;

  bool get canGoNext =>
      currentStep.value.index < CurriculumVitaeIpnuFormStep.values.length - 1;

  bool get isLastStep =>
      currentStep.value == CurriculumVitaeIpnuFormStep.values.last;

  void nextStep() {
    if (canGoNext) {
      currentStep.value =
          CurriculumVitaeIpnuFormStep.values[currentStep.value.index + 1];
    }
  }

  void previousStep() {
    if (canGoPrevious) {
      currentStep.value =
          CurriculumVitaeIpnuFormStep.values[currentStep.value.index - 1];
    }
  }

  void resetToFirstStep() {
    currentStep.value = CurriculumVitaeIpnuFormStep.lembaga;
  }
}
