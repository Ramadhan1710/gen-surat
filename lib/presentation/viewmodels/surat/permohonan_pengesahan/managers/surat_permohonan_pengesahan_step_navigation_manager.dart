import 'package:get/get.dart';

import '../enum/surat_permohonan_pengesahan_form_step.dart';

class SuratPermohonanPengesahanStepNavigationManager {
   final currentStep = Rx<SuratPermohonanPengesahanFormStep>(SuratPermohonanPengesahanFormStep.lembaga);
  
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
  
  void goToStep(SuratPermohonanPengesahanFormStep step) {
    currentStep.value = step;
  }
  
  void reset() {
    currentStep.value = SuratPermohonanPengesahanFormStep.lembaga;
  }
  
  bool get canGoNext => currentStep.value.next != null;
  bool get canGoPrevious => currentStep.value.previous != null;
  bool get isLastStep => currentStep.value == SuratPermohonanPengesahanFormStep.tandaTangan;
  bool get isFirstStep => currentStep.value == SuratPermohonanPengesahanFormStep.lembaga;
  
  int get currentStepIndex => currentStep.value.index;
  String get currentStepTitle => currentStep.value.title;
}