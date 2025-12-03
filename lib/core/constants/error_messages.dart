class ErrorMessages {
  // Form validation
  static const String requiredField = 'wajib diisi';
  static const String invalidPhone = 'Nomor telepon tidak valid (10-13 digit)';
  static const String invalidEmail = 'Format email tidak valid';

  // Network errors
  static const String connectionTimeout =
      'Koneksi timeout. Pastikan internet Anda stabil.';
  static const String serverError =
      'Server terlalu lama merespon. Coba lagi nanti.';

  static String fieldRequired(String fieldName) => '$fieldName $requiredField';
}
