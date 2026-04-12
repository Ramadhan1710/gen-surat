import 'package:gen_surat/presentation/viewmodels/surat/bersama/pemberitahuan/enum/surat_pemberitahuan_bersama_form_step.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/permohonan_konsumsi/enum/surat_permohonan_konsumsi_bersama_form_step.dart';
import 'package:get/get.dart';

class SuratPermohonanKonsumsiBersamaStepNavigationManager {
  final currentStep = Rx<SuratPermohonanKonsumsiBersamaFormStep> (
    SuratPermohonanKonsumsiBersamaFormStep.pembuka,
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

  void goToStep(SuratPermohonanKonsumsiBersamaFormStep step){
    currentStep.value = step;
  }

  void reset(){
    currentStep.value = SuratPermohonanKonsumsiBersamaFormStep.pembuka;
  }

  bool get canGoNext => currentStep.value.next != null;
  bool get canGoPrevious => currentStep.value.previous != null;
  bool get isLastStep => currentStep.value == SuratPermohonanKonsumsiBersamaFormStep.penutup;
  bool get isFirstStep => currentStep.value == SuratPermohonanKonsumsiBersamaFormStep.pembuka;

  int get currentStepIndex => currentStep.value.index;
  String get currentStepTitle => currentStep.value.title;
}