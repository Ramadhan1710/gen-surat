import 'package:gen_surat/presentation/viewmodels/surat/ipnu/berita_acara_rapat_formatur/enum/berita_acara_rapat_formatur_ipnu_form_step.dart';
import 'package:get/get.dart';

class BeritaAcaraRapatFormaturIpnuStepNavigationManager {
  final currentStep = BeritaAcaraRapatFormaturIpnuFormStep.lembaga.obs;

  bool canGoNext() => currentStep.value.next != null;
  bool canGoPrevious() => currentStep.value.previous != null;
  bool isLastStep() =>
      currentStep.value == BeritaAcaraRapatFormaturIpnuFormStep.values.last;

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

  void goToStep(BeritaAcaraRapatFormaturIpnuFormStep step) {
    currentStep.value = step;
  }

  void reset() {
    currentStep.value = BeritaAcaraRapatFormaturIpnuFormStep.lembaga;
  }
}
