import 'package:e_commerce_app/core/cubit/language/language_cubit.dart';
import 'package:e_commerce_app/core/cubit/onboarding/onboarding_cubit.dart';
import 'package:e_commerce_app/core/cubit/theme/theme_cubit.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  // ── Core Cubits ───────────────────────────────────────────────────────────
  LanguageCubit,
  ThemeCubit,
  OnboardingCubit,
])
void main() {}
