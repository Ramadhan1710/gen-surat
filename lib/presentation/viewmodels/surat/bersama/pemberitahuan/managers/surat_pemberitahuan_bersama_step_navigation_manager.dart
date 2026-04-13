import 'package:gen_surat/presentation/viewmodels/surat/bersama/pemberitahuan/enum/surat_pemberitahuan_bersama_form_step.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/undangan/enum/surat_undangan_bersama_form_step.dart';
import 'package:get/get.dart';

class SuratPemberitahuanBersamaStepNavigationManager {
  final currentStep = Rx<SuratPemberitahuanBersamaFormStep> (
    SuratPemberitahuanBersamaFormStep.pembuka,
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

  void goToStep(SuratPemberitahuanBersamaFormStep step){
    currentStep.value = step;
  }

  void reset(){
    currentStep.value = SuratPemberitahuanBersamaFormStep.pembuka;
  }

  bool get canGoNext => currentStep.value.next != null;
  bool get canGoPrevious => currentStep.value.previous != null;
  bool get isLastStep => currentStep.value == SuratPemberitahuanBersamaFormStep.penutup;
  bool get isFirstStep => currentStep.value == SuratPemberitahuanBersamaFormStep.pembuka;

  int get currentStepIndex => currentStep.value.index;
  String get currentStepTitle => currentStep.value.title;
}