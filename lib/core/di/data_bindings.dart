import 'package:get/get.dart';

import '../../data/datasources/local/generated_file_service.dart';
import '../../data/datasources/remote/dio_client.dart';
import '../../data/datasources/remote/surat_datasource.dart';
import '../../data/repositories/generated_file_repository.dart';
import '../../data/repositories/surat_repository.dart';
import '../../domain/repositories/i_generated_file_repository.dart';
import '../../domain/repositories/i_surat_repository.dart';

class DataBindings extends Bindings {
  @override
  void dependencies() {
    // ========== Local Data Sources ==========
    // Generated File Service (Hive) - Singleton permanent
    Get.put(
      GeneratedFileService(),
      permanent: true,
    );

    // ========== Local Repositories ==========
    // Generated File Repository - perlu persistent untuk route bindings
    Get.put<IGeneratedFileRepository>(
      GeneratedFileRepository(Get.find<GeneratedFileService>()),
      permanent: true, // Persistent, tidak di-dispose
    );

    // ========== Remote Data Sources ==========
    // Dio Client - perlu persistent untuk semua request
    Get.put(
      DioClient(),
      permanent: true, // Persistent, tidak di-dispose
    );

    // ========== Generic Datasource (untuk semua jenis surat) ==========
    Get.put<ISuratDatasource>(
      SuratDatasource(Get.find<DioClient>().dio),
      permanent: true, // Persistent, tidak di-dispose
    );

    // ========== Generic Repository (untuk semua jenis surat) ==========
    Get.put<ISuratRepository>(
      SuratRepository(Get.find<ISuratDatasource>()),
      permanent: true, // Persistent, tidak di-dispose
    );
  }
}
