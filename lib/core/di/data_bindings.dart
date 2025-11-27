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
    // Generated File Service (Hive) - Singleton
    Get.put(
      GeneratedFileService(),
      permanent: true,
    );

    // ========== Local Repositories ==========
    // Generated File Repository
    Get.lazyPut<IGeneratedFileRepository>(
      () => GeneratedFileRepository(Get.find<GeneratedFileService>()),
      fenix: true,
    );

    // ========== Remote Data Sources ==========
    // Dio Client
    Get.lazyPut(
      () => DioClient(),
      fenix: true,
    );

    // ========== Generic Datasource (untuk semua jenis surat) ==========
    Get.lazyPut<ISuratDatasource>(
      () => SuratDatasource(Get.find<DioClient>().dio),
      fenix: true,
    );

    // ========== Generic Repository (untuk semua jenis surat) ==========
    Get.lazyPut<ISuratRepository>(
      () => SuratRepository(Get.find<ISuratDatasource>()),
      fenix: true,
    );
  }
}
