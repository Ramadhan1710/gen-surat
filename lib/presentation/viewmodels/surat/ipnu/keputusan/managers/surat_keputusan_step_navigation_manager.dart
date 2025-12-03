import 'package:get/get.dart';

import '../enum/surat_keputusan_form_step.dart';

/// Manager untuk navigasi step pada form Surat Keputusan
/// Mengelola perpindahan antar step dengan validasi
class SuratKeputusanStepNavigationManager {
  final currentStep = Rx<SuratKeputusanFormStep>(
    SuratKeputusanFormStep.lembaga,
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

  void goToStep(SuratKeputusanFormStep step) {
    currentStep.value = step;
  }

  void reset() {
    currentStep.value = SuratKeputusanFormStep.lembaga;
  }

  bool get canGoNext => currentStep.value.next != null;
  bool get canGoPrevious => currentStep.value.previous != null;
  bool get isLastStep =>
      currentStep.value == SuratKeputusanFormStep.tandaTangan;
  bool get isFirstStep => currentStep.value == SuratKeputusanFormStep.lembaga;

  int get currentStepIndex => currentStep.value.index;
  String get currentStepTitle => currentStep.value.title;
}
