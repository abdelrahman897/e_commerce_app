import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "test screen",
          style: TextStyle(
            color: context.customColorScheme.button,
            fontFamily: FontConstants.cairoFontFamily,
            fontSize: FontSize.s36,
          ),
        ),
      ),
    );
  }
}
