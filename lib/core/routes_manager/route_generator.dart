import 'package:e_commerce_app/core/cubit/onboarding/onboarding_cubit.dart';
import 'package:e_commerce_app/core/di_core/app_di_core.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/routes_manager/routes.dart';
import 'package:e_commerce_app/features/authentication/presentation/screens/forget_password_screen.dart';
import 'package:e_commerce_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:e_commerce_app/features/authentication/presentation/screens/register_screen.dart';
import 'package:e_commerce_app/features/cart/presentation/screens/cart_product_details_screen.dart';
import 'package:e_commerce_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:e_commerce_app/features/categories/presentation/screens/categories_tab_screen.dart';
import 'package:e_commerce_app/features/checkout/presentation/manager/payment_bloc.dart';
import 'package:e_commerce_app/features/checkout/presentation/screens/checkout_screen.dart';
import 'package:e_commerce_app/features/home/presentation/manager/home_bloc.dart';
import 'package:e_commerce_app/features/home/presentation/screens/home_tab_screen.dart';
import 'package:e_commerce_app/features/products/presentation/manager/product_bloc.dart';
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
import 'package:e_commerce_app/test_screen.dart';
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
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<HomeBloc>()),
              BlocProvider(create: (context) => getIt<ProductBloc>()),
            ],
            child: const HomeTabScreen(),
          ),
        );
      case Routes.cartRoute:
        return MaterialPageRoute(builder: (_) => CartScreen());
      case Routes.categoriesTabRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<HomeBloc>(),
            child: const CategoriesTabScreen(),
          ),
        );
      case Routes.wishlistTabRoute:
        return MaterialPageRoute(builder: (_) => WishlistTabScreen());
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
          builder: (_) => BlocProvider<ProductBloc>(
            create: (_) => getIt<ProductBloc>(),
            child: ProductScreen(
              categoryId: args[AppConstants.categoryId] as String?,
              brandId: args[AppConstants.brandId] as String?,
            ),
          ),
        );
      case Routes.productDetailsRoute:
        final product = settings.arguments as ProductItem;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(product: product),
        );
      case Routes.mainLayoutRoute:
        return MaterialPageRoute(builder: (_) => const MainLayoutScreen());
      case Routes.searchProductRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ProductBloc>(
            create: (_) => getIt<ProductBloc>(),
            child: SearchProductScreen(),
          ),
        );
      case Routes.checkoutRoute:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<PaymentBloc>(),
            child: CheckoutScreen(
              orderPrice: args[AppConstants.orderPrice] as int,
              productName: args[AppConstants.productName] as String,
              quantity: args[AppConstants.quantity] as int,
            ),
          ),
        );
      case Routes.testRoute:
        return MaterialPageRoute(builder: (_) => const TestScreen());

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
