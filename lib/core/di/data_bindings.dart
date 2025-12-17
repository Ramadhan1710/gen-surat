import 'package:gen_surat/core/services/google_auth_service.dart';
import 'package:gen_surat/core/services/supabase_service.dart';
import 'package:gen_surat/data/datasources/remote/auth_remote_datasource.dart';
import 'package:gen_surat/data/repositories/auth_repository.dart';
import 'package:gen_surat/domain/repositories/i_auth_repository.dart';
import 'package:get/get.dart';

import 'package:gen_surat/data/datasources/local/generated_file_service.dart';
import 'package:gen_surat/data/datasources/remote/dio_client.dart';
import 'package:gen_surat/data/datasources/remote/surat_datasource.dart';
import 'package:gen_surat/data/repositories/generated_file_repository.dart';
import 'package:gen_surat/data/repositories/surat_repository.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';
import 'package:gen_surat/domain/repositories/i_surat_repository.dart';
import 'package:gen_surat/core/services/file_download_service.dart';
import 'package:gen_surat/core/services/notification_service.dart';
import 'package:gen_surat/core/services/file_operation_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DataBindings extends Bindings {
  @override
  void dependencies() {
    // ========== Core Services ==========
    // Notification Service - permanent
    Get.put<NotificationService>(GetXNotificationService(), permanent: true);

    // File Operation Service - permanent
    Get.put(FileOperationService(), permanent: true);

    // File Download Service - permanent (untuk WebView downloads)
    Get.put(FileDownloadService(), permanent: true);

    // ========== Local Data Sources ==========
    // Generated File Service (Hive) - Singleton permanent
    Get.put(GeneratedFileService(), permanent: true);

    Get.put(SupabaseService(Supabase.instance.client), permanent: true);

    Get.put(GoogleAuthService(), permanent: true);

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

    // Auth Remote Datasource
    Get.put<IAuthRemoteDatasource>(
      AuthRemoteDatasource(
        Get.find<SupabaseService>(),
        Get.find<GoogleAuthService>(),
      ),
      permanent: true, // Persistent, tidak di-dispose
    );

    // Auth Repository
    Get.put<IAuthRepository>(
      AuthRepository(Get.find<IAuthRemoteDatasource>()),
      permanent: true, // Persistent, tidak di-dispose
    );
  }
}
