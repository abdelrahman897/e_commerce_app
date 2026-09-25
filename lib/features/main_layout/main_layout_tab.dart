import 'package:e_commerce_app/core/di_core/app_di_core.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/l10n/app_localizations.dart';
import 'package:e_commerce_app/features/authentication/presentation/screens/profile_tab_screen.dart';
import 'package:e_commerce_app/features/categories/presentation/screens/categories_tab_screen.dart';
import 'package:e_commerce_app/features/home/presentation/manager/home_bloc.dart';
import 'package:e_commerce_app/features/home/presentation/screens/home_tab_screen.dart';
import 'package:e_commerce_app/features/products/presentation/manager/product_bloc.dart';
import 'package:e_commerce_app/features/wishlist/presentation/screens/wishlist_tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef TabLabelResolver = String Function(AppLocalizations l10n);

/// Describes one tab of the main layout: how it looks in the bottom
/// navigation bar and how its screen is built.
///
/// Adding a new tab only requires adding an entry to [all].
class MainLayoutTab {
  const MainLayoutTab({
    required this.iconPath,
    required this.label,
    required this.builder,
  });

  final String iconPath;
  final TabLabelResolver label;

  /// Called lazily, the first time the tab is opened.
  /// Provide the tab's own `BlocProvider` here if it needs one.
  final WidgetBuilder builder;

  static final List<MainLayoutTab> all = List.unmodifiable([
    MainLayoutTab(
      iconPath: Assets.icons.homeIcn.path,
      label: (l10n) => l10n.home,
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<HomeBloc>()),
          BlocProvider(create: (context) => getIt<ProductBloc>()),
        ],
        child: HomeTabScreen(),
      ),
    ),
    MainLayoutTab(
      iconPath: Assets.icons.categoryIcn.path,
      label: (l10n) => l10n.category,
      builder: (_) => BlocProvider(
        create: (context) => getIt<HomeBloc>(),
        child: CategoriesTabScreen(),
      ),
    ),
    MainLayoutTab(
      iconPath: Assets.icons.heartIcn.path,
      label: (l10n) => l10n.wishList,
      builder: (_) => WishlistTabScreen(),
    ),
    MainLayoutTab(
      iconPath: Assets.icons.userIcn.path,
      label: (l10n) => l10n.profile,
      builder: (_) => ProfileTabScreen(),
    ),
  ]);
}
