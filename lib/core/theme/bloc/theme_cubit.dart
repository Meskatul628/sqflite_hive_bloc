import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

/// Senior Pattern: Persistent ThemeCubit.
/// Saves and loads user theme preference (System, Light, Dark) using Hive.
class ThemeCubit extends Cubit<ThemeMode> {
  static const String _boxName = 'settings_box';
  static const String _themeKey = 'app_theme_mode';

  ThemeCubit() : super(_loadInitialTheme());

  static ThemeMode _loadInitialTheme() {
    try {
      if (Hive.isBoxOpen(_boxName)) {
        final box = Hive.box(_boxName);
        final savedTheme = box.get(_themeKey, defaultValue: 'system') as String;
        return _themeModeFromString(savedTheme);
      }
    } catch (_) {}
    return ThemeMode.system;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    emit(mode);
    try {
      if (Hive.isBoxOpen(_boxName)) {
        final box = Hive.box(_boxName);
        await box.put(_themeKey, _themeModeToString(mode));
      }
    } catch (_) {}
  }

  void toggleTheme() {
    if (state == ThemeMode.dark) {
      setThemeMode(ThemeMode.light);
    } else {
      setThemeMode(ThemeMode.dark);
    }
  }

  static ThemeMode _themeModeFromString(String value) {
    return switch (value) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  static String _themeModeToString(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
  }
}
