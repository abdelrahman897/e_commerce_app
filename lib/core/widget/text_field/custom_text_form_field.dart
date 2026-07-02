import 'package:e_commerce_app/core/extensions/padding_extension.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool isObscured;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final Widget? customPrefixWidget;
  final int? maxLines;
  final bool readOnly;
  final TextInputType? textInputType;
  final ValueChanged<String>? onFieldSubmitted;
  final Widget? customSuffixWidget;

  const CustomTextFormField({
    super.key,
    required this.hint,
    this.controller,
    this.validator,
    this.isObscured = false,
    this.customPrefixWidget,
    this.maxLines = 1,
    this.onFieldSubmitted,
    this.customSuffixWidget,
    this.readOnly = false,
    this.focusNode,
    this.textInputType,
    this.nextFocus,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      focusNode: focusNode,
      readOnly: readOnly,
      keyboardType: textInputType,
      style: context.textTheme.bodyLarge?.copyWith(
        color: context.customColorScheme.text,
      ),
      cursorColor: context.customColorScheme.button,
      obscureText: isObscured,
      maxLines: isObscured ? 1 : maxLines,
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: () {
        focusNode?.unfocus();
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },

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
