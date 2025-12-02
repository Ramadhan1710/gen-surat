import 'package:get/get.dart';

import '../enum/berita_acara_pemilihan_ketua_form_step.dart';

/// Manager untuk navigasi step pada form Berita Acara Pemilihan Ketua
/// Mengelola perpindahan antar step dengan validasi
class BeritaAcaraPemilihanKetuaStepNavigationManager {
  final currentStep = Rx<BeritaAcaraPemilihanKetuaFormStep>(
    BeritaAcaraPemilihanKetuaFormStep.lembaga,
  );

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

  void goToStep(BeritaAcaraPemilihanKetuaFormStep step) {
    currentStep.value = step;
  }

  void reset() {
    currentStep.value = BeritaAcaraPemilihanKetuaFormStep.lembaga;
  }

  bool get canGoNext => currentStep.value.next != null;
  bool get canGoPrevious => currentStep.value.previous != null;
  bool get isLastStep =>
      currentStep.value == BeritaAcaraPemilihanKetuaFormStep.tandaTangan;
  bool get isFirstStep =>
      currentStep.value == BeritaAcaraPemilihanKetuaFormStep.lembaga;

  int get currentStepIndex => currentStep.value.index;
  String get currentStepTitle => currentStep.value.title;
}
