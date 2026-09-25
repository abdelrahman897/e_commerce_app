import 'package:e_commerce_app/core/cubit/language/language_cubit.dart';

import 'package:e_commerce_app/core/cubit/onboarding/onboarding_cubit.dart';

import 'package:e_commerce_app/core/cubit/theme/theme_cubit.dart';

import 'package:e_commerce_app/core/l10n/app_localizations.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/theme/theme_manager.dart';
import 'package:e_commerce_app/features/onboarding/screens/main_onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FakeStorage implements Storage {
  final _data = <String, dynamic>{};

  @override
  dynamic read(String key) => _data[key];

  @override
  Future<void> write(String key, dynamic value) async {
    _data[key] = value;
  }

  @override
  Future<void> delete(String key) async {
    _data.remove(key);
  }

  @override
  Future<void> clear() async {
    _data.clear();
  }

  @override
  Future<void> close() async {}
}

Widget createApp(Widget screen, List<BlocProvider> blocs) {
  return ScreenUtilInit(
    designSize: DesignSize.kDesignSize,
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: ThemeManager.light(),
        locale: const Locale(AppConstants.en),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: MultiBlocProvider(providers: blocs, child: screen),
        routes: {
          '/login': (_) => const SizedBox(),
          '/onboardingPages': (_) => const SizedBox(),
        },
      );
    },
  );
}

void main() {
  late LanguageCubit languageCubit;
  late ThemeCubit themeCubit;
  late OnboardingCubit onboardingCubit;

  setUpAll(() async {
    HydratedBloc.storage = FakeStorage();
    SharedPreferences.setMockInitialValues({});
  });

  setUp(() async {
    final prefs = await SharedPreferences.getInstance();
    languageCubit = LanguageCubit();
    themeCubit = ThemeCubit();
    onboardingCubit = OnboardingCubit(prefs: prefs);
  });

  tearDown(() async {
    await languageCubit.close();
    await themeCubit.close();
    await onboardingCubit.close();
  });

  testWidgets('Displays get started button', (tester) async {
    await tester.pumpWidget(
      createApp(const MainOnboardingScreen(), [
        BlocProvider<LanguageCubit>.value(value: languageCubit),
        BlocProvider<ThemeCubit>.value(value: themeCubit),
        BlocProvider<OnboardingCubit>.value(value: onboardingCubit),
      ]),
    );
    await tester.pumpAndSettle();
    expect(find.text('Get Started'), findsOneWidget);
  });

  testWidgets('Displays language section', (tester) async {
    await tester.pumpWidget(
      createApp(const MainOnboardingScreen(), [
        BlocProvider<LanguageCubit>.value(value: languageCubit),
        BlocProvider<ThemeCubit>.value(value: themeCubit),
        BlocProvider<OnboardingCubit>.value(value: onboardingCubit),
      ]),
    );
    await tester.pumpAndSettle();
    expect(find.text('English'), findsOneWidget);
    expect(find.text('Arabic'), findsOneWidget);
  });
}
