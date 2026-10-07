import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Senior Pattern: ThemeExtension for custom brand & status tokens.
/// This allows accessing custom design tokens via `context.customTheme`
/// with full compile-time safety and automatic theme lerp/transitions.
@immutable
class AppCustomTheme extends ThemeExtension<AppCustomTheme> {
  final Color success;
  final Color successContainer;
  final Color warning;
  final Color warningContainer;
  final Color info;
  final Color infoContainer;
  final Gradient primaryGradient;
  final double cardBorderRadius;
  final double buttonBorderRadius;

  const AppCustomTheme({
    required this.success,
    required this.successContainer,
    required this.warning,
    required this.warningContainer,
    required this.info,
    required this.infoContainer,
    required this.primaryGradient,
    this.cardBorderRadius = 16.0,
    this.buttonBorderRadius = 12.0,
  });

  // Light mode custom extension tokens
  static const light = AppCustomTheme(
    success: AppColors.success,
    successContainer: AppColors.successLight,
    warning: AppColors.warning,
    warningContainer: AppColors.warningLight,
    info: AppColors.info,
    infoContainer: AppColors.infoLight,
    primaryGradient: LinearGradient(
      colors: [AppColors.primary600, Color(0xFF8B5CF6)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  // Dark mode custom extension tokens
  static const dark = AppCustomTheme(
    success: Color(0xFF34D399),
    successContainer: Color(0xFF064E3B),
    warning: Color(0xFFFBBF24),
    warningContainer: Color(0xFF78350F),
    info: Color(0xFF60A5FA),
    infoContainer: Color(0xFF1E3A8A),
    primaryGradient: LinearGradient(
      colors: [AppColors.primary500, Color(0xFFA78BFA)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  @override
  AppCustomTheme copyWith({
    Color? success,
    Color? successContainer,
    Color? warning,
    Color? warningContainer,
    Color? info,
    Color? infoContainer,
    Gradient? primaryGradient,
    double? cardBorderRadius,
    double? buttonBorderRadius,
  }) {
    return AppCustomTheme(
      success: success ?? this.success,
      successContainer: successContainer ?? this.successContainer,
      warning: warning ?? this.warning,
      warningContainer: warningContainer ?? this.warningContainer,
      info: info ?? this.info,
      infoContainer: infoContainer ?? this.infoContainer,
      primaryGradient: primaryGradient ?? this.primaryGradient,
      cardBorderRadius: cardBorderRadius ?? this.cardBorderRadius,
      buttonBorderRadius: buttonBorderRadius ?? this.buttonBorderRadius,
    );
  }

  @override
  AppCustomTheme lerp(ThemeExtension<AppCustomTheme>? other, double t) {
    if (other is! AppCustomTheme) return this;
    return AppCustomTheme(
      success: Color.lerp(success, other.success, t) ?? success,
      successContainer: Color.lerp(successContainer, other.successContainer, t) ?? successContainer,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      warningContainer: Color.lerp(warningContainer, other.warningContainer, t) ?? warningContainer,
      info: Color.lerp(info, other.info, t) ?? info,
      infoContainer: Color.lerp(infoContainer, other.infoContainer, t) ?? infoContainer,
      primaryGradient: Gradient.lerp(primaryGradient, other.primaryGradient, t) ?? primaryGradient,
      cardBorderRadius: cardBorderRadius + (other.cardBorderRadius - cardBorderRadius) * t,
      buttonBorderRadius: buttonBorderRadius + (other.buttonBorderRadius - buttonBorderRadius) * t,
    );
  }
}
