import 'dart:developer';

import 'package:gen_surat/core/utils/result.dart';
import 'package:gen_surat/data/models/profile_model.dart';
import 'package:gen_surat/domain/usecases/auth/auth_get_current_user_usecase.dart';
import 'package:gen_surat/domain/usecases/auth/sign_in_with_email_usecase.dart';
import 'package:gen_surat/domain/usecases/auth/sign_in_with_google_usecase.dart';
import 'package:gen_surat/domain/usecases/auth/sign_out_usecase.dart';
import 'package:gen_surat/domain/usecases/auth/sign_up_with_email_usecase.dart';
import 'package:gen_surat/domain/usecases/auth/watch_auth_state_usecase.dart';
import 'package:gen_surat/domain/usecases/profile/get_profile_usecase.dart';
import 'package:get/get.dart';
import 'package:gen_surat/data/models/user_model.dart';

class AuthViewModel extends GetxController {
  final SignInWithGoogleUsecase _signInWithGoogleUsecase;
  final SignOutUsecase _signOutUsecase;
  final SignInWithEmailUsecase _signInWithEmailUsecase;
  final SignUpWithEmailUsecase _signUpWithEmailUsecase;
  final GetProfileUseCase _getProfileUseCase;
  final WatchAuthStateUsecase _watchAuthStateUsecase;
  final AuthGetCurrentUserUsecase _authGetCurrentUserUsecase;

  AuthViewModel({
    required SignInWithGoogleUsecase signInWithGoogleUsecase,
    required SignOutUsecase signOutUsecase,
    required WatchAuthStateUsecase watchAuthStateUsecase,
    required AuthGetCurrentUserUsecase authGetCurrentUserUsecase,
    required SignInWithEmailUsecase signInWithEmailUsecase,
    required SignUpWithEmailUsecase signUpWithEmailUsecase,
    required GetProfileUseCase getProfileUseCase,
  }) : _signInWithGoogleUsecase = signInWithGoogleUsecase,
       _signOutUsecase = signOutUsecase,
       _watchAuthStateUsecase = watchAuthStateUsecase,
       _authGetCurrentUserUsecase = authGetCurrentUserUsecase,
       _signInWithEmailUsecase = signInWithEmailUsecase,
       _signUpWithEmailUsecase = signUpWithEmailUsecase,
       _getProfileUseCase = getProfileUseCase;

  final Rx<UserModel?> _currentUser = Rx<UserModel?>(null);
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final Rx<ProfileModel?> _profile = Rx<ProfileModel?>(null);

  UserModel? get currentUser => _currentUser.value;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  bool get isLoggedIn => _currentUser.value != null;
  ProfileModel? get profile => _profile.value;
  String get userRole => _profile.value?.role ?? 'guest';

  @override
  void onInit() {
    super.onInit();
    _initAuthListener();
    _checkCurrentUser();
  }

  void _initAuthListener() {
    _watchAuthStateUsecase.call().listen((user) {
      _currentUser.value = user;
    });
  }

  void _checkCurrentUser() async {
    _currentUser.value = _authGetCurrentUserUsecase.call();

    if (_currentUser.value != null) {
      await fetchProfile(_currentUser.value!.id);
      log('Current user found: $userRole');
    }
  }

  Future<void> fetchProfile(String userId) async {
    final result = await _getProfileUseCase.call( userId);

    switch (result) {
      case Success(data: final profile):
        _profile.value = profile;
      case Failure(exception: final e):
        _errorMessage.value = e.message;
    }
  }

  Future<bool> signInWithGoogle() async {
    _isLoading.value = true;
    _errorMessage.value = '';

    final result = await _signInWithGoogleUsecase.call();

    _isLoading.value = false;

    switch (result) {
      case Success(data: final user):
        _currentUser.value = user;

        await fetchProfile(user.id);

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

  Future<bool> signInWithEmail({
    required String email,
    required String password
  }) async {
    _isLoading.value = true;
    _errorMessage.value = '';

    // initialisasi result
    final result = await _signInWithEmailUsecase.call(
      email: email,
      password: password,
    );

    // set loading to false
    _isLoading.value = false;

    // handle result
    switch (result) {
      case Success(data: final user):
        _currentUser.value = user;

        await fetchProfile(user.id);

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

  // method sign up with email
  Future<bool> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    _isLoading.value = true;
    _errorMessage.value = '';

    log('Signing up with email: $email, displayName: $displayName');

    // trim inputs
    email = email.trim();
    password = password.trim();
    displayName = displayName.trim();

    final result = await _signUpWithEmailUsecase.call(
      email: email,
      password: password,
      data: {
        'full_name': displayName,
      },
    );

    _isLoading.value = false;

    switch (result) {
      case Success(data: final user):
        _currentUser.value = user;

        await fetchProfile(user.id);

        Get.snackbar(
          'Berhasil',
          'Pendaftaran berhasil! Selamat datang ${user.displayName ?? user.email}',
          snackPosition: SnackPosition.BOTTOM,
        );
        return true;

      case Failure(exception: final e):
        _errorMessage.value = e.message;
        Get.snackbar('Error', e.message, snackPosition: SnackPosition.BOTTOM);
        return false;
    }
  }

  void clearError() {
    _errorMessage.value = '';
  }
}
