import 'package:get/get.dart';

import '../enum/berita_acara_formatur_pembentukan_pengurus_harian_form_step.dart';

/// Manager untuk navigasi step pada form Berita Acara Formatur Pembentukan Pengurus Harian
class BeritaAcaraFormaturPembentukanPengurusHarianStepNavigationManager {
  final currentStep =
      Rx<BeritaAcaraFormaturPembentukanPengurusHarianFormStep>(
    BeritaAcaraFormaturPembentukanPengurusHarianFormStep.informasiLembaga,
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

  void goToStep(BeritaAcaraFormaturPembentukanPengurusHarianFormStep step) {
    currentStep.value = step;
  }

  void reset() {
    currentStep.value =
        BeritaAcaraFormaturPembentukanPengurusHarianFormStep.informasiLembaga;
  }

  bool get canGoNext => currentStep.value.next != null;
  bool get canGoPrevious => currentStep.value.previous != null;
  bool get isLastStep =>
      currentStep.value ==
      BeritaAcaraFormaturPembentukanPengurusHarianFormStep.review;
  bool get isFirstStep =>
      currentStep.value ==
      BeritaAcaraFormaturPembentukanPengurusHarianFormStep.informasiLembaga;

  int get currentStepIndex => currentStep.value.index;
  String get currentStepTitle => currentStep.value.title;
}
