import 'package:gen_surat/core/services/supabase_service.dart';
import 'package:gen_surat/core/utils/result.dart';
import 'package:gen_surat/data/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class IProfileRemoteDatasource {
  Future<Result<ProfileModel>> getProfile(String userId);
}

class ProfileRemoteDatasource implements IProfileRemoteDatasource {
  final SupabaseService _supabase;

  ProfileRemoteDatasource(this._supabase);

  @override
  Future<Result<ProfileModel>> getProfile(String userId) async {
    try {
      final response =
          await _supabase.supabaseClient
              .from('profiles')
              .select()
              .eq('id', userId)
              .single();
      return Success(ProfileModel.fromJson(response));
    } on PostgrestException catch (e) {
      return Failure(DatabaseException(message: e.message, code: e.code));
    } catch (e) {
      return Failure(UnknownException(message: e.toString()));
    }
  }
}
 