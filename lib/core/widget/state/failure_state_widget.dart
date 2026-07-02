import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/padding_extension.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/button/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class FailureStateWidget extends StatelessWidget {
  final String failureMessage;
  final TextStyle? textStyle;
  final VoidCallback? onTap;
  const FailureStateWidget({
    super.key,
    required this.failureMessage,
    this.textStyle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: AppHeight.h6,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(failureMessage, style: textStyle),
          CustomElevatedButton(
            onTap: onTap,
            height: AppHeight.h32,
            customChildWidget: Text(
              context.appLocalization.tryAgain,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.customColorScheme.primary,
              ),
            ),
          ).setHorizontalPaddingOnWidget(AppWidth.w16),
        ],
      ),
    );
  }
}
