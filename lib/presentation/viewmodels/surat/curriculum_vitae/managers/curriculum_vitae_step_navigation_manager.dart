import 'package:get/get.dart';
import 'package:gen_surat/presentation/viewmodels/surat/curriculum_vitae/enum/curriculum_vitae_form_step.dart';

class CurriculumVitaeStepNavigationManager {
  final currentStep = CurriculumVitaeFormStep.lembaga.obs;

  bool get canGoPrevious => currentStep.value.index > 0;

  bool get canGoNext =>
      currentStep.value.index < CurriculumVitaeFormStep.values.length - 1;

  bool get isLastStep =>
      currentStep.value == CurriculumVitaeFormStep.values.last;

  void nextStep() {
    if (canGoNext) {
      currentStep.value =
          CurriculumVitaeFormStep.values[currentStep.value.index + 1];
    }
  }

  void previousStep() {
    if (canGoPrevious) {
      currentStep.value =
          CurriculumVitaeFormStep.values[currentStep.value.index - 1];
    }
  }

  void resetToFirstStep() {
    currentStep.value = CurriculumVitaeFormStep.lembaga;
  }
}
