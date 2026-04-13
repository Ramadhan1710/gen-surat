import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Konfigurasi environment variables dari file .env
class EnvConfig {
  // Private constructor untuk mencegah instantiation
  EnvConfig._();

  /// URL Supabase
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';

  /// Anon key Supabase
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  // Google Sign In
  static String get googleClientId => dotenv.env['GOOGLE_CLIENT_ID'] ?? '';

  /// Validate apakah semua environment variables sudah di-set
  static bool get isValid {
    return supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
  }

  /// Load environment variables dari file .env
  static Future<void> load() async {
    await dotenv.load(fileName: ".env");
  }
}
