// watch_auth_state_usecase.dart
import 'package:gen_surat/data/models/user_model.dart';
import 'package:gen_surat/domain/repositories/i_auth_repository.dart';

class WatchAuthStateUsecase {
  final IAuthRepository _repository;
  
  WatchAuthStateUsecase(this._repository);
  
  Stream<UserModel?> call() => _repository.authStateChanges;
}