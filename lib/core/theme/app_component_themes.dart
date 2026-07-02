import 'package:e_commerce_app/core/gen/fonts.gen.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/font_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

/// Component-level theme overrides.
/// Keep each component in its own getter — easy to find, easy to modify.
abstract final class AppComponentThemes {
  AppComponentThemes._();

  // AppBar

  static AppBarTheme appBarTheme(
    CustomColorScheme colors,
    TextTheme textTheme,
  ) => AppBarTheme(
    backgroundColor: colors.primary,
    foregroundColor: colors.foreground,
    elevation: 0,
    scrolledUnderElevation: 1,
    centerTitle: true,
    titleTextStyle: textTheme.titleLarge?.copyWith(color: colors.button),
    actionsIconTheme: IconThemeData(color: colors.button),
  );

  // ElevatedButton
  static ElevatedButtonThemeData elevatedButtonTheme(
    CustomColorScheme colors,
    TextTheme textTheme,
  ) => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      alignment: Alignment.center,
      padding: EdgeInsets.all(AppHeight.h16),
      elevation: 0,
    ),
  );

  // OutlinedButton
  static OutlinedButtonThemeData outlinedButtonTheme(
    CustomColorScheme colors,
    TextTheme textTheme,
  ) => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: colors.foreground,
      minimumSize: Size(AppHeight.h88, AppHeight.h52),
      side: BorderSide(color: colors.primary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.r12)),
      ),
      textStyle: textTheme.titleMedium,
    ),
  );

  // TextButton
  static TextButtonThemeData textButtonTheme(
    CustomColorScheme colors,
    TextTheme textTheme,
  ) => TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: colors.text,
      textStyle: TextStyle(
        fontSize: FontSize.s18,
        fontFamily: FontFamily.cairo,
      ),
    ),
  );

  // InputDecoration (TextField)
  static InputDecorationTheme inputDecorationTheme(
    CustomColorScheme colors,
    TextTheme textTheme,
  ) => InputDecorationTheme(
    filled: true,
    fillColor: colors.filledTextForm,
    contentPadding: EdgeInsets.symmetric(
      horizontal: AppWidth.w16,
      vertical: AppHeight.h10,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppRadius.r16)),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppRadius.r16)),
      borderSide: BorderSide(color: colors.outLine),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppRadius.r16)),
      borderSide: BorderSide(color: colors.outLine, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppRadius.r16)),
      borderSide: BorderSide(color: ColorManager.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppRadius.r16)),
      borderSide: BorderSide(color: ColorManager.red, width: 2),
    ),
    labelStyle: textTheme.bodyMedium,
    hintStyle: textTheme.bodyMedium?.copyWith(color: ColorManager.grey),
    errorStyle: textTheme.labelSmall?.copyWith(color: ColorManager.red),
  );

  /*
  // Card
  static CardThemeData cardTheme(CustomColorScheme colors) => CardThemeData(
    color: colors.surfaceContainerLow,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppRadius.r12)),
    ),
    margin: EdgeInsets.symmetric(
      horizontal: AppWidth.w16,
      vertical: AppHeight.h8,
    ),
  );
*/

  // BottomNavigationBar
  static BottomNavigationBarThemeData bottomNavBarTheme(
    CustomColorScheme colors,
    TextTheme textTheme,
  ) => BottomNavigationBarThemeData(
    backgroundColor: colors.button,
    selectedItemColor: ColorManager.white,
    unselectedItemColor: ColorManager.white,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
    showSelectedLabels: true,
    showUnselectedLabels: false,
  );

  /*
  // NavigationBar (M3)
  static NavigationBarThemeData navigationBarTheme(
    CustomColorScheme colors,
    TextTheme textTheme,
  ) => NavigationBarThemeData(
    backgroundColor: colors.surface,
    indicatorColor: colors.primaryContainer,
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return textTheme.titleSmall;
      }
      return textTheme.bodySmall;
    }),
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return IconThemeData(color: colors.onPrimaryContainer);
      }
      return IconThemeData(color: colors.onSurfaceVariant);
    }),
  );
*/
  // Divider
  static DividerThemeData dividerTheme(CustomColorScheme colors) =>
      DividerThemeData(color: ColorManager.grey, thickness: 1.3);
  /*
  // Chip
  static ChipThemeData chipTheme(
    CustomColorScheme colors,
    TextTheme textTheme,
  ) => ChipThemeData(
    backgroundColor: colors.surfaceContainerHighest,
    selectedColor: colors.primaryContainer,
    labelStyle: textTheme.labelLarge,
    side: BorderSide.none,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppRadius.r8)),
    ),
  );
*/
  // SnackBar
  static SnackBarThemeData snackBarTheme(
    CustomColorScheme colors,
    TextTheme textTheme,
  ) => SnackBarThemeData(
    backgroundColor: colors.primary,
    contentTextStyle: textTheme.bodyMedium,
    actionTextColor: colors.primary,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppRadius.r12)),
    ),
  );


  // Dialog
  static DialogThemeData dialogTheme(
    CustomColorScheme colors,
    TextTheme textTheme,
  ) => DialogThemeData(
    backgroundColor: colors.button,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppRadius.r12)),
    ),
    titleTextStyle: textTheme.titleLarge,
  );

  /*
  // Switch
  static SwitchThemeData switchTheme(CustomColorScheme colors) =>
      SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return colors.onPrimary;
          return colors.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return colors.primary;
          return colors.surfaceContainerHighest;
        }),
      );
*/
  /*
  // CheckBox
  static CheckboxThemeData checkboxTheme(CustomColorScheme colors) =>
      CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return colors.primary;
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(colors.onPrimary),
        side: BorderSide(color: colors.outline, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.r4)),
        ),
      );
*/
  /*
  // FloatingActionButton
  static FloatingActionButtonThemeData fabTheme(CustomColorScheme colors) =>
      FloatingActionButtonThemeData(
        backgroundColor: colors.primaryContainer,
        foregroundColor: colors.onPrimaryContainer,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.r16)),
        ),
      );
*/

  // Drawer
  static DrawerThemeData drawerTheme(CustomColorScheme colors) =>
      DrawerThemeData(backgroundColor: colors.primary, elevation: 0);
  // CircularProgressIndicator
  static ProgressIndicatorThemeData progressIndicatorTheme(
    CustomColorScheme colors,
  ) => ProgressIndicatorThemeData(
    color: colors.button,
    // linearTrackColor: colors.surfaceContainerHighest,
    // circularTrackColor: colors.surfaceContainerHighest,
  );
}
