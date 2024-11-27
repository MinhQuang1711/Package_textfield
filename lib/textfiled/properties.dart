import 'package:flutter/material.dart';

class TextFieldProperties {
  static InputDecoration getInputDecoration({
    String? hintText,
    Color? borderColor,
    Color? backgroundColor,
    Widget? sufWidget,
    Widget? prefWidget,
    TextStyle? hintStyle,
    double? radius,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return InputDecoration(
      filled: true,
      isDense: true,
      hintText: hintText,
      suffixIcon: sufWidget,
      prefixIcon: prefWidget,
      border: getBorder(borderColor, radius),
      disabledBorder: getBorder(null, radius),
      enabledBorder: getBorder(borderColor, radius),
      fillColor: backgroundColor ?? Colors.grey.shade200,
      errorBorder: getBorder(borderColor ?? Colors.red, radius),
      contentPadding: contentPadding ?? const EdgeInsets.all(13),
      focusedBorder: getBorder(borderColor ?? Colors.blue.shade200, radius),
      hintStyle: hintStyle,
    );
  }

  static OutlineInputBorder getBorder(Color? color, double? radius) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 0),
      borderSide: BorderSide(color: color ?? Colors.grey.shade200),
    );
  }
}
