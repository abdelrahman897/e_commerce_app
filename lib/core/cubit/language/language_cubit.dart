import 'dart:ui';
import 'package:e_commerce_app/core/cubit/language/language_state.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class LanguageCubit extends HydratedCubit<LanguageState> {
  LanguageCubit() : super(const LanguageState(locale: Locale(AppConstants.en)));

  void setLanguage(Locale locale) => emit(state.copyWith(locale: locale));

  void toggleLanguage() {
    final next = state.locale.languageCode == AppConstants.ar
        ? const Locale(AppConstants.en)
        : const Locale(AppConstants.ar);
    setLanguage(next);
  }

  @override
  LanguageState? fromJson(Map<String, dynamic> json) =>
      LanguageState.fromJson(json);
  @override
  Map<String, dynamic>? toJson(LanguageState state) => state.toJson();
}
