import 'package:gen_surat/presentation/viewmodels/surat/bersama/dispensasi/enum/surat_dispensasi_bersama_form_step.dart';
import 'package:get/get.dart';

class SuratDispensasiBersamaStepNavigationManager {
  final currentStep = Rx<SuratDispensasiBersamaFormStep> (
    SuratDispensasiBersamaFormStep.pembuka,
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

  void goToStep(SuratDispensasiBersamaFormStep step){
    currentStep.value = step;
  }

  void reset(){
    currentStep.value = SuratDispensasiBersamaFormStep.pembuka;
  }

  bool get canGoNext => currentStep.value.next != null;
  bool get canGoPrevious => currentStep.value.previous != null;
  bool get isLastStep => currentStep.value == SuratDispensasiBersamaFormStep.penutup;
  bool get isFirstStep => currentStep.value == SuratDispensasiBersamaFormStep.pembuka;

  int get currentStepIndex => currentStep.value.index;
  String get currentStepTitle => currentStep.value.title;
}