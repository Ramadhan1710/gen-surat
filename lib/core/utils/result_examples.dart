// ============================================================================
// CONTOH PENGGUNAAN RESULT PATTERN DI SETIAP LAYER
// ============================================================================
//
// File ini berisi contoh-contoh penggunaan Result Pattern.
// JANGAN IMPORT FILE INI - ini hanya untuk referensi/dokumentasi.
//
// ============================================================================

// ============================================================================
// 1. DATASOURCE LAYER
// ============================================================================

/*
import 'dart:developer';
import 'dart:io';
import 'package:gen_surat/core/utils/result.dart';
import 'package:gen_surat/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class IAuthRemoteDatasource {
  Future<Result<UserModel>> signInWithGoogle();
  Future<Result<UserModel>> signInWithEmail({
    required String email,
    required String password,
  });
  Future<Result<UserModel>> signUpWithEmail({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  });
  Future<Result<void>> signOut();
  Result<UserModel?> getCurrentUser();  // Sync, jadi langsung Result
  Stream<UserModel?> get authStateChanges;
}

class AuthRemoteDatasource implements IAuthRemoteDatasource {
  final SupabaseService _supabase;
  final GoogleAuthService _googleAuthService;

  AuthRemoteDatasource(this._supabase, this._googleAuthService);

  @override
  Future<Result<UserModel>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.supabaseClient.auth
          .signInWithPassword(email: email, password: password);

      if (response.user != null) {
        return Success(UserModel.fromSupabaseUser(response.user!));
      }
      
      return const Failure(AuthException(
        message: 'Login gagal, user tidak ditemukan',
        code: 'user_not_found',
      ));
    } on AuthException catch (e) {
      log('Auth error: $e');
      return Failure(AuthException.fromSupabase(e));
    } on SocketException catch (e) {
      log('Network error: $e');
      return Failure(NetworkException(
        message: 'Tidak ada koneksi internet',
        originalError: e,
      ));
    } catch (e) {
      log('Unknown error: $e');
      return Failure(UnknownException(
        message: 'Terjadi kesalahan: ${e.toString()}',
        originalError: e,
      ));
    }
  }

  @override
  Future<Result<UserModel>> signInWithGoogle() async {
    try {
      final googleAuth = await _googleAuthService.signIn();

      if (googleAuth == null) {
        return const Failure(AuthException(
          message: 'Google sign-in dibatalkan',
          code: 'cancelled',
        ));
      }

      if (googleAuth.idToken == null || googleAuth.accessToken == null) {
        return const Failure(AuthException(
          message: 'Token Google tidak ditemukan',
          code: 'token_not_found',
        ));
      }

      final response = await _supabase.supabaseClient.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: googleAuth.idToken!,
        accessToken: googleAuth.accessToken,
      );

      if (response.user != null) {
        return Success(UserModel.fromSupabaseUser(response.user!));
      }

      return const Failure(AuthException(
        message: 'Login Google gagal',
        code: 'google_sign_in_failed',
      ));
    } on AuthException catch (e) {
      log('Auth error: $e');
      return Failure(AuthException.fromSupabase(e));
    } on SocketException catch (e) {
      log('Network error: $e');
      return Failure(NetworkException(
        message: 'Tidak ada koneksi internet',
        originalError: e,
      ));
    } catch (e) {
      log('Unknown error: $e');
      return Failure(UnknownException(
        message: 'Terjadi kesalahan: ${e.toString()}',
        originalError: e,
      ));
    }
  }

  @override
  Result<UserModel?> getCurrentUser() {
    try {
      final user = _supabase.supabaseClient.auth.currentUser;
      if (user != null) {
        return Success(UserModel.fromSupabaseUser(user));
      }
      return const Success(null);  // Tidak ada user bukan error
    } catch (e) {
      log('Error getting current user: $e');
      return Failure(UnknownException(
        message: 'Gagal mengambil data user',
        originalError: e,
      ));
    }
  }
}
*/

// ============================================================================
// 2. REPOSITORY LAYER
// ============================================================================

