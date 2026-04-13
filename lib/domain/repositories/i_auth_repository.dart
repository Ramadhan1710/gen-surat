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
  UserModel? getCurrentUser();
  Stream<UserModel?> get authStateChanges;
}
