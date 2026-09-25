import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/theme/theme_manager.dart';
import 'package:e_commerce_app/features/onboarding/widgets/select_item_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SelectItemRow', () {
    const tLabel = 'Language';

    Widget createWidget({
      bool isFirstSelected = true,
      VoidCallback? onTapFirst,
      VoidCallback? onTapSecond,
      Widget? customFirstChild,
      Widget? customSecondChild,
    }) =>
        ScreenUtilInit(
          designSize: DesignSize.kDesignSize,
          builder: (context, child) => MaterialApp(
            theme: ThemeManager.light(),
            home: Scaffold(
              body: SelectItemRow(
                label: tLabel,
                isFirstSelected: isFirstSelected,
                onTapFirst: onTapFirst ?? () {},
                onTapSecond: onTapSecond ?? () {},
                customFirstChild: customFirstChild ?? const Text('First'),
                customSecondChild: customSecondChild ?? const Text('Second'),
              ),
            ),
          ),
        );

    testWidgets('Displays the label', (tester) async {
      await tester.pumpWidget(createWidget());
      expect(find.text(tLabel), findsOneWidget);
    });

    testWidgets('Displays both child widgets', (tester) async {
      await tester.pumpWidget(createWidget());
      expect(find.text('First'), findsOneWidget);
      expect(find.text('Second'), findsOneWidget);
    });

    testWidgets('Calls onTapFirst when first button is tapped',
        (tester) async {
      bool firstTapped = false;
      await tester.pumpWidget(
        createWidget(
          onTapFirst: () => firstTapped = true,
        ),
      );
      await tester.tap(find.text('First'));
      expect(firstTapped, isTrue);
    });

    testWidgets('Calls onTapSecond when second button is tapped',
        (tester) async {
      bool secondTapped = false;
      await tester.pumpWidget(
        createWidget(
          onTapSecond: () => secondTapped = true,
        ),
      );
      await tester.tap(find.text('Second'));
      expect(secondTapped, isTrue);
    });
  });
}
