import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/button/custom_bounceable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentMethodSection extends StatefulWidget {
  final ValueChanged<int> onSelectedItem;
  final int initialSelectedIndex;
  const PaymentMethodSection({
    super.key,
    required this.onSelectedItem,
    this.initialSelectedIndex = 0,
  });

  @override
  State<PaymentMethodSection> createState() => _PaymentMethodSectionState();
}

class _PaymentMethodSectionState extends State<PaymentMethodSection> {
  late int _selectedIndex;
  final List<String> _paymentIcons = [
    Assets.icons.masterCardIcn.path,
    Assets.icons.visaIcn.path,
    Assets.icons.paypalIcn.path,
  ];
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialSelectedIndex;
  }

  void _handleTap(int index) {
    if (_selectedIndex == index) return;
    // setState is scoped to this widget only — the checkout screen above
    // it is completely unaffected by a payment-method change.
    setState(() => _selectedIndex = index);
    widget.onSelectedItem.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(_paymentIcons.length, (index) {
        final isSelected = index == _selectedIndex;
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
            onTap: () => _handleTap(index),
            customChildWidget: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.w8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(_paymentIcons[index]),
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
