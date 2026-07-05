import 'package:e_commerce_app/core/cubit/onboarding/onboarding_cubit.dart';
import 'package:e_commerce_app/core/di_core/app_di_core.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/routes_manager/routes.dart';
import 'package:e_commerce_app/features/authentication/presentation/screens/forget_password_screen.dart';
import 'package:e_commerce_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:e_commerce_app/features/authentication/presentation/screens/register_screen.dart';
import 'package:e_commerce_app/features/cart/presentation/screens/cart_product_details_screen.dart';
import 'package:e_commerce_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:e_commerce_app/features/categories/screen/categories_tab_screen.dart';
import 'package:e_commerce_app/features/home/presentation/screens/home_tab_screen.dart';
import 'package:e_commerce_app/features/wishlist/presentation/screens/wishlist_tab_screen.dart';
import 'package:e_commerce_app/features/main_layout/main_layout_screen.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_item.dart';
import 'package:e_commerce_app/features/products/presentation/screens/product_details_screen.dart';
import 'package:e_commerce_app/features/products/presentation/screens/products_screen.dart';
import 'package:e_commerce_app/features/products/presentation/screens/search_product_screen.dart';
import 'package:e_commerce_app/features/authentication/presentation/screens/profile_tab_screen.dart';
import 'package:e_commerce_app/features/onboarding/screens/main_onboarding_screen.dart';
import 'package:e_commerce_app/features/onboarding/screens/onboarding_pages_screen.dart';
import 'package:e_commerce_app/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initial:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.mainOnboardingRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<OnboardingCubit>(),
            child: const MainOnboardingScreen(),
          ),
        );
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
      case Routes.cartRoute:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case Routes.categoriesTabRoute:
        return MaterialPageRoute(builder: (_) => const CategoriesTabScreen());
      case Routes.wishlistTabRoute:
        return MaterialPageRoute(builder: (_) => const WishlistTabScreen());
      case Routes.profileTabRoute:
        return MaterialPageRoute(builder: (_) => const ProfileTabScreen());
      case Routes.cartProductDetailsRoute:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => CartProductDetailsScreen(
            cartItem: args[AppConstants.cartItem],
            productCount: args[AppConstants.productCount],
          ),
        );
      case Routes.productRoute:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) =>
              ProductScreen( categoryId: args[AppConstants.categoryId] as String?,
      brandId: args[AppConstants.brandId] as String?,),
        );
      case Routes.productDetailsRoute:
        final product = settings.arguments as ProductItem;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(product: product),
        );
      case Routes.mainLayoutRoute:
        return MaterialPageRoute(builder: (_) => MainLayoutScreen());
      case Routes.searchProductRoute:
        return MaterialPageRoute(builder: (context) => SearchProductScreen());

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
