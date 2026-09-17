import 'package:bot_toast/bot_toast.dart';
import 'package:e_commerce_app/core/l10n/app_localizations.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

extension AppWidgetTester on WidgetTester {
  Future<void> pumpApp({
    required Widget screen,
    List<BlocProvider> blocs = const [],
    Locale language = const Locale(AppConstants.en),
    Map<String, WidgetBuilder> routes = const {},
  }) async {
    await binding.setSurfaceSize(DesignSize.kDesignSize);
    view.devicePixelRatio = 1.0;
    await pumpWidget(
      ScreenUtilInit(
        designSize: DesignSize.kDesignSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: ThemeManager.light(),
            darkTheme: ThemeManager.dark(),
            locale: language,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            builder: (context, child) {
              child = BotToastInit()(context, child);
              return EasyLoading.init()(context, child);
            },
            navigatorObservers: [BotToastNavigatorObserver()],
            onGenerateRoute: (settings) => MaterialPageRoute(
              settings: settings,
              builder: (_) => const Scaffold(
                body: Center(child: Text('Mock Screen')),
              ),
            ),
            home: MultiBlocProvider(providers: blocs, child: screen),
          );
        },
      ),
    );
    await pump();
  }
}
