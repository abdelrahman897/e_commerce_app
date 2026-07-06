import 'package:e_commerce_app/core/extensions/padding_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PaymentDialog extends StatelessWidget {
  final String imagePath;
  final String message;
  const PaymentDialog({
    super.key,
    required this.imagePath,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      child:
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppHeight.h12,
            children: [SvgPicture.asset(imagePath), Text(message)],
          ).setHorizontalAndVerticalPadding(
            context,
            AppWidth.w24,
            AppHeight.h32,
            enableMediaQuery: false,
          ),
    ).setHorizontalPaddingOnWidget(AppWidth.w16);
  }
}
