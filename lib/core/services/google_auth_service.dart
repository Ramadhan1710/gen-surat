import 'package:gen_surat/core/config/env_config.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: EnvConfig.googleClientId,

    scopes: [
      'email',
      'profile',
      'https://www.googleapis.com/auth/userinfo.email',
    ],
  );

  GoogleSignIn get client => _googleSignIn;

  Future<GoogleSignInAuthentication?> signIn() async {
    await _googleSignIn.signOut();

    final googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      return null;
    }

    return googleUser.authentication;
  }

  bool get isLoggedIn => _googleSignIn.currentUser != null;

  Future<void> signOut() => _googleSignIn.signOut();
}
