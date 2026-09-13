import 'package:bot_toast/bot_toast.dart';
import 'package:device_preview/device_preview.dart';
import 'package:e_commerce_app/core/cubit/language/language_cubit.dart';
import 'package:e_commerce_app/core/cubit/language/language_state.dart';
import 'package:e_commerce_app/core/cubit/theme/theme_cubit.dart';
import 'package:e_commerce_app/core/cubit/theme/theme_state.dart';
import 'package:e_commerce_app/core/di_core/app_di_core.dart';
import 'package:e_commerce_app/core/di_core/di_initializer.dart';
import 'package:e_commerce_app/core/l10n/app_localizations.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/routes_manager/route_generator.dart';
import 'package:e_commerce_app/core/routes_manager/routes.dart';
import 'package:e_commerce_app/core/services/bloc_observer.dart';
import 'package:e_commerce_app/core/services/loading_service.dart';
import 'package:e_commerce_app/core/theme/app_colors_schemes.dart';
import 'package:e_commerce_app/core/theme/theme_manager.dart';
import 'package:e_commerce_app/features/authentication/presentation/manager/authentication_bloc.dart';
import 'package:e_commerce_app/features/cart/presentation/manager/cart_bloc.dart';
import 'package:e_commerce_app/features/home/presentation/manager/home_bloc.dart';
import 'package:e_commerce_app/features/products/presentation/manager/product_bloc.dart';
import 'package:e_commerce_app/features/wishlist/presentation/manager/wishlist_bloc.dart';
import 'package:e_commerce_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  await DiInitializer.init();
  configLoading();

  final themeMode = getIt<ThemeCubit>().state.themeMode;
  ThemeManager.syncStatusBar(
    themeMode == ThemeMode.dark
        ? AppColorSchemes.darkScheme
        : AppColorSchemes.lightScheme,
  );
  

  runApp(DevicePreview(enabled: false, builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ThemeCubit>()),
        BlocProvider(create: (_) => getIt<LanguageCubit>()),
        BlocProvider(create: (_) => getIt<AuthenticationBloc>()),
        BlocProvider(create: (_) => getIt<ProductBloc>()),
        BlocProvider(create: (_) => getIt<CartBloc>()),
        BlocProvider(create: (_) => getIt<WishlistBloc>()),
        BlocProvider(create: (_) => getIt<HomeBloc>()),
      ],
      child: ScreenUtilInit(
        designSize: DesignSize.kDesignSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            buildWhen: (prev, curr) => prev.themeMode != curr.themeMode,
            builder: (context, themeState) {
              return BlocBuilder<LanguageCubit, LanguageState>(
                buildWhen: (prev, curr) => prev.locale != curr.locale,
                builder: (context, languageState) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: AppStrings.appTitle,
                    themeMode: themeState.themeMode,
                    theme: ThemeManager.light(),
                    darkTheme: ThemeManager.dark(),
                    onGenerateRoute: RouteGenerator.getRoute,
                    initialRoute: Routes.initial,
                    locale: languageState.locale,
                    supportedLocales: AppLocalizations.supportedLocales,
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    builder: (context, child) {
                      child = DevicePreview.appBuilder(context, child);
                      child = BotToastInit()(context, child);
                      return EasyLoading.init()(context, child);
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
