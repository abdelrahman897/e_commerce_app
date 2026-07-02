import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/font_manager.dart';
import 'package:e_commerce_app/core/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

abstract final class AppTextTheme {
  AppTextTheme._();

  static TextTheme textTheme(CustomColorScheme colors) => TextTheme(
    displayLarge: TextStyle(
      fontSize: FontSize.s57,
      fontWeight: FontWeightManager.regular,
      color: colors.text,
    ),
    displayMedium: TextStyle(
      fontSize: FontSize.s45,
      fontWeight: FontWeightManager.regular,
      color: colors.text,
    ),
    displaySmall: TextStyle(
      fontSize: FontSize.s36,
      fontWeight: FontWeightManager.regular,
      color: colors.text,
    ),

    headlineLarge: TextStyle(
      fontSize: FontSize.s32,
      fontWeight: FontWeightManager.bold,
      color: colors.text,
    ),
    headlineMedium: TextStyle(
      fontSize: FontSize.s28,
      fontWeight: FontWeightManager.bold,
      color: colors.text,
    ),
    headlineSmall: TextStyle(
      fontSize: FontSize.s24,
      fontWeight: FontWeightManager.bold,
      color: colors.text,
    ),

    titleLarge: TextStyle(
      fontSize: FontSize.s22,
      fontWeight: FontWeightManager.bold,
      color: colors.text,
    ),
    titleMedium: TextStyle(
      fontSize: FontSize.s16,
      fontWeight: FontWeightManager.bold,
      color: colors.text,
    ),
    titleSmall: TextStyle(
      fontSize: FontSize.s14,
      fontWeight: FontWeightManager.bold,
      color: colors.text,
    ),

    bodyLarge: TextStyle(
      fontSize: FontSize.s16,
      fontWeight: FontWeightManager.regular,
      color: ColorManager.grey,
    ),
    bodyMedium: TextStyle(
      fontSize: FontSize.s14,
      fontWeight: FontWeightManager.regular,
      color: colors.text,
    ),
    bodySmall: TextStyle(
      fontSize: FontSize.s12,
      fontWeight: FontWeightManager.regular,
      color: colors.text,
    ),

    labelLarge: TextStyle(
      fontSize: FontSize.s14,
      fontWeight: FontWeightManager.medium,
      color: colors.text,
    ),
    labelMedium: TextStyle(
      fontSize: FontSize.s12,
      fontWeight: FontWeightManager.medium,
      color: colors.text,
    ),
    labelSmall: TextStyle(
      fontSize: FontSize.s11,
      fontWeight: FontWeightManager.medium,
      color: colors.text,
    ),
  );
}
