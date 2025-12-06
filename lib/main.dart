import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gen_surat/core/di/injections.dart';
import 'package:gen_surat/core/themes/app_theme.dart';
import 'package:gen_surat/data/datasources/local/generated_file_service.dart';
import 'package:gen_surat/presentation/routes/app_routes.dart';
import 'package:gen_surat/presentation/viewmodels/theme/theme_viewmodel.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Initialize dependencies (KECUALI Hive - akan diinit async)
  initDependencies();

  await initializeDateFormatting('id_ID', null);

  // Run app dulu, Hive akan diinit di background
  runApp(const MyApp());

  // Initialize Hive di background setelah app rendered
  _initHiveAsync();
}

/// Initialize Hive di background untuk tidak blocking startup
Future<void> _initHiveAsync() async {
  try {
    final fileService = Get.find<GeneratedFileService>();
    await fileService.init();
  } catch (e) {
    // Log error tapi jangan crash app
    print('Error initializing Hive: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeViewModel>();

    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Smart Suite",
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.currentThemeMode,
        initialRoute: AppRoutes.initialRoute,
        getPages: AppRoutes.routes,
      );
    });
  }
}
