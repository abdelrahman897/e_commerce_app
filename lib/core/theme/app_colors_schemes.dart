// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce_app/core/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_app/core/resources/color_manager.dart';

abstract final class AppColorSchemes {
  AppColorSchemes._();

  // Light Scheme
  static const CustomColorScheme lightScheme = CustomColorScheme(
    primary: LightColors.primary,
    button: LightColors.button,
    onButton: LightColors.onButton,
    text: LightColors.text,
    hintText: LightColors.hintText,
    outLine: LightColors.outLine,
    icon: LightColors.icon,
    foreground: LightColors.foreground,
    filledTextForm: LightColors.filledTextForm,
    bottom: LightColors.bottom,
    brightness: Brightness.light,
    container: LightColors.container,
  );

  // Dark Scheme
  static const CustomColorScheme darkScheme = CustomColorScheme(
    primary: DarkColors.primary,
    button: DarkColors.bottun,
    onButton: DarkColors.onButton,
    text: DarkColors.text,
    hintText: DarkColors.hintText,
    outLine: DarkColors.outLine,
    icon: DarkColors.icon,
    foreground: DarkColors.foreground,
    filledTextForm: DarkColors.filledTextForm,
    bottom: DarkColors.bottom,
    brightness: Brightness.dark,
    container: DarkColors.container,
  );
}
