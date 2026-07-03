import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class BottomTextSection extends StatelessWidget {
  final String leftText;
  final String rightText;
  final Color rightTextColor;
  final VoidCallback? onTap;
  const BottomTextSection({
    super.key,
    required this.leftText,
    required this.rightText,
    this.onTap,
    required this.rightTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(text: leftText, style: context.textTheme.titleSmall),
            WidgetSpan(
              child: Bounceable(
                onTap: onTap,
                child: Text(
                  rightText,
                  style: TextStyle(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeight.bold,
                    color: rightTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
