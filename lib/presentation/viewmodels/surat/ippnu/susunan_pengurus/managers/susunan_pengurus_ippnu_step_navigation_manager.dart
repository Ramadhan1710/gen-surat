import 'package:get/get.dart';
import '../enum/susunan_pengurus_ippnu_form_step.dart';

class SusunanPengurusIppnuStepNavigationManager {
  final currentStep = Rx<SusunanPengurusIppnuFormStep>(
    SusunanPengurusIppnuFormStep.lembaga,
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

  void goToStep(SusunanPengurusIppnuFormStep step) {
    currentStep.value = step;
  }

  void reset() {
    currentStep.value = SusunanPengurusIppnuFormStep.lembaga;
  }

  bool get canGoNext => currentStep.value.next != null;
  bool get canGoPrevious => currentStep.value.previous != null;
  bool get isLastStep =>
      currentStep.value == SusunanPengurusIppnuFormStep.lembagaInternal;
  bool get isFirstStep =>
      currentStep.value == SusunanPengurusIppnuFormStep.lembaga;

  int get currentStepIndex => currentStep.value.index;
  String get currentStepTitle => currentStep.value.title;
}
