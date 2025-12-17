import 'package:gen_surat/core/utils/result.dart';
import 'package:gen_surat/domain/usecases/auth/auth_get_current_user_usecase.dart';
import 'package:gen_surat/domain/usecases/auth/sign_in_with_google_usecase.dart';
import 'package:gen_surat/domain/usecases/auth/sign_out_usecase.dart';
import 'package:gen_surat/domain/usecases/auth/watch_auth_state_usecase.dart';
import 'package:get/get.dart';
import 'package:gen_surat/data/models/user_model.dart';

/// ViewModel untuk menangani autentikasi
class AuthViewModel extends GetxController {
  // Dependencies - injected via constructor
  final SignInWithGoogleUsecase _signInWithGoogleUsecase;
  final SignOutUsecase _signOutUsecase;
  final WatchAuthStateUsecase _watchAuthStateUsecase;
  final AuthGetCurrentUserUsecase _authGetCurrentUserUsecase;

  // Constructor Injection
  AuthViewModel({
    required SignInWithGoogleUsecase signInWithGoogleUsecase,
    required SignOutUsecase signOutUsecase,
    required WatchAuthStateUsecase watchAuthStateUsecase,
    required AuthGetCurrentUserUsecase authGetCurrentUserUsecase,
  }) : _signInWithGoogleUsecase = signInWithGoogleUsecase,
       _signOutUsecase = signOutUsecase,
       _watchAuthStateUsecase = watchAuthStateUsecase,
       _authGetCurrentUserUsecase = authGetCurrentUserUsecase;

  // Observable state
  final Rx<UserModel?> _currentUser = Rx<UserModel?>(null);
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;

  // Getters
  UserModel? get currentUser => _currentUser.value;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  bool get isLoggedIn => _currentUser.value != null;

  @override
  void onInit() {
    super.onInit();
    _initAuthListener();
    _checkCurrentUser();
  }

  /// Initialize auth state listener
  void _initAuthListener() {
    _watchAuthStateUsecase.call().listen((user) {
      _currentUser.value = user;
    });
  }

  /// Check current user saat app dimulai
  void _checkCurrentUser() {
    _currentUser.value = _authGetCurrentUserUsecase.call();
  }

  /// Sign in dengan Google
  Future<bool> signInWithGoogle() async {
    _isLoading.value = true;
    _errorMessage.value = '';

    final result = await _signInWithGoogleUsecase.call();

    _isLoading.value = false;

    switch (result) {
      case Success(data: final user):
        _currentUser.value = user;
        Get.snackbar(
          'Berhasil',
          'Login berhasil! Selamat datang ${user.displayName ?? user.email}',
          snackPosition: SnackPosition.BOTTOM,
        );
        return true;

      case Failure(exception: final e):
        _errorMessage.value = e.message;
        Get.snackbar('Error', e.message, snackPosition: SnackPosition.BOTTOM);
        return false;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    _isLoading.value = true;
    _errorMessage.value = '';

    final result = await _signOutUsecase.call();

    _isLoading.value = false;

    switch (result) {
      case Success():
        _currentUser.value = null;
        Get.snackbar(
          'Berhasil',
          'Logout berhasil',
          snackPosition: SnackPosition.BOTTOM,
        );

      case Failure(exception: final e):
        _errorMessage.value = e.message;
        Get.snackbar('Error', e.message, snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// Clear error message
  void clearError() {
    _errorMessage.value = '';
  }
}
