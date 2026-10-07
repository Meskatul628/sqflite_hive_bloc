import 'package:flutter/material.dart';
import 'app_theme_extension.dart';

/// 10+ Years Senior Developer Ergonomics:
/// Context extensions provide clean, type-safe, and concise access
/// to the entire theme system throughout UI widgets.
extension ThemeContextExtension on BuildContext {
  /// Fast access to current ThemeData
  ThemeData get theme => Theme.of(this);

  /// Fast access to Material 3 ColorScheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Fast access to Typography TextTheme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Fast access to custom brand & status extension tokens
  AppCustomTheme get customTheme =>
      Theme.of(this).extension<AppCustomTheme>() ?? AppCustomTheme.light;

  /// Check if the current theme is in dark mode
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
