import 'package:gen_surat/presentation/viewmodels/theme/theme_viewmodel.dart';
import 'package:get/get.dart';

void initDependencies(){
  Get.put(ThemeViewModel(), permanent: true);
}