import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';

class TextFieldItem extends StatelessWidget {
  final String title;
  final String hint;
  final bool isObscured;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final Widget? customPrefixWidget;
  final Widget? customSuffixWidget;

  const TextFieldItem({
    super.key,
    required this.title,
    required this.hint,
    this.isObscured = false,
    this.controller,
    this.customPrefixWidget,
    this.textInputType,
    this.customSuffixWidget,
    this.nextFocus,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppHeight.h8,
      children: [
        Text(title),
        CustomTextField(
          hint: hint,
          controller: controller,
          customPrefixWidget: customPrefixWidget,
          customSuffixWidget: customSuffixWidget,
          isObscured: isObscured,
          focusNode: focusNode,
          nextFocus: nextFocus,
        ),
      ],
    );
  }
}
