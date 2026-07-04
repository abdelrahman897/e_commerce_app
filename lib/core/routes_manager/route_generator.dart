import 'package:e_commerce_app/core/cubit/onboarding/onboarding_cubit.dart';
import 'package:e_commerce_app/core/di_core/app_di_core.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/routes_manager/routes.dart';
import 'package:e_commerce_app/features/authentication/presentation/screens/forget_password_screen.dart';
import 'package:e_commerce_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:e_commerce_app/features/authentication/presentation/screens/profile_tab_screen.dart';
import 'package:e_commerce_app/features/authentication/presentation/screens/register_screen.dart';
import 'package:e_commerce_app/features/categories/screen/categories_tab_screen.dart';
import 'package:e_commerce_app/features/home/screen/home_tab_screen.dart';
import 'package:e_commerce_app/features/onboarding/screens/onboarding_pages_screen.dart';
import 'package:e_commerce_app/features/splash/splash_screen.dart';
import 'package:e_commerce_app/features/wishlist/screen/wishlist_tab_screen.dart';
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
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
      case Routes.homeTabRoute:
        return MaterialPageRoute(builder: (_) => HomeTabScreen());
      case Routes.categoriesTabRoute:
        return MaterialPageRoute(builder: (_) => const CategoriesTabScreen());
      case Routes.wishlistTabRoute:
        return MaterialPageRoute(builder: (_) => const WishlistTabScreen());
      case Routes.profileTabRoute:
        return MaterialPageRoute(builder: (_) => const ProfileTabScreen());
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
