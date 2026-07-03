import 'package:e_commerce_app/core/cubit/onboarding/onboarding_cubit.dart';
import 'package:e_commerce_app/core/di_core/app_di_core.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/routes_manager/routes.dart';
import 'package:e_commerce_app/features/onboarding/screens/onboarding_pages_screen.dart';
import 'package:e_commerce_app/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initial:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.onboardingPagesRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<OnboardingCubit>(),
            child: const OnboardingPagesScreen(),
          ),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text(AppStrings.noRouteFound)),
        body: const Center(child: Text(AppStrings.noRouteFound)),
      ),
    );
  }
}
