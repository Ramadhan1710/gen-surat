import 'package:gen_surat/core/utils/result.dart';
import 'package:gen_surat/data/models/profile_model.dart';
import 'package:gen_surat/domain/repositories/i_profile_repository.dart';

class GetProfileUseCase {
  final IProfileRepository  _profileRepository;

  GetProfileUseCase(this._profileRepository);

  Future<Result<ProfileModel>> call(String userId) {
    return _profileRepository.getProfile(userId);
  }
}