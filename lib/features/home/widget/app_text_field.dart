import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Custom TextFormField component implemented with Material Theme colors.
///
/// Features:
/// - 48px height pill shape (32px border radius)
/// - Material colorScheme integration for background, text, borders, and shadows
/// - Active/focused state with brand primary border
/// - Dynamic FocusNode integration with animated state transitions
/// - FormField validation support with clean error presentation
/// - Built-in obscureText password toggle support
/// - Typography from TextTheme
class AppTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final String? labelText;
  final TextStyle? labelStyle;
  final String? initialValue;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode;
  final EdgeInsetsGeometry? margin;
  final double height;
  final BorderRadius? borderRadius;

  const AppTextFormField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.labelText,
    this.labelStyle,
    this.initialValue,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.onSaved,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.inputFormatters,
    this.autovalidateMode,
    this.margin,
    this.height = 48.0,
    this.borderRadius,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  late bool _obscured;

  @override
  void initState() {
    super.initState();
    _obscured = widget.obscureText;
    _focusNode = widget.focusNode ?? FocusNode();
    _isFocused = _focusNode.hasFocus;
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(AppTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_onFocusChange);
      _focusNode = widget.focusNode ?? FocusNode();
      _isFocused = _focusNode.hasFocus;
      _focusNode.addListener(_onFocusChange);
    }
  }

  void _onFocusChange() {
    if (mounted && _isFocused != _focusNode.hasFocus) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_onFocusChange);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final effectiveRadius = widget.borderRadius ?? BorderRadius.circular(32.0);

    final inputTextStyle = (theme.textTheme.bodyMedium)?.copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.14,
      height: 1.5,
      color: widget.enabled ? colorScheme.onSurface : colorScheme.onSurfaceVariant,
    );

    final hintTextStyle = (theme.textTheme.bodyMedium)?.copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.14,
      height: 1.5,
      color: colorScheme.onSurfaceVariant,
    );

    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.labelText != null) ...[
            Padding(
              padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
              child: Text(
                widget.labelText!,
                style: widget.labelStyle ??
                    theme.textTheme.labelMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
          FormField<String>(
            initialValue: widget.controller?.text ?? widget.initialValue ?? '',
            validator: widget.validator,
            autovalidateMode: widget.autovalidateMode,
            onSaved: widget.onSaved,
            enabled: widget.enabled,
            builder: (FormFieldState<String> field) {
              final hasError = field.hasError;

              // Compute border color
              final Color borderColor;
              final double borderWidth;
              if (hasError) {
                borderColor = colorScheme.error;
                borderWidth = 1.5;
              } else if (_isFocused) {
                borderColor = colorScheme.primary;
                borderWidth = 1.5;
              } else {
                borderColor = colorScheme.outline;
                borderWidth = 1.0;
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: widget.height,
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: effectiveRadius,
                      border: Border.all(
                        color: borderColor,
                        width: borderWidth,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.shadow.withValues(alpha: 0.15),
                          offset: const Offset(0, 4),
                          blurRadius: 4.0,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (widget.prefixIcon != null) ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: widget.prefixIcon!,
                          ),
                        ],
                        Expanded(
                          child: TextFormField(
                            controller: widget.controller,
                            focusNode: _focusNode,
                            initialValue: widget.controller == null ? widget.initialValue : null,
                            enabled: widget.enabled,
                            readOnly: widget.readOnly,
                            autofocus: widget.autofocus,
                            obscureText: _obscured,
                            keyboardType: widget.keyboardType,
                            textInputAction: widget.textInputAction,
                            maxLines: widget.maxLines,
                            inputFormatters: widget.inputFormatters,
                            style: inputTextStyle,
                            cursorColor: colorScheme.primary,
                            onChanged: (val) {
                              field.didChange(val);
                              widget.onChanged?.call(val);
                            },
                            onFieldSubmitted: widget.onFieldSubmitted,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: widget.hintText,
                              hintStyle: hintTextStyle,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: widget.prefixIcon != null ? 12.0 : 20.0,
                                vertical: 12.0,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        if (widget.suffixIcon != null) ...[
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: widget.suffixIcon!,
                          ),
                        ] else if (widget.obscureText) ...[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                              icon: Icon(
                                _obscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                size: 20.0,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              splashRadius: 18.0,
                              onPressed: () {
                                setState(() {
                                  _obscured = !_obscured;
                                });
                              },
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (hasError && field.errorText != null) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                      child: Text(
                        field.errorText!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.error,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
