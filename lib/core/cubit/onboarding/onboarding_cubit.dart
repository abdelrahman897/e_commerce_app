import 'package:e_commerce_app/core/cubit/onboarding/onboarding_state.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({required SharedPreferences prefs})
    : _prefs = prefs,
      super(
        OnboardingState(isComplete: prefs.getBool(_keyOnboarding) ?? false),
      );
  final SharedPreferences _prefs;

  static const String _keyOnboarding = AppStorageKeys.onboardingCompleted;

  Future<void> completeOnboarding() async {
    if (state.isComplete) return;
    await _prefs.setBool(_keyOnboarding, true);
    if (isClosed) return;
    emit(const OnboardingState(isComplete: true));
  }
}
