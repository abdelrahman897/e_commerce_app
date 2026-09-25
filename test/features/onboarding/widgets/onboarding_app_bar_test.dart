import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/theme/theme_manager.dart';
import 'package:e_commerce_app/features/onboarding/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnboardingAppBar', () {
    Widget createWidget({
      required Widget customLeadingWidget,
      required List<Widget> customActionsWidgets,
    }) =>
        ScreenUtilInit(
          designSize: DesignSize.kDesignSize,
          builder: (context, child) => MaterialApp(
            theme: ThemeManager.light(),
            home: Scaffold(
              appBar: OnboardingAppBar(
                customLeadingWidget: customLeadingWidget,
                customActionsWidgets: customActionsWidgets,
              ),
            ),
          ),
        );

    testWidgets('Displays the leading widget', (tester) async {
      await tester.pumpWidget(
        createWidget(
          customLeadingWidget: const Text('Leading'),
          customActionsWidgets: [],
        ),
      );
      expect(find.text('Leading'), findsOneWidget);
    });

    testWidgets('Displays the action widgets', (tester) async {
      await tester.pumpWidget(
        createWidget(
          customLeadingWidget: const SizedBox.shrink(),
          customActionsWidgets: [
            TextButton(
              onPressed: () {},
              child: const Text('Skip'),
            ),
          ],
        ),
      );
      expect(find.text('Skip'), findsOneWidget);
    });

    testWidgets('preferredSize is kToolbarHeight', (tester) async {
      final appBar = OnboardingAppBar(
        customLeadingWidget: const SizedBox.shrink(),
        customActionsWidgets: [],
      );
      expect(appBar.preferredSize, equals(const Size.fromHeight(kToolbarHeight)));
    });
  });
}
