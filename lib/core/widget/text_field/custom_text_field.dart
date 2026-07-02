import 'package:e_commerce_app/core/extensions/padding_extension.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final bool isObscured;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final ValueChanged<String>? onSubmitted;
  final Widget? customPrefixWidget;
  final int? maxLines;
  final bool readOnly;
  final TextInputType? textInputType;
  final Widget? customSuffixWidget;

  const CustomTextField({
    super.key,
    required this.hint,
    this.controller,
    this.isObscured = false,
    this.customPrefixWidget,
    this.maxLines = 1,
    this.customSuffixWidget,
    this.readOnly = false,
    this.focusNode,
    this.textInputType,
    this.nextFocus,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      readOnly: readOnly,
      keyboardType: textInputType,
      style: context.textTheme.bodyLarge?.copyWith(
        color: context.customColorScheme.text,
      ),
      cursorColor: context.customColorScheme.button,
      obscureText: isObscured,
      maxLines: isObscured ? 1 : maxLines,

      onEditingComplete: () {
        focusNode?.unfocus();
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      onSubmitted: onSubmitted,
      textInputAction: nextFocus != null
          ? TextInputAction.next
          : TextInputAction.done,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: customPrefixWidget?.setHorizontalAndVerticalPadding(
          context,
          AppWidth.w10,
          AppHeight.h10,
          enableMediaQuery: false,
        ),
        suffixIcon: customSuffixWidget?.setHorizontalAndVerticalPadding(
          context,
          AppWidth.w10,
          AppHeight.h10,
          enableMediaQuery: false,
        ),
      ),
    );
  }
}
