// 📁 lib/core/theme/theme_manager.dart

import 'package:e_commerce_app/core/theme/app_colors_schemes.dart';
import 'package:e_commerce_app/core/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'app_component_themes.dart';
import 'app_text_theme.dart';

abstract final class ThemeManager {
  ThemeManager._();

  static ThemeData light() => _buildTheme(AppColorSchemes.lightScheme);

  static ThemeData dark() => _buildTheme(AppColorSchemes.darkScheme);

  static ThemeData _buildTheme(CustomColorScheme colors) {
    final textTheme = AppTextTheme.textTheme(colors);

    return ThemeData(
      useMaterial3: true,
      textTheme: textTheme,
      brightness: colors.brightness,
      scaffoldBackgroundColor: colors.primary,
      extensions: [colors],

      appBarTheme: AppComponentThemes.appBarTheme(colors, textTheme),
      elevatedButtonTheme: AppComponentThemes.elevatedButtonTheme(
        colors,
        textTheme,
      ),
      outlinedButtonTheme: AppComponentThemes.outlinedButtonTheme(
        colors,
        textTheme,
      ),
      textButtonTheme: AppComponentThemes.textButtonTheme(colors, textTheme),
      inputDecorationTheme: AppComponentThemes.inputDecorationTheme(
        colors,
        textTheme,
      ),
      drawerTheme: AppComponentThemes.drawerTheme(colors),
      //     cardTheme: AppComponentThemes.cardTheme(colors),
      //     bottomNavigationBarTheme: AppComponentThemes.bottomNavBarTheme(
      //       colors,
      //       textTheme,
      //     ),
      dividerTheme: AppComponentThemes.dividerTheme(colors),
      //   chipTheme: AppComponentThemes.chipTheme(colors, textTheme),
      snackBarTheme: AppComponentThemes.snackBarTheme(colors, textTheme),
       dialogTheme: AppComponentThemes.dialogTheme(colors, textTheme),
      progressIndicatorTheme: AppComponentThemes.progressIndicatorTheme(colors),
    );
  }
}
