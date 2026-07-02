import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/button/custom_icon_button.dart';
import 'package:flutter/material.dart';

class ProductCounterButton extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int> onIncrement;
  final ValueChanged<int> onDecrement;
  const ProductCounterButton({
    super.key,
    required this.initialValue,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  State<ProductCounterButton> createState() => _ProductCounterButtonState();
}

class _ProductCounterButtonState extends State<ProductCounterButton> {
  late int _counter = widget.initialValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeight.h40,
      width: AppWidth.w100,
      decoration: BoxDecoration(
        color: context.customColorScheme.button,
        borderRadius: BorderRadius.circular(AppRadius.r20),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppWidth.w8,
        vertical: AppHeight.h4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconButton(
            iconData: Icons.remove_circle_outline,
            onPressed: () {
              if (_counter == 1) return;
              setState(() => _counter--);
              widget.onDecrement(_counter);
            },
            iconSize: AppRadius.r25,
          ),
          Text(
            '$_counter',
            style: context.textTheme.titleMedium?.copyWith(
              color: ColorManager.white,
            ),
          ),
          CustomIconButton(
            iconData: Icons.add_circle_outline,
            onPressed: () {
              setState(() => _counter++);
              widget.onIncrement(_counter);
            },
            iconSize: AppRadius.r25,
          ),
        ],
      ),
    );
  }
}
