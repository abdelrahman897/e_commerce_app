import 'package:e_commerce_app/core/resources/constants_manager.dart';

enum ThemeModePreference {
  light,
  dark;

  String toStorageValue() => switch (this) {
    ThemeModePreference.light => ThemeConstants.lightModeValue,
    ThemeModePreference.dark => ThemeConstants.darkModeValue,
  };
  static ThemeModePreference fromStorageValue(String value) => switch (value) {
    ThemeConstants.lightModeValue => ThemeModePreference.light,
    ThemeConstants.darkModeValue => ThemeModePreference.dark,
    _ => ThemeModePreference.light,
  };
}
