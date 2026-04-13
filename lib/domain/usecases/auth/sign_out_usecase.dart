import 'package:gen_surat/core/utils/result.dart';
import 'package:gen_surat/domain/repositories/i_auth_repository.dart';

class SignOutUsecase {
  final IAuthRepository _authRepository;

  SignOutUsecase(this._authRepository);

  Future<Result<void>> call() {
    return _authRepository.signOut();
  }
}
