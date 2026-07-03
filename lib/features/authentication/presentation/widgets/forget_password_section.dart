import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/widget/button/custom_text_button.dart';
import 'package:flutter/material.dart';

class ForgetPasswordSection extends StatelessWidget {
  final VoidCallback? onPressed; 
const ForgetPasswordSection({ super.key, this.onPressed });

  @override
  Widget build(BuildContext context){
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomTextButton(
            onPressed:onPressed,
            title: context.appLocalization.forgotPassword,
            colorText: context.customColorScheme.button,
          ),
        ],
      ),
    );
  }
}