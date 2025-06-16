import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _key = 'theme_mode';

  Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  void _loadTheme() {
    final stored = _box.read(_key);
    if (stored == 'light') {
      themeMode.value = ThemeMode.light;
    } else if (stored == 'dark') {
      themeMode.value = ThemeMode.dark;
    } else {
      themeMode.value = ThemeMode.system;
    }
  }

  void _saveTheme(ThemeMode mode) {
    String value = 'system';
    if (mode == ThemeMode.light) value = 'light';
    if (mode == ThemeMode.dark) value = 'dark';
    _box.write(_key, value);
  }

  void toggleTheme(bool isDark) {
    themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
    _saveTheme(themeMode.value);
  }

  void setSystemTheme() {
    themeMode.value = ThemeMode.system;
    _saveTheme(ThemeMode.system);
  }
}
