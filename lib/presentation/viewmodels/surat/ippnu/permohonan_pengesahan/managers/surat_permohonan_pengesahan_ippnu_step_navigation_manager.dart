import 'package:get/get.dart';

import '../enum/surat_permohonan_pengesahan_ippnu_form_step.dart';

class SuratPermohonanPengesahanIppnuStepNavigationManager {
  final currentStep = Rx<SuratPermohonanPengesahanIppnuFormStep>(
    SuratPermohonanPengesahanIppnuFormStep.lembaga,
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

  void goToStep(SuratPermohonanPengesahanIppnuFormStep step) {
    currentStep.value = step;
  }

  void reset() {
    currentStep.value = SuratPermohonanPengesahanIppnuFormStep.lembaga;
  }

  bool get canGoNext => currentStep.value.next != null;
  bool get canGoPrevious => currentStep.value.previous != null;
  bool get isLastStep =>
      currentStep.value == SuratPermohonanPengesahanIppnuFormStep.tandaTangan;
  bool get isFirstStep =>
      currentStep.value == SuratPermohonanPengesahanIppnuFormStep.lembaga;

  int get currentStepIndex => currentStep.value.index;
  String get currentStepTitle => currentStep.value.title;
}
