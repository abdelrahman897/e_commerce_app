import 'package:e_commerce_app/core/l10n/app_localizations.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/theme/theme_manager.dart';
import 'package:e_commerce_app/features/onboarding/widgets/bottom_onboarding_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  group('BottomOnboardingNavigation', () {
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
              body: BottomOnboardingNavigation(
                currentIndex: currentIndex,
                pageController: pageController,
                count: count,
                isLastPage: isLastPage,
                onPressedPrev: onPressedPrev,
                onPressedNext: onPressedNext,
              ),
            ),
          ),
        );

    testWidgets('Shows next button', (tester) async {
      await tester.pumpWidget(createWidget());
      expect(find.text('Next'), findsOneWidget);
    });

    testWidgets('Hides prev button on first page', (tester) async {
      await tester.pumpWidget(createWidget(currentIndex: 0));
      expect(find.text('Prev'), findsNothing);
    });

    testWidgets('Shows prev button on non-first page', (tester) async {
      await tester.pumpWidget(createWidget(currentIndex: 1));
      expect(find.text('Prev'), findsOneWidget);
    });

    testWidgets('Calls onPressedNext when Next is tapped', (tester) async {
      bool nextCalled = false;
      await tester.pumpWidget(
        createWidget(onPressedNext: () => nextCalled = true),
      );
      await tester.tap(find.text('Next'));
      expect(nextCalled, isTrue);
    });

    testWidgets('Calls onPressedPrev when Prev is tapped', (tester) async {
      bool prevCalled = false;
      await tester.pumpWidget(
        createWidget(
          currentIndex: 1,
          onPressedPrev: () => prevCalled = true,
        ),
      );
      await tester.tap(find.text('Prev'));
      expect(prevCalled, isTrue);
    });

    testWidgets('Displays page indicator', (tester) async {
      await tester.pumpWidget(createWidget(count: 3));
      expect(find.byType(SmoothPageIndicator), findsOneWidget);
    });
  });
}
