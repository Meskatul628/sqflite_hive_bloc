import 'package:flutter/material.dart';

/// Primary brand button component implemented with Material Theme colors.
///
/// Features:
/// - Uses Material theme colorScheme (primary, onPrimary, onSurface, shadow, etc.)
/// - Rounded pill shape (32px default)
/// - Drop shadow & subtle border highlight
/// - Semibold 16px typography from TextTheme
/// - Support for loading indicator, prefix/suffix icons, and disabled states
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double height;
  final bool isLoading;
  final bool isDisabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
  final Gradient? gradient;
  final Color? backgroundColor;
  final Color? borderColor;
  final List<BoxShadow>? boxShadow;
  final BorderRadius? borderRadius;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 48.0,
    this.isLoading = false,
    this.isDisabled = false,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.gradient,
    this.backgroundColor,
    this.borderColor,
    this.boxShadow,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? BorderRadius.circular(32.0);
    final isInteractive = !isDisabled && !isLoading && onPressed != null;
    final isWhiteBg = backgroundColor != null;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveTextStyle = textStyle ??
        (theme.textTheme.labelLarge)?.copyWith(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.16,
          height: 1.5,
          color: isWhiteBg ? colorScheme.onSurface : colorScheme.onPrimary,
        );

    final effectiveShadow = boxShadow ??
        (isWhiteBg
            ? const [
                BoxShadow(
                  color: Color(0x40EDEDED),
                  blurRadius: 4.2,
                  offset: Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.2),
                  offset: const Offset(0, 4),
                  blurRadius: 4.0,
                  spreadRadius: 0,
                ),
              ]);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isDisabled ? 0.5 : 1.0,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: effectiveRadius,
          boxShadow: effectiveShadow,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor ??
                (gradient == null ? colorScheme.primary : null),
            gradient: backgroundColor == null ? gradient : null,
            borderRadius: effectiveRadius,
            border: Border.all(
              color: borderColor ??
                  (isWhiteBg
                      ? colorScheme.outline.withValues(alpha: 0.3)
                      : Colors.white.withValues(alpha: 0.25)),
              width: 1.0,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isInteractive ? onPressed : null,
              borderRadius: effectiveRadius,
              splashColor: isWhiteBg
                  ? Colors.black.withValues(alpha: 0.05)
                  : Colors.white.withValues(alpha: 0.15),
              highlightColor: isWhiteBg
                  ? Colors.black.withValues(alpha: 0.02)
                  : Colors.white.withValues(alpha: 0.08),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
                child: Center(
                  child: isLoading
                      ? SizedBox(
                          width: 22.0,
                          height: 22.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isWhiteBg
                                  ? colorScheme.primary
                                  : colorScheme.onPrimary,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (prefixIcon != null) ...[
                              prefixIcon!,
                              const SizedBox(width: 8.0),
                            ],
                            Flexible(
                              child: Text(
                                text,
                                style: effectiveTextStyle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            if (suffixIcon != null) ...[
                              const SizedBox(width: 8.0),
                              suffixIcon!,
                            ],
                          ],
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
