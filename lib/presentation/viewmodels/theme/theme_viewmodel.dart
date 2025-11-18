import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ThemeType { light, dark, system }

class ThemeViewModel extends GetxController {
  final _themeType = ThemeType.system.obs;

  ThemeType get themeType => _themeType.value;

  bool get isDarkMode {
    if (_themeType.value == ThemeType.system) {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    }
    return _themeType.value == ThemeType.dark;
  }

  ThemeMode get currentThemeMode {
    switch (_themeType.value) {
      case ThemeType.light: 
        return ThemeMode.light;
      case ThemeType.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  void setTheme(ThemeType type) {
    if (_themeType.value != type) {
      _themeType.value = type;
    }
  }

  void toggleTheme() {
    switch (_themeType.value) {
      case ThemeType.light:
        _themeType.value = ThemeType.dark;
        break;
      case ThemeType.dark:
        _themeType.value = ThemeType.light;
        break;
      case ThemeType.system:
        _themeType.value = ThemeType.light;
        break; 
    }
  }
}
