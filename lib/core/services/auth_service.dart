import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';

class AuthService {
  final SupabaseClient _supabase = SupabaseConfig.client;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId:
        '1079132192898-nducmrgg7eou0n420fjcqkrn4cl1mcqe.apps.googleusercontent.com',
  );

  User? get currentUser => _supabase.auth.currentUser;

  bool get isLoggedIn => currentUser != null;

  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  Future<AuthResponse> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception('Google Sign-In dibatalkan');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final String? accessToken = googleAuth.accessToken;
      final String? idToken = googleAuth.idToken;

      if (accessToken == null || idToken == null) {
        await googleUser.clearAuthCache();
        final newAuth = await googleUser.authentication;
        final newAccessToken = newAuth.accessToken;
        final newIdToken = newAuth.idToken;

        if (newAccessToken == null || newIdToken == null) {
          throw Exception(
            'Gagal mendapatkan Google credentials. '
            'Pastikan Web Client ID sudah benar dan OAuth Consent Screen sudah dikonfigurasi.',
          );
        }

        final AuthResponse response = await _supabase.auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: newIdToken,
          accessToken: newAccessToken,
        );

        return response;
      }

      final AuthResponse response = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      return response;
    } catch (e) {
      await _googleSignIn.signOut();
      print('Error sign in: $e');
      rethrow;
    }
  }

  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) async {
    try{
      final AuthResponse response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: data,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();

      await _supabase.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  // Future<Map<String, dynamic>?> getUserProfile() async {
  //   try {
  //     if (!isLoggedIn) return null;

  //     final userId = currentUser!.id;

  //     final response =
  //         await _supabase
  //             .from('profiles')
  //             .select()
  //             .eq('id', userId)
  //             .maybeSingle();

  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<void> updateUserProfile(Map<String, dynamic> data) async {
  //   try {
  //     if (!isLoggedIn) throw Exception('User belum login');

  //     final userId = currentUser!.id;

  //     await _supabase.from('profiles').upsert({
  //       'id': userId,
  //       ...data,
  //       'updated_at': DateTime.now().toIso8601String(),
  //     });
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<void> deleteAccount() async {
  //   try {
  //     if (!isLoggedIn) throw Exception('User belum login');

  //     await _googleSignIn.signOut();

  //     await _supabase.rpc('delete_user');

  //     await _supabase.auth.signOut();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
