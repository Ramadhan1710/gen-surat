import 'package:gen_surat/core/utils/result.dart';
import 'package:gen_surat/data/models/user_model.dart';
import 'package:gen_surat/domain/repositories/i_auth_repository.dart';

class SignInWithEmailUsecase {
  final IAuthRepository _authRepository;

  SignInWithEmailUsecase(this._authRepository);

  Future<Result<UserModel>> call({
    required String email,
    required String password,
  }) {
    return _authRepository.signInWithEmail(email: email, password: password);
  }
}
