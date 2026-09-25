import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/theme/theme_manager.dart';
import 'package:e_commerce_app/features/onboarding/widgets/paragraph_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ParagraphSection', () {
    const tTitle = 'Test Title';
    const tBody = 'Test Body Content';

    Widget createWidget() => ScreenUtilInit(
      designSize: DesignSize.kDesignSize,
      builder: (context, child) => MaterialApp(
        theme: ThemeManager.light(),
        home: Scaffold(
          body: ParagraphSection(title: tTitle, body: tBody),
        ),
      ),
    );

    testWidgets('Displays the title text', (tester) async {
      await tester.pumpWidget(createWidget());
      expect(find.text(tTitle), findsOneWidget);
    });

    testWidgets('Displays the body text', (tester) async {
      await tester.pumpWidget(createWidget());
      expect(find.text(tBody), findsOneWidget);
    });

    testWidgets('Title is centered', (tester) async {
      await tester.pumpWidget(createWidget());
      final titleWidget = tester.widget<Text>(find.text(tTitle));
      expect(titleWidget.textAlign, equals(TextAlign.center));
    });

    testWidgets('Body is centered with max 4 lines', (tester) async {
      await tester.pumpWidget(createWidget());
      final bodyWidget = tester.widget<Text>(find.text(tBody));
      expect(bodyWidget.textAlign, equals(TextAlign.center));
      expect(bodyWidget.maxLines, equals(4));
    });
  });
}
