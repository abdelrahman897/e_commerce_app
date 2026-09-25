import 'package:e_commerce_app/core/l10n/app_localizations.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/theme/theme_manager.dart';
import 'package:e_commerce_app/features/onboarding/widgets/onboarding_page_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnboardingPageItem', () {
    late PageController pageController;

    setUp(() {
      pageController = PageController();
    });

    tearDown(() {
      pageController.dispose();
    });

    Widget createWidget({
      int currentIndex = 0,
      int count = 3,
      bool isLastPage = false,
      VoidCallback? onPressedPrev,
      VoidCallback? onPressedNext,
    }) =>
        ScreenUtilInit(
          designSize: DesignSize.kDesignSize,
          builder: (context, child) => MaterialApp(
            theme: ThemeManager.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: OnboardingPageItem(
                currentIndex: currentIndex,
                imagePath: '',
                title: 'Test Title',
                body: 'Test Body',
                count: count,
                pageController: pageController,
                isLastPage: isLastPage,
                onPressedPrev: onPressedPrev,
                onPressedNext: onPressedNext,
              ),
            ),
          ),
        );

    Future<void> pumpSafe(WidgetTester tester, Widget widget) async {
      final original = FlutterError.onError;
      FlutterError.onError = (details) {
        if (details.exceptionAsString().contains('Unable to load asset')) {
          return;
        }
        original?.call(details);
      };
      addTearDown(() => FlutterError.onError = original);
      await tester.pumpWidget(widget);
    }

    testWidgets('Displays title and body', (tester) async {
      await pumpSafe(tester, createWidget());
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Body'), findsOneWidget);
    });

    testWidgets('Displays Next button', (tester) async {
      await pumpSafe(tester, createWidget());
      expect(find.text('Next'), findsOneWidget);
    });

    testWidgets('Displays Prev button when not on first page', (tester) async {
      await pumpSafe(tester, createWidget(currentIndex: 1));
      expect(find.text('Prev'), findsOneWidget);
    });

    testWidgets('Hides Prev button on first page', (tester) async {
      await pumpSafe(tester, createWidget(currentIndex: 0));
      expect(find.text('Prev'), findsNothing);
    });

    testWidgets('Displays image', (tester) async {
      await pumpSafe(tester, createWidget());
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('Calls onPressedNext when Next is tapped', (tester) async {
      bool nextCalled = false;
      await pumpSafe(
        tester,
        createWidget(onPressedNext: () => nextCalled = true),
      );
      await tester.tap(find.text('Next'));
      expect(nextCalled, isTrue);
    });
  });
}
