import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

final class LanguageState extends Equatable {
  final Locale locale;
  const LanguageState({required this.locale});
  Map<String, dynamic> toJson() => {
    AppConstants.languageCode: locale.languageCode,
  };

  factory LanguageState.fromJson(Map<String, dynamic> json) {
    return LanguageState(
      locale: Locale(
        json[AppConstants.languageCode] as String? ?? AppConstants.en,
      ),
    );
  }

  LanguageState copyWith({Locale? locale}) =>
      LanguageState(locale: locale ?? this.locale);

  @override
  List<Object?> get props => [locale];
}
