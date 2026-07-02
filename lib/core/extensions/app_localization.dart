import 'package:e_commerce_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension AppLocalization on BuildContext {
  AppLocalizations get appLocalization => AppLocalizations.of(this)!;
}
