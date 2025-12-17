import 'package:gen_surat/core/config/env_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseClient supabaseClient;

  SupabaseService(this.supabaseClient);

  User? get currentUser => supabaseClient.auth.currentUser;

  bool get isLoggedIn => currentUser != null;

  Stream<AuthState> get authStateChanges =>
      supabaseClient.auth.onAuthStateChange;

  Future<void> initialize() async {
    await Supabase.initialize(
      url: EnvConfig.supabaseUrl,
      anonKey: EnvConfig.supabaseAnonKey,
    );
  }
} 