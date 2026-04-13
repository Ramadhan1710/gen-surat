import 'package:gen_surat/presentation/viewmodels/surat/bersama/undangan/enum/surat_undangan_bersama_form_step.dart';
import 'package:get/get.dart';

class SuratUndanganBersamaStepNavigationManager {
  final currentStep = Rx<SuratUndanganBersamaFormStep> (
    SuratUndanganBersamaFormStep.pembuka,
  );

  void nextStep(){
    final next = currentStep.value.next;
    if(next != null){
      currentStep.value = next;
    }
  }

  void previousStep(){
    final previous = currentStep.value.previous;
    if(previous != null){
      currentStep.value = previous;
    }
  }

  void goToStep(SuratUndanganBersamaFormStep step){
    currentStep.value = step;
  }

  void reset(){
    currentStep.value = SuratUndanganBersamaFormStep.pembuka;
  }

  bool get canGoNext => currentStep.value.next != null;
  bool get canGoPrevious => currentStep.value.previous != null;
  bool get isLastStep => currentStep.value == SuratUndanganBersamaFormStep.penutup;
  bool get isFirstStep => currentStep.value == SuratUndanganBersamaFormStep.pembuka;

  int get currentStepIndex => currentStep.value.index;
  String get currentStepTitle => currentStep.value.title;
}