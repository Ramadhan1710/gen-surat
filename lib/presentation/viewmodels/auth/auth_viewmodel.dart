import 'dart:developer';

import 'package:gen_surat/core/utils/result.dart';
import 'package:gen_surat/data/models/profile_model.dart';
import 'package:gen_surat/data/models/user_model.dart';
import 'package:gen_surat/domain/usecases/auth/auth_get_current_user_usecase.dart';
import 'package:gen_surat/domain/usecases/auth/sign_in_with_email_usecase.dart';
import 'package:gen_surat/domain/usecases/auth/sign_in_with_google_usecase.dart';
import 'package:gen_surat/domain/usecases/auth/sign_out_usecase.dart';
import 'package:gen_surat/domain/usecases/auth/sign_up_with_email_usecase.dart';
import 'package:gen_surat/domain/usecases/auth/watch_auth_state_usecase.dart';
import 'package:gen_surat/domain/usecases/profile/get_profile_usecase.dart';
import 'package:gen_surat/presentation/routes/route_names.dart';
import 'package:gen_surat/presentation/viewmodels/base/base_viewmodel.dart';
import 'package:get/get.dart';

class AuthViewModel extends BaseViewModel with FullFeaturedMixin {
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

  final Rx<ProfileModel?> _profile = Rx<ProfileModel?>(null);

  UserModel? get currentUser => _currentUser.value;
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
    final result = await _getProfileUseCase.call(userId);

    switch (result) {
      case Success(data: final profile):
        _profile.value = profile;

      case Failure(exception: final e):
        setError(e.message);
    }
  }

  Future<bool> signInWithGoogle() async {
    final result = await executeAsync<bool>(
      operation: () async {
        final authResult = await _signInWithGoogleUsecase.call();
        return await _handleAuthSuccess(authResult);
      },
      onSuccess: () {
        final user = _currentUser.value;
        showSuccess(
          'Login berhasil! Selamat datang ${user?.displayName ?? user?.email}',
        );
        navigateBasedOnRole();
      },
      onError: (e) => 'Login gagal: $e',
    );

    return result ?? false;
  }

  Future<bool> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final result = await executeAsync<bool>(
      operation: () async {
        final authResult = await _signInWithEmailUsecase.call(
          email: email,
          password: password,
        );
        return await _handleAuthSuccess(authResult);
      },
      onSuccess: () {
        final user = _currentUser.value;
        showSuccess(
          'Login berhasil! Selamat datang ${user?.displayName ?? user?.email}',
        );
        navigateBasedOnRole();
      },
      onError: (e) => 'Login gagal: $e',
    );

    return result ?? false;
  }

  Future<bool> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    log('Signing up with email: $email, displayName: $displayName');

    final result = await executeAsync<bool>(
      operation: () async {
        final cleanEmail = email.trim();
        final cleanPassword = password.trim();
        final cleanDisplayName = displayName.trim();

        final authResult = await _signUpWithEmailUsecase.call(
          email: cleanEmail,
          password: cleanPassword,
          data: {'full_name': cleanDisplayName},
        );

        return await _handleAuthSuccess(authResult);
      },
      onSuccess: () {
        final user = _currentUser.value;
        showSuccess(
          'Pendaftaran berhasil! Selamat datang ${user?.displayName ?? user?.email}',
        );
        navigateBasedOnRole();
      },
      onError: (e) => 'Pendaftaran gagal: $e',
    );

    return result ?? false;
  }

  Future<void> signOut() async {
    await executeAsync(
      operation: () async {
        final result = await _signOutUsecase.call();

        if (result is Success) {
          _currentUser.value = null;
          _profile.value = null;
        } else if (result is Failure) {
          throw Exception(result.exception.message);
        }
      },
      onSuccess: () => showSuccess('Logout berhasil'),
      onError: (e) => 'Logout gagal: $e',
    );
  }

  Future<bool> _handleAuthSuccess(Result<UserModel> result) async {
    switch (result) {
      case Success(data: final user):
        _currentUser.value = user;
        await fetchProfile(user.id);
        return true;

      case Failure(exception: final e):
        throw Exception(e.message);
    }
  }

  // navigate to other pages based on role
  void navigateBasedOnRole() {
    final role = userRole;
    if (role == 'admin') {
      Get.offAllNamed(RouteNames.adminHome);
    } else if (role == 'anggota') {
      Get.offAllNamed(RouteNames.anggotaHome);
    } else if (role == 'pengurus') {
      Get.offAllNamed(RouteNames.pengurusHome);
    } else if (role == 'ranting') {
      Get.offAllNamed(RouteNames.rantingHome);
    } else if (role == 'sekretaris') {
      Get.offAllNamed(RouteNames.sekretarisHome);
    } else {
      Get.offAllNamed(RouteNames.home);
    }
  }
}
