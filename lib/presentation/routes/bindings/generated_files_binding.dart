import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/presentation/viewmodels/generated_files_viewmodel.dart';
import 'package:get/get.dart';

/// Binding untuk Generated Files Page
/// Auto-dispose saat page ditutup
class GeneratedFilesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeneratedFilesViewModel>(
      () => GeneratedFilesViewModel(Get.find<IGeneratedFileRepository>()),
    );
  }
}
