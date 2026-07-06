import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/button/custom_bounceable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentMethodSection extends StatelessWidget {
  final ValueChanged<int> onSelectedItem;
  final int selectedIndex;
  const PaymentMethodSection({
    super.key,
    required this.onSelectedItem,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    List<String> itemList = [
      Assets.icons.masterCardIcn.path,
      Assets.icons.visaIcn.path,
      Assets.icons.paypalIcn.path,
    ];
    return Column(
      children: List.generate(3, (index) {
        final isSelected = index == selectedIndex;
        return Padding(
          padding: EdgeInsets.only(bottom: AppHeight.h8),
          child: CustomBounceableButton(
            height: AppHeight.h55,
            backgroundColor: isSelected
                ? ColorManager.grey
                : context.customColorScheme.container,
            borderRadius: AppRadius.r16,
            borderColor: isSelected
                ? context.customColorScheme.button
                : ColorManager.transparent,
            onTap: () => onSelectedItem(index),
            customChildWidget: Padding(
              padding:  EdgeInsets.symmetric(horizontal: AppWidth.w8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(itemList[index]),
                  Text(
                    AppConstants.fixedNumber,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? context.customColorScheme.primary
                          : ColorManager.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