/*
import 'package:gen_surat/core/utils/result.dart';
import 'package:gen_surat/data/models/user_model.dart';

abstract class IAuthRepository {
  Future<Result<UserModel>> signInWithGoogle();
  Future<Result<UserModel>> signInWithEmail({
    required String email,
    required String password,
  });
  Future<Result<UserModel>> signUpWithEmail({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  });
  Future<Result<void>> signOut();
  Result<UserModel?> getCurrentUser();
  Stream<UserModel?> get authStateChanges;
}

class AuthRepository implements IAuthRepository {
  final IAuthRemoteDatasource _remoteDatasource;

  AuthRepository(this._remoteDatasource);

  @override
  Future<Result<UserModel>> signInWithEmail({
    required String email,
    required String password,
  }) {
    // Langsung forward ke datasource
    return _remoteDatasource.signInWithEmail(
      email: email,
      password: password,
    );
  }

  @override
  Future<Result<UserModel>> signInWithGoogle() {
    return _remoteDatasource.signInWithGoogle();
  }

  @override
  Result<UserModel?> getCurrentUser() {
    return _remoteDatasource.getCurrentUser();
  }
}
*/

// ============================================================================
// 3. USECASE LAYER
// ============================================================================

/*
import 'package:gen_surat/core/utils/result.dart';
import 'package:gen_surat/data/models/user_model.dart';

class SignInWithGoogleUsecase {
  final IAuthRepository _authRepository;

  SignInWithGoogleUsecase(this._authRepository);

  Future<Result<UserModel>> call() {
    return _authRepository.signInWithGoogle();
  }
}

class SignInWithEmailUsecase {
  final IAuthRepository _authRepository;

  SignInWithEmailUsecase(this._authRepository);

  Future<Result<UserModel>> call({
    required String email,
    required String password,
  }) {
    // Bisa tambah validasi di sini
    if (email.isEmpty) {
      return Future.value(const Failure(ValidationException(
        message: 'Email tidak boleh kosong',
        code: 'email_empty',
      )));
    }
    
    if (password.length < 6) {
      return Future.value(const Failure(ValidationException(
        message: 'Password minimal 6 karakter',
        code: 'password_too_short',
      )));
    }

    return _authRepository.signInWithEmail(
      email: email,
      password: password,
    );
  }
}

class GetCurrentUserUsecase {
  final IAuthRepository _authRepository;

  GetCurrentUserUsecase(this._authRepository);

  Result<UserModel?> call() {
    return _authRepository.getCurrentUser();
  }
}
*/

// ============================================================================
// 4. VIEWMODEL LAYER
// ============================================================================

/*
import 'package:gen_surat/core/utils/result.dart';
import 'package:get/get.dart';

class AuthViewModel extends GetxController {
  final SignInWithGoogleUsecase _signInWithGoogleUsecase;
  final SignInWithEmailUsecase _signInWithEmailUsecase;
  final GetCurrentUserUsecase _getCurrentUserUsecase;

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
    _checkCurrentUser();
  }

  void _checkCurrentUser() {
    final result = _getCurrentUserUsecase.call();
    
    // Cara 1: Menggunakan switch
    switch (result) {
      case Success(data: final user):
        _currentUser.value = user;
      case Failure(exception: final e):
        _errorMessage.value = e.message;
    }
    
    // Cara 2: Menggunakan when (lebih ringkas)
    result.when(
      success: (user) => _currentUser.value = user,
      failure: (e) => _errorMessage.value = e.message,
    );
    
    // Cara 3: Menggunakan dataOrNull (paling ringkas)
    _currentUser.value = result.dataOrNull;
  }

  Future<bool> signInWithGoogle() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final result = await _signInWithGoogleUsecase.call();

      // Menggunakan switch pattern matching
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
          Get.snackbar(
            'Error',
            e.message,
            snackPosition: SnackPosition.BOTTOM,
          );
          return false;
      }
    } finally {
      _isLoading.value = false;
    }
  }

  Future<bool> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final result = await _signInWithEmailUsecase.call(
        email: email,
        password: password,
      );

      // Menggunakan when extension
      return result.when(
        success: (user) {
          _currentUser.value = user;
          Get.snackbar(
            'Berhasil',
            'Login berhasil!',
            snackPosition: SnackPosition.BOTTOM,
          );
          return true;
        },
        failure: (e) {
          _errorMessage.value = e.message;
          
          // Handle specific error types
          if (e is ValidationException) {
            Get.snackbar(
              'Validasi Gagal',
              e.message,
              snackPosition: SnackPosition.BOTTOM,
            );
          } else if (e is NetworkException) {
            Get.snackbar(
              'Koneksi Error',
              e.message,
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            Get.snackbar(
              'Error',
              e.message,
              snackPosition: SnackPosition.BOTTOM,
            );
          }
          return false;
        },
      );
    } finally {
      _isLoading.value = false;
    }
  }
}
*/
