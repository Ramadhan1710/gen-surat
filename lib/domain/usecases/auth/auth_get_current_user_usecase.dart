import 'package:gen_surat/data/models/user_model.dart';
import 'package:gen_surat/domain/repositories/i_auth_repository.dart';

class AuthGetCurrentUserUsecase {
  final IAuthRepository _repository;
  
  AuthGetCurrentUserUsecase(this._repository);
  
  UserModel? call() => _repository.getCurrentUser();
}