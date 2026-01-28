import 'package:hive_flutter/hive_flutter.dart';

class FormSuratStorageService {
  static const String _boxName = 'form_storage';
  static Box? _box;

  // inisialisasi Hive dan membuka box
  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  // Menyimpan data formulir dengan kunci tertentu berdasarkan jenis surat
  static Future<void> saveFormData(
    String formKey,
    Map<String, dynamic> data,
  ) async {
    await _box?.put(formKey, {
      ...data,
      'lastSaved': DateTime.now().toIso8601String(),
    });
  }

  // Load form data
  static Map<String, dynamic>? getFormData(String formKey) {
    final data = _box?.get(formKey);
    if (data == null) return null;

    // Cast dari Map<dynamic, dynamic> ke Map<String, dynamic>
    return Map<String, dynamic>.from(data as Map);
  }

  // cek apakah ada data
  static bool hasFormData(String formKey) {
    return _box?.containsKey(formKey) ?? false;
  }

  // Hapus data spesifik form
  static Future<void> deleteFormData(String formKey) async {
    await _box?.delete(formKey);
  }

  // Hapus semua data formulir
  static Future<void> clearAllDrafts() async {
    await _box?.clear();
  }

  // Mendapatkan waktu penyimpanan terakhir
  static DateTime? getLastSavedTime(String formKey) {
    final data = getFormData(formKey);
    if (data != null && data['lastSaved'] != null) {
      return DateTime.parse(data['lastSaved']);
    }
    return null;
  }
}
