import 'package:get/get.dart';

import '../enum/susunan_pengurus_form_step.dart';

class SusunanPengurusStepNavigationManager {
  final currentStep = Rx<SusunanPengurusFormStep>(
    SusunanPengurusFormStep.lembaga,
  );

  void nextStep() {
    final next = currentStep.value.next;
    if (next != null) {
      currentStep.value = next;
    }
  }

  void previousStep() {
    final previous = currentStep.value.previous;
    if (previous != null) {
      currentStep.value = previous;
    }
  }

  void goToStep(SusunanPengurusFormStep step) {
    currentStep.value = step;
  }

  void reset() {
    currentStep.value = SusunanPengurusFormStep.lembaga;
  }

  bool get canGoNext => currentStep.value.next != null;
  bool get canGoPrevious => currentStep.value.previous != null;
  bool get isLastStep => currentStep.value == SusunanPengurusFormStep.cbpDivisi;
  bool get isFirstStep => currentStep.value == SusunanPengurusFormStep.lembaga;

  int get currentStepIndex => currentStep.value.index;
  String get currentStepTitle => currentStep.value.title;
}
