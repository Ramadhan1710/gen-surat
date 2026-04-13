import 'package:gen_surat/presentation/viewmodels/surat/bersama/permohonan_peminjaman_alat/enum/surat_permohonan_peminjaman_alat_bersama_form_step.dart';
import 'package:get/get.dart';

class SuratPermohonanPeminjamanAlatBersamaStepNavigationManager {
  final currentStep = Rx<SuratPermohonanPeminjamanAlatBersamaFormStep> (
    SuratPermohonanPeminjamanAlatBersamaFormStep.pembuka,
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

  void goToStep(SuratPermohonanPeminjamanAlatBersamaFormStep step){
    currentStep.value = step;
  }

  void reset(){
    currentStep.value = SuratPermohonanPeminjamanAlatBersamaFormStep.pembuka;
  }

  bool get canGoNext => currentStep.value.next != null;
  bool get canGoPrevious => currentStep.value.previous != null;
  bool get isLastStep => currentStep.value == SuratPermohonanPeminjamanAlatBersamaFormStep.penutup;
  bool get isFirstStep => currentStep.value == SuratPermohonanPeminjamanAlatBersamaFormStep.pembuka;

  int get currentStepIndex => currentStep.value.index;
  String get currentStepTitle => currentStep.value.title;
}