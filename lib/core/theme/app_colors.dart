import 'package:flutter/material.dart';

/// Enterprise-grade color palette & semantic tokens.
/// Senior Principle: Never hardcode raw hex colors in widgets.
/// Always use ColorScheme or ThemeExtensions.
abstract final class AppColors {
  // ----------------- Brand Core Palette -----------------
  static const Color primary50 = Color(0xFFEEF2FF);
  static const Color primary100 = Color(0xFFE0E7FF);
  static const Color primary200 = Color(0xFFC7D2FE);
  static const Color primary300 = Color(0xFFA5B4FC);
  static const Color primary400 = Color(0xFF818CF8);
  static const Color primary500 = Color(0xFF6366F1); // Primary Brand
  static const Color primary600 = Color(0xFF4F46E5);
  static const Color primary700 = Color(0xFF4338CA);
  static const Color primary800 = Color(0xFF3730A3);
  static const Color primary900 = Color(0xFF312E81);

  // ----------------- Neutral Palette -----------------
  static const Color neutral50 = Color(0xFFF8FAFC);
  static const Color neutral100 = Color(0xFFF1F5F9);
  static const Color neutral200 = Color(0xFFE2E8F0);
  static const Color neutral300 = Color(0xFFCBD5E1);
  static const Color neutral400 = Color(0xFF94A3B8);
  static const Color neutral500 = Color(0xFF64748B);
  static const Color neutral600 = Color(0xFF475569);
  static const Color neutral700 = Color(0xFF334155);
  static const Color neutral800 = Color(0xFF1E293B);
  static const Color neutral900 = Color(0xFF0F172A);
  static const Color neutral950 = Color(0xFF020617);

  // ----------------- Feedback / Status Tokens -----------------
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);

  // ----------------- Light Theme ColorScheme -----------------
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary600,
    onPrimary: Colors.white,
    primaryContainer: primary100,
    onPrimaryContainer: primary900,
    secondary: Color(0xFF0EA5E9),
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFE0F2FE),
    onSecondaryContainer: Color(0xFF0369A1),
    tertiary: Color(0xFF8B5CF6),
    onTertiary: Colors.white,
    error: error,
    onError: Colors.white,
    errorContainer: errorLight,
    onErrorContainer: Color(0xFF991B1B),
    surface: Colors.white,
    onSurface: neutral900,
    surfaceContainerHighest: neutral100,
    onSurfaceVariant: neutral600,
    outline: neutral300,
    outlineVariant: neutral200,
    shadow: Color(0x1A000000),
  );

  // ----------------- Dark Theme ColorScheme -----------------
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primary400,
    onPrimary: neutral950,
    primaryContainer: primary900,
    onPrimaryContainer: primary200,
    secondary: Color(0xFF38BDF8),
    onSecondary: neutral950,
    secondaryContainer: Color(0xFF075985),
    onSecondaryContainer: Color(0xFFBAE6FD),
    tertiary: Color(0xFFA78BFA),
    onTertiary: neutral950,
    error: Color(0xFFF87171),
    onError: neutral950,
    errorContainer: Color(0xFF7F1D1D),
    onErrorContainer: Color(0xFFFECACA),
    surface: neutral900,
    onSurface: neutral50,
    surfaceContainerHighest: neutral800,
    onSurfaceVariant: neutral400,
    outline: neutral700,
    outlineVariant: neutral800,
    shadow: Color(0x66000000),
  );
}
