import 'package:gen_surat/presentation/viewmodels/surat/bersama/permohonan_pemateri/enum/surat_permohonan_pemateri_bersama_form_step.dart';
import 'package:get/get.dart';

class SuratPermohonanPemateriBersamaStepNavigationManager {
  final currentStep = Rx<SuratPermohonanPemateriBersamaFormStep> (
    SuratPermohonanPemateriBersamaFormStep.pembuka,
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

  void goToStep(SuratPermohonanPemateriBersamaFormStep step){
    currentStep.value = step;
  }

  void reset(){
    currentStep.value = SuratPermohonanPemateriBersamaFormStep.pembuka;
  }

  bool get canGoNext => currentStep.value.next != null;
  bool get canGoPrevious => currentStep.value.previous != null;
  bool get isLastStep => currentStep.value == SuratPermohonanPemateriBersamaFormStep.penutup;
  bool get isFirstStep => currentStep.value == SuratPermohonanPemateriBersamaFormStep.pembuka;

  int get currentStepIndex => currentStep.value.index;
  String get currentStepTitle => currentStep.value.title;
}