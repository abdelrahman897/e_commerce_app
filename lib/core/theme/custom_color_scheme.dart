import 'package:flutter/material.dart';

class CustomColorScheme extends ThemeExtension<CustomColorScheme> {
  final Color primary;
  final Color foreground;
  final Color button;
  final Color onButton;
  final Color text;
  final Color container;
  final Color filledTextForm;
  final Color hintText;
  final Color outLine;
  final Color icon;
  final Color bottom;
  final Brightness brightness;

  const CustomColorScheme({
    required this.primary,
    required this.button,
    required this.onButton,
    required this.text,
    required this.hintText,
    required this.outLine,
    required this.icon,
    required this.foreground,
    required this.filledTextForm,
    required this.bottom,
    required this.brightness,
    required this.container,
  });

  @override
  CustomColorScheme copyWith({
    Color? primary,
    Color? foreground,
    Color? button,
    Color? onButton,
    Color? text,
    Color? filledTextForm,
    Color? hintText,
    Color? container,
    Color? outLine,
    Color? icon,
    Color? bottom,
    Brightness? brightness,
  }) {
    return CustomColorScheme(
      primary: primary ?? this.primary,
      foreground: foreground ?? this.foreground,
      button: button ?? this.button,
      onButton: onButton ?? this.onButton,
      text: text ?? this.text,
      filledTextForm: filledTextForm ?? this.filledTextForm,
      hintText: hintText ?? this.hintText,
      outLine: outLine ?? this.outLine,
      icon: icon ?? this.icon,
      bottom: bottom ?? this.bottom,
      brightness: brightness ?? this.brightness,
      container: this.container,
    );
  }

  @override
  CustomColorScheme lerp(CustomColorScheme? other, double t) {
    if (other is! CustomColorScheme) return this;
    return CustomColorScheme(
      primary: Color.lerp(primary, other.primary, t)!,
      foreground: Color.lerp(foreground, other.foreground, t)!,
      button: Color.lerp(button, other.button, t)!,
      onButton: Color.lerp(onButton, other.onButton, t)!,
      text: Color.lerp(text, other.text, t)!,
      filledTextForm: Color.lerp(filledTextForm, other.filledTextForm, t)!,
      hintText: Color.lerp(hintText, other.hintText, t)!,
      outLine: Color.lerp(outLine, other.outLine, t)!,
      icon: Color.lerp(icon, other.icon, t)!,
      bottom: Color.lerp(bottom, other.bottom, t)!,
      container: Color.lerp(container, other.container, t)!,
      brightness: t < 0.5 ? brightness : other.brightness,
    );
  }
}
