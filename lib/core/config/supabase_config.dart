import 'package:supabase_flutter/supabase_flutter.dart';
import 'env_config.dart';

/// Konfigurasi dan inisialisasi Supabase
class SupabaseConfig {
  // Private constructor
  SupabaseConfig._();

  /// Instance Supabase client
  static SupabaseClient get client => Supabase.instance.client;

  /// Initialize Supabase
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: EnvConfig.supabaseUrl,
      anonKey: EnvConfig.supabaseAnonKey,
    );
  }
}
