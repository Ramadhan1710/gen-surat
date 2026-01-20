import 'package:gen_surat/core/utils/result.dart';
import 'package:gen_surat/data/models/profile_model.dart';

abstract class IProfileRepository {
  Future<Result<ProfileModel>> getProfile(String userId);
}