import 'package:gen_surat/domain/usecases/auth/auth_get_current_user_usecase.dart';
import 'package:gen_surat/domain/usecases/auth/sign_in_with_google_usecase.dart';
import 'package:gen_surat/domain/usecases/auth/sign_out_usecase.dart';
import 'package:gen_surat/domain/usecases/auth/watch_auth_state_usecase.dart';
import 'package:gen_surat/presentation/viewmodels/auth/auth_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/theme/theme_viewmodel.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Theme ViewModel
    Get.put(ThemeViewModel(), permanent: true);

    // Auth ViewModel dengan Constructor Injection
    Get.put(
      AuthViewModel(
        signInWithGoogleUsecase: Get.find<SignInWithGoogleUsecase>(),
        signOutUsecase: Get.find<SignOutUsecase>(),
        watchAuthStateUsecase: Get.find<WatchAuthStateUsecase>(),
        authGetCurrentUserUsecase: Get.find<AuthGetCurrentUserUsecase>(),
      ),
      permanent: true,
    );
  }
}
