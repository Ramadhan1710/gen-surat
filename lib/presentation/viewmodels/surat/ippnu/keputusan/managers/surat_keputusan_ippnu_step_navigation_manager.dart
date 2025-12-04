import 'package:get/get.dart';
import '../enum/surat_keputusan_ippnu_form_step.dart';

class SuratKeputusanIppnuStepNavigationManager {
  final currentStep = Rx<SuratKeputusanIppnuFormStep>(
    SuratKeputusanIppnuFormStep.lembaga,
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

  void goToStep(SuratKeputusanIppnuFormStep step) {
    currentStep.value = step;
  }

  void reset() {
    currentStep.value = SuratKeputusanIppnuFormStep.lembaga;
  }

  bool get canGoNext => currentStep.value.next != null;
  bool get canGoPrevious => currentStep.value.previous != null;
  bool get isLastStep =>
      currentStep.value == SuratKeputusanIppnuFormStep.tandaTangan;
  bool get isFirstStep =>
      currentStep.value == SuratKeputusanIppnuFormStep.lembaga;

  int get currentStepIndex => currentStep.value.index;
  String get currentStepTitle => currentStep.value.title;
}
