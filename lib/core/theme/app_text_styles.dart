import 'package:flutter/material.dart';

/// Standard Material 3 Typography system.
/// Defined with strict line-heights, letter-spacing, and font-weights.
abstract final class AppTextStyles {
  static const String fontFamily = 'Roboto'; // Or Inter / Outfit / Poppins

  static TextTheme createTextTheme(Color textColor) {
    return TextTheme(
      // Display
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 57,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
        height: 1.12,
        color: textColor,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 45,
        fontWeight: FontWeight.w700,
        height: 1.15,
        color: textColor,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 36,
        fontWeight: FontWeight.w600,
        height: 1.22,
        color: textColor,
      ),

      // Headline
      headlineLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.25,
        color: textColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.28,
        color: textColor,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.33,
        color: textColor,
      ),

      // Title
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 1.27,
        color: textColor,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        height: 1.5,
        color: textColor,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
        color: textColor,
      ),

      // Body
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.5,
        color: textColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.43,
        color: textColor,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.33,
        color: textColor,
      ),

      // Label
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.43,
        color: textColor,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.33,
        color: textColor,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.45,
        color: textColor,
      ),
    );
  }
}
