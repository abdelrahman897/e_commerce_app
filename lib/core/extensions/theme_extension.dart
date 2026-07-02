import 'package:e_commerce_app/core/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

extension AppTheme on BuildContext {
  // shortcut: colorScheme
  CustomColorScheme get customColorScheme =>
      Theme.of(this).extension<CustomColorScheme>()!;

  // shortcut: textTheme
  TextTheme get textTheme => Theme.of(this).textTheme;
}
