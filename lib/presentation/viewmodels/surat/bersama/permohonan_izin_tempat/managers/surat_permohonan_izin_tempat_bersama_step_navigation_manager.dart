import 'package:gen_surat/presentation/viewmodels/surat/bersama/permohonan_izin_tempat/enum/surat_permohonan_izin_tempat_bersama_form_step.dart';
import 'package:gen_surat/presentation/viewmodels/surat/bersama/undangan/enum/surat_undangan_bersama_form_step.dart';
import 'package:get/get.dart';

class SuratPermohonanIzinTempatBersamaStepNavigationManager {
  final currentStep = Rx<SuratPermohonanIzinTempatBersamaFormStep> (
    SuratPermohonanIzinTempatBersamaFormStep.pembuka,
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

  void goToStep(SuratPermohonanIzinTempatBersamaFormStep step){
    currentStep.value = step;
  }

  void reset(){
    currentStep.value = SuratPermohonanIzinTempatBersamaFormStep.pembuka;
  }

  bool get canGoNext => currentStep.value.next != null;
  bool get canGoPrevious => currentStep.value.previous != null;
  bool get isLastStep => currentStep.value == SuratPermohonanIzinTempatBersamaFormStep.penutup;
  bool get isFirstStep => currentStep.value == SuratPermohonanIzinTempatBersamaFormStep.pembuka;

  int get currentStepIndex => currentStep.value.index;
  String get currentStepTitle => currentStep.value.title;
}