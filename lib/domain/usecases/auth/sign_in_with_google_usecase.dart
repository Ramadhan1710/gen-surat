import 'package:gen_surat/core/utils/result.dart';
import 'package:gen_surat/data/models/user_model.dart';
import 'package:gen_surat/domain/repositories/i_auth_repository.dart';

class SignInWithGoogleUsecase {
  final IAuthRepository _authRepository;

  SignInWithGoogleUsecase(this._authRepository);

  Future<Result<UserModel>> call() {
    return _authRepository.signInWithGoogle();
  }
}
