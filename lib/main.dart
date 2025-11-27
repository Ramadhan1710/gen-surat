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

  // Initialize dependencies
  initDependencies();

  await initializeDateFormatting('id_ID', null);

  // Initialize Hive
  final fileService = Get.find<GeneratedFileService>();
  await fileService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeViewModel>();

    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Gen Surat",
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.currentThemeMode,
        initialRoute: AppRoutes.initialRoute,
        getPages: AppRoutes.routes,
      );
    });
  }
}
