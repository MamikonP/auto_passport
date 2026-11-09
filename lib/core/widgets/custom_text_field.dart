import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final TextStyle? labelStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final AutovalidateMode? autovalidateMode;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final bool filled;
  final double borderRadius;
  final Color? borderColor;
  final InputDecoration? decoration;
  final bool readOnly;
  final bool enabled;
  final bool obscureText;
  final bool autofocus;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool isFormField;

  const CustomTextField({
    super.key,
    this.label,
    this.labelStyle,
    this.hintText,
    this.hintStyle,
    this.controller,
    this.focusNode,
    this.initialValue,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onSubmitted,
    this.validator,
    this.onSaved,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.fillColor,
    this.filled = true,
    this.borderRadius = 10,
    this.borderColor,
    this.decoration,
    this.readOnly = false,
    this.enabled = true,
    this.obscureText = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.isFormField = true,
  });

  const CustomTextField.textField({
    super.key,
    this.label,
    this.labelStyle,
    this.hintText,
    this.hintStyle,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onSubmitted,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.fillColor,
    this.filled = true,
    this.borderRadius = 10,
    this.borderColor,
    this.decoration,
    this.readOnly = false,
    this.enabled = true,
    this.obscureText = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
  }) : isFormField = false,
       initialValue = null,
       validator = null,
       onSaved = null,
       autovalidateMode = null;

  InputDecoration _buildDecoration() {
    if (decoration != null) return decoration!;

    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: borderColor ?? AppColors.darkBorder),
    );

    return InputDecoration(
      fillColor: fillColor ?? AppColors.darkSurface,
      filled: filled,
      hintText: hintText,
      hintStyle: hintStyle ?? const TextStyle(color: AppColors.textMuted),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      contentPadding: contentPadding,
      border: outlineBorder,
      enabledBorder: outlineBorder,
    );
  }

  Widget _buildField() {
    final effectiveStyle =
        style ?? const TextStyle(color: Colors.white, fontSize: 14);
    final effectiveDecoration = _buildDecoration();

    if (isFormField) {
      return TextFormField(
        controller: controller,
        focusNode: focusNode,
        initialValue: initialValue,
        onChanged: onChanged,
        onTap: onTap,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onSubmitted,
        validator: validator,
        onSaved: onSaved,
        autovalidateMode: autovalidateMode,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        textCapitalization: textCapitalization,
        style: effectiveStyle,
        textAlign: textAlign,
        inputFormatters: inputFormatters,
        readOnly: readOnly,
        enabled: enabled,
        obscureText: obscureText,
        autofocus: autofocus,
        maxLines: maxLines,
        minLines: minLines,
        maxLength: maxLength,
        decoration: effectiveDecoration,
      );
    }

    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      style: effectiveStyle,
      textAlign: textAlign,
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      enabled: enabled,
      obscureText: obscureText,
      autofocus: autofocus,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      decoration: effectiveDecoration,
    );
  }

  @override
  Widget build(BuildContext context) {
    final field = _buildField();

    if (label == null) {
      return field;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label!,
          style:
              labelStyle ??
              const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
        ),
        const SizedBox(height: 6),
        field,
      ],
    );
  }
}
