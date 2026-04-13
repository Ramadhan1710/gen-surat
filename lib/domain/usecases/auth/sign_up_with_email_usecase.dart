import 'package:gen_surat/core/utils/result.dart';
import 'package:gen_surat/data/models/user_model.dart';
import 'package:gen_surat/domain/repositories/i_auth_repository.dart';

class SignUpWithEmailUsecase {
  final IAuthRepository _authRepository;

  SignUpWithEmailUsecase(this._authRepository);

  Future<Result<UserModel>> call({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) {
    return _authRepository.signUpWithEmail(
      email: email,
      password: password,
      data: data,
    );
  }
}
