import 'package:gen_surat/core/utils/result.dart';
import 'package:gen_surat/data/datasources/remote/auth_remote_datasource.dart';
import 'package:gen_surat/data/models/user_model.dart';
import 'package:gen_surat/domain/repositories/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  final IAuthRemoteDatasource _remoteDatasource;

  AuthRepository(this._remoteDatasource);

  @override
  Future<Result<UserModel>> signInWithEmail({
    required String email,
    required String password,
  }) {
    return _remoteDatasource.signInWithEmail(email: email, password: password);
  }

  @override
  Future<Result<UserModel>> signInWithGoogle() {
    return _remoteDatasource.signInWithGoogle();
  }

  @override
  Future<Result<void>> signOut() {
    return _remoteDatasource.signOut();
  }

  @override
  Future<Result<UserModel>> signUpWithEmail({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) {
    return _remoteDatasource.signUpWithEmail(
      email: email,
      password: password,
      data: data,
    );
  }

  @override
  Stream<UserModel?> get authStateChanges => _remoteDatasource.authStateChanges;

  @override
  UserModel? getCurrentUser() {
    return _remoteDatasource.getCurrentUser();
  }
}
