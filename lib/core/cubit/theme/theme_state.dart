import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

final class ThemeState extends Equatable {
  final ThemeMode themeMode;
  const ThemeState({required this.themeMode});

  Map<String, dynamic> toJson() => {AppConstants.themeMode: themeMode.name};

  factory ThemeState.fromJson(Map<String, dynamic> json) {
    return ThemeState(
      themeMode: ThemeMode.values.firstWhere(
        (element) => element.name == json[AppConstants.themeMode],
        orElse: () => ThemeMode.light,
      ),
    );
  }

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(themeMode: themeMode ?? this.themeMode);
  }

  @override
  List<Object?> get props => [themeMode];
}
