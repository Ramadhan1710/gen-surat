import 'package:gen_surat/core/utils/result.dart';
import 'package:gen_surat/data/datasources/remote/profile_remote_datasource.dart';
import 'package:gen_surat/data/models/profile_model.dart';
import 'package:gen_surat/domain/repositories/i_profile_repository.dart';

class ProfileRepository implements IProfileRepository {
  final IProfileRemoteDatasource _remoteDatasource;

  ProfileRepository(this._remoteDatasource);

  @override
  Future<Result<ProfileModel>> getProfile(String userId) {
    return _remoteDatasource.getProfile(userId);
  }
}
