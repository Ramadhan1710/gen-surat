import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_rapat_formatur/enum/berita_acara_rapat_formatur_form_step.dart';
import 'package:get/get.dart';

class BeritaAcaraRapatFormaturStepNavigationManager {
  final currentStep = BeritaAcaraRapatFormaturFormStep.lembaga.obs;

  bool canGoNext() => currentStep.value.next != null;
  bool canGoPrevious() => currentStep.value.previous != null;
  bool isLastStep() =>
      currentStep.value == BeritaAcaraRapatFormaturFormStep.values.last;

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

  void goToStep(BeritaAcaraRapatFormaturFormStep step) {
    currentStep.value = step;
  }

  void reset() {
    currentStep.value = BeritaAcaraRapatFormaturFormStep.lembaga;
  }
}
