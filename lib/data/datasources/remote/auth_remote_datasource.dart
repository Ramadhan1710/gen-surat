import 'dart:developer';
import 'dart:io';

import 'package:gen_surat/core/services/google_auth_service.dart';
import 'package:gen_surat/core/services/supabase_service.dart';
import 'package:gen_surat/core/utils/result.dart';
import 'package:gen_surat/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

abstract class IAuthRemoteDatasource {
  Future<Result<UserModel>> signInWithGoogle();
  Future<Result<UserModel>> signUpWithEmail({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  });
  Future<Result<UserModel>> signInWithEmail({
    required String email,
    required String password,
  });
  Future<Result<void>> signOut();
  UserModel? getCurrentUser();
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
      final response = await _supabase.supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        return Success(UserModel.fromSupabaseUser(response.user!));
      }

      return const Failure(
        AppAuthException(
          message: 'Login gagal, user tidak ditemukan',
          code: 'user_not_found',
        ),
      );
    } on supabase.AuthException catch (e) {
      log('Auth error: $e');
      return Failure(AppAuthException.fromSupabase(e));
    } on SocketException catch (e) {
      log('Network error: $e');
      return Failure(
        NetworkException(
          message: 'Tidak ada koneksi internet',
          originalError: e,
        ),
      );
    } catch (e) {
      log('Unknown error: $e');
      return Failure(
        UnknownException(
          message: 'Terjadi kesalahan: ${e.toString()}',
          originalError: e,
        ),
      );
    }
  }

  @override
  Future<Result<UserModel>> signInWithGoogle() async {
    try {
      final googleAuth = await _googleAuthService.signIn();

      if (googleAuth == null) {
        return const Failure(
          AppAuthException(
            message: 'Google sign-in dibatalkan',
            code: 'cancelled',
          ),
        );
      }

      if (googleAuth.idToken == null || googleAuth.accessToken == null) {
        return const Failure(
          AppAuthException(
            message: 'Token Google tidak ditemukan',
            code: 'token_not_found',
          ),
        );
      }

      final response = await _supabase.supabaseClient.auth.signInWithIdToken(
        provider: supabase.OAuthProvider.google,
        idToken: googleAuth.idToken!,
        accessToken: googleAuth.accessToken,
      );

      if (response.user != null) {
        return Success(UserModel.fromSupabaseUser(response.user!));
      }

      return const Failure(
        AppAuthException(
          message: 'Login Google gagal',
          code: 'google_sign_in_failed',
        ),
      );
    } on supabase.AuthException catch (e) {
      log('Auth error: $e');
      return Failure(AppAuthException.fromSupabase(e));
    } on SocketException catch (e) {
      log('Network error: $e');
      return Failure(
        NetworkException(
          message: 'Tidak ada koneksi internet',
          originalError: e,
        ),
      );
    } catch (e) {
      log('Unknown error: $e');
      return Failure(
        UnknownException(
          message: 'Terjadi kesalahan: ${e.toString()}',
          originalError: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      if (_googleAuthService.isLoggedIn) {
        await _googleAuthService.signOut();
      }
      await _supabase.supabaseClient.auth.signOut();
      return const Success(null);
    } on supabase.AuthException catch (e) {
      log('Auth error signing out: $e');
      return Failure(AppAuthException.fromSupabase(e));
    } catch (e) {
      log('Error signing out: $e');
      return Failure(
        UnknownException(
          message: 'Gagal logout: ${e.toString()}',
          originalError: e,
        ),
      );
    }
  }

  @override
  Future<Result<UserModel>> signUpWithEmail({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _supabase.supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: data,
      );

      if (response.user != null) {
        return Success(UserModel.fromSupabaseUser(response.user!));
      }

      return const Failure(
        AppAuthException(message: 'Registrasi gagal', code: 'signup_failed'),
      );
    } on supabase.AuthException catch (e) {
      log('Auth error: $e');
      return Failure(AppAuthException.fromSupabase(e));
    } on SocketException catch (e) {
      log('Network error: $e');
      return Failure(
        NetworkException(
          message: 'Tidak ada koneksi internet',
          originalError: e,
        ),
      );
    } catch (e) {
      log('Unknown error: $e');
      return Failure(
        UnknownException(
          message: 'Terjadi kesalahan: ${e.toString()}',
          originalError: e,
        ),
      );
    }
  }

  @override
  UserModel? getCurrentUser() {
    try {
      final user = _supabase.supabaseClient.auth.currentUser;
      if (user != null) {
        return UserModel.fromSupabaseUser(user);
      }
      return null;
    } catch (e) {
      log('Error getting current user: $e');
      return null;
    }
  }

  @override
  Stream<UserModel?> get authStateChanges {
    return _supabase.supabaseClient.auth.onAuthStateChange.map((authState) {
      final user = authState.session?.user;
      if (user != null) {
        return UserModel.fromSupabaseUser(user);
      }
      return null;
    });
  }
}
