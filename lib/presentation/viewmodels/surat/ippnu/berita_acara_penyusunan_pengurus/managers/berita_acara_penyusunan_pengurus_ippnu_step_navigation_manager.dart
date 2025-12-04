import 'package:get/get.dart';

import '../enum/berita_acara_penyusunan_pengurus_ippnu_form_step.dart';

/// Manager untuk navigasi step pada form Berita Acara Penyusunan Pengurus
class BeritaAcaraPenyusunanPengurusIppnuStepNavigationManager {
  final currentStep = Rx<BeritaAcaraPenyusunanPengurusIppnuFormStep>(
    BeritaAcaraPenyusunanPengurusIppnuFormStep.informasiLembaga,
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

  void goToStep(BeritaAcaraPenyusunanPengurusIppnuFormStep step) {
    currentStep.value = step;
  }

  void reset() {
    currentStep.value =
        BeritaAcaraPenyusunanPengurusIppnuFormStep.informasiLembaga;
  }

  bool get canGoNext => currentStep.value.next != null;
  bool get canGoPrevious => currentStep.value.previous != null;
  bool get isLastStep =>
      currentStep.value == BeritaAcaraPenyusunanPengurusIppnuFormStep.review;
  bool get isFirstStep =>
      currentStep.value ==
      BeritaAcaraPenyusunanPengurusIppnuFormStep.informasiLembaga;

  int get currentStepIndex => currentStep.value.index;
  String get currentStepTitle => currentStep.value.title;
}
